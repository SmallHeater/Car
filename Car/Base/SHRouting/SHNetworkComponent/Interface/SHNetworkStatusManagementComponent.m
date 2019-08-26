//
//  SHNetworkStatusManagementComponent.m
//  SHNetworkStatusManagementComponent
//
//  Created by xianjun wang on 2019/7/3.
//  Copyright © 2019 xianjun wang. All rights reserved.
//

#import "SHNetworkStatusManagementComponent.h"
#import "RealReachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation SHNetworkStatusManagementComponent

#pragma mark  ----  生命周期函数

+(SHNetworkStatusManagementComponent *)sharedManager{
    
    static SHNetworkStatusManagementComponent * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
        //预先开启网络测试
        [[RealReachability sharedInstance] startNotifier];
        
        //开启网络状态变化的监听
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(realReachabilityChanged) name:kRealReachabilityChangedNotification object:nil];
        //开启VPN状态变化的监听
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(VPNStatusChanged) name:kRRVPNStatusChangedNotification object:nil];
    });
    
    //防止子类重载调用使用
    NSString * classString = NSStringFromClass([self class]);
    if (![classString isEqualToString:@"SHNetworkStatusManagementComponent"]) {
        
        NSParameterAssert(nil); //填nil会导致程序崩溃
    }
    
    return manager;
}

//重写创建对象空间的方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    //防止子类重载调用使用
    NSString * classString = NSStringFromClass([self class]);
    if (![classString isEqualToString:@"SHNetworkStatusManagementComponent"]) {
        
        NSParameterAssert(nil); //填nil会导致程序崩溃
    }
    return [self sharedManager];
}

//重写copy
-(id)copy{
    
    return [self.class sharedManager];
}

//重写mutableCopy
-(id)mutableCopy{
    
    return [self.class sharedManager];
}

#pragma mark  ----  自定义函数

-(SHNetworkStatus)currentNetworkStatus{
    
    ReachabilityStatus status = [[RealReachability sharedInstance] currentReachabilityStatus];
    SHNetworkStatus networkStatus = SHNetworkStatusUnknown;
    switch (status) {
        case RealStatusUnknown:
            networkStatus = SHNetworkStatusUnknown;
            break;
        case RealStatusNotReachable:
            networkStatus = SHNetworkStatusNotReachable;
            break;
        case RealStatusViaWWAN:
            networkStatus = SHNetworkStatusViaWWAN;
            break;
        case RealStatusViaWiFi:
            networkStatus = SHNetworkStatusViaWiFi;
            break;
        default:
            break;
    }
    return networkStatus;
}

- (SHWWANType)currentWWANtype{
    
    WWANAccessType status = [[RealReachability sharedInstance] currentWWANtype];
    SHWWANType networkStatus = SHWWANTypeUnknown;
    switch (status) {
        case WWANTypeUnknown:
            networkStatus = SHWWANTypeUnknown;
            break;
        case WWANType4G:
            networkStatus = SHWWANType4G;
            break;
        case WWANType3G:
            networkStatus = SHWWANType3G;
            break;
        case WWANType2G:
            networkStatus = SHWWANType2G;
            break;
        default:
            break;
    }
    return networkStatus;
}


- (BOOL)isVPNOn{
    
    return [[RealReachability sharedInstance] isVPNOn];
}

//网络状态变化的响应函数
-(void)realReachabilityChanged{
    
     SHNetworkStatus networkStatus = [self currentNetworkStatus];
     SHWWANType wwanStatus = [self currentWWANtype];
    if (self.networkStatusCallBack) {
        
        self.networkStatusCallBack(networkStatus, wwanStatus);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(networkStatusChangedWithNetworkStatus:WWANType:)]) {
        
        [self.delegate networkStatusChangedWithNetworkStatus:networkStatus WWANType:wwanStatus];
    }
}


//VPN状态变化的响应函数
-(void)VPNStatusChanged{
    
    BOOL isOn = [self isVPNOn];
    if (self.VPNStatusCallBack) {
        
        self.VPNStatusCallBack(isOn);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(VPNStatusChangedIsOn:)]) {
        
        [self.delegate VPNStatusChangedIsOn:isOn];
    }
}

-(SHWWANOperatorType)currentWWANOperatorType{
    
    SHWWANOperatorType operatorType = SHWWANOperatorTypeUnknown;
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    //忽略两个编译警告
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    //版本兼容
    CTCarrier *carrier;
    if (@available(iOS 12.0, *)) {
        
        NSDictionary * dic = networkInfo.serviceSubscriberCellularProviders;
        carrier = dic.allValues.firstObject;
    }
    else{
        
        carrier = networkInfo.subscriberCellularProvider;
    }
    
    NSString *carrier_country_code = carrier.isoCountryCode;
    
    if (carrier_country_code == nil) {
        
        carrier_country_code = @"";
    }
    
    //国家编号
    NSString *CountryCode = carrier.mobileCountryCode;
    
    if (CountryCode == nil) {
        
        CountryCode = @"";
    }
    
    //网络供应商编码
    NSString *NetworkCode = carrier.mobileNetworkCode;
    
    if (NetworkCode == nil){
        
        NetworkCode = @"";
    }
    
    NSString *mobile_country_code = [NSString stringWithFormat:@"%@%@",CountryCode,NetworkCode];
    
    if (mobile_country_code == nil){
        
        mobile_country_code = @"";
    }
    
    NSString *code = [carrier mobileNetworkCode];
    
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        
        //移动
        operatorType = SHWWANOperatorTypeCMCC;
    }
    else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"]){
        
        // ret = @"电信";
        operatorType = SHWWANOperatorTypeCTCC;
    }
    else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"]){
        
        // ret = @"联通";
        operatorType = SHWWANOperatorTypeCUCC;
    }
    
    return operatorType;
}

-(BOOL)isNetwork{
    
    BOOL isNetWork = YES;
    
    if ([self currentNetworkStatus] == SHNetworkStatusNotReachable) {
        
        isNetWork = NO;
    }
    
    return isNetWork;
}

@end
