//
//  SHNetworkStatusManagementComponent.h
//  SHNetworkStatusManagementComponent
//
//  Created by xianjun wang on 2019/7/3.
//  Copyright © 2019 xianjun wang. All rights reserved.
//  网络状态管理接口类

#import <Foundation/Foundation.h>

//网络类型
typedef NS_ENUM(NSInteger, SHNetworkStatus) {
    
    SHNetworkStatusUnknown = -1,//未知
    SHNetworkStatusNotReachable = 0,//无网
    SHNetworkStatusViaWWAN = 1,//流量
    SHNetworkStatusViaWiFi = 2//wifi
};

//移动网络类型
typedef NS_ENUM(NSInteger, SHWWANType) {
    SHWWANTypeUnknown = -1, /// maybe iOS6，未知
    SHWWANType2G = 0, //2G
    SHWWANType3G = 1, //3G
    SHWWANType4G = 2  //4G
};


//运营商类型
typedef NS_ENUM(NSUInteger,SHWWANOperatorType) {
    
    SHWWANOperatorTypeUnknown = -1,//未知
    SHWWANOperatorTypeCMCC = 0,//移动
    SHWWANOperatorTypeCUCC = 1,//联通
    SHWWANOperatorTypeCTCC = 2 //电信
};


typedef void(^NetworkStatusCallBack)(SHNetworkStatus networkStatus,SHWWANType WWANType);

typedef void(^VPNStatusCallBack)(BOOL isOn);

/**
 代理
 */
@protocol NetworkStatusChangeDelegate <NSObject>


/**
 网络状态变化的回调函数

 @param networkStatus 网络类型
 @param WWANType 移动网络类型
 */
-(void)networkStatusChangedWithNetworkStatus:(SHNetworkStatus)networkStatus WWANType:(SHWWANType)WWANType;

/**
 VPN状态变化的回调函数

 @param isOn 是否开启VPN
 */
-(void)VPNStatusChangedIsOn:(BOOL)isOn;

@end


@interface SHNetworkStatusManagementComponent : NSObject

//网络状态变化的回调
@property (nonatomic,copy) NetworkStatusCallBack networkStatusCallBack;

//VPN状态变化的回调
@property (nonatomic,copy) VPNStatusCallBack VPNStatusCallBack;

@property (nonatomic,weak) id<NetworkStatusChangeDelegate>delegate;

/**
 实例化函数

 @return 对象实例
 */
+(SHNetworkStatusManagementComponent *)sharedManager;

/**
 返回当前网络类型的函数

 @return 网络类型
 */
-(SHNetworkStatus)currentNetworkStatus;

/**
 返回当前移动网络类型的函数

 @return 移动网络类型
 */
- (SHWWANType)currentWWANtype;

/**
 返回是否开启VPN的函数

 @return 是否开启VPN
 */
- (BOOL)isVPNOn;


/**
 返回移动网络运营商类型的函数

 @return 移动网络运营商
 */
-(SHWWANOperatorType)currentWWANOperatorType;


/**
 返回有无网络的函数

 @return 有无网络的BOOL值
 */
-(BOOL)isNetwork;

@end
