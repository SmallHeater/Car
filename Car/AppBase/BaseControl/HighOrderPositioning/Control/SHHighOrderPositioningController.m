//
//  HighOrderPositioningController.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHHighOrderPositioningController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

static SHHighOrderPositioningController * manager = nil;

@interface SHHighOrderPositioningController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation SHHighOrderPositioningController

#pragma mark  ----  生命周期函数

+(SHHighOrderPositioningController *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SHHighOrderPositioningController alloc] init];
        [[AMapServices sharedServices] setEnableHTTPS:YES];
        //高德key
        [AMapServices sharedServices].apiKey =@"5e116354fbf19bc9a2e3a1e091dbdd5a";
        
        
        
        manager.locationManager = [[AMapLocationManager alloc] init];
        [manager.locationManager setDelegate:manager];
        //设置期望定位精度
        [manager.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //设置不允许系统暂停定位
        [manager.locationManager setPausesLocationUpdatesAutomatically:NO];
        //设置允许在后台定位
        //        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        //设置定位超时时间
        [manager.locationManager setLocationTimeout:2];
        //设置逆地理超时时间
        [manager.locationManager setReGeocodeTimeout:2];
        //设置开启虚拟定位风险监测，可以根据需要开启
        [manager.locationManager setDetectRiskOfFakeLocation:NO];
    });
    
    return manager;
}



#pragma mark  ----  自定义函数

//定位
-(void)startPositioning{
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        SHPositioningResultModel * resultModel = [[SHPositioningResultModel alloc] init];
        
        if (error != nil && self.callBack) {
            
            resultModel.errorCode = error.code;
            self.callBack(resultModel);
        }
        else{
            
            resultModel.errorCode = 0;
        }
        
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
            
            //存在虚拟定位的风险的定位结果
            __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
            //存在外接的辅助定位设备
            __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
            
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            resultModel.latitude = location.coordinate.latitude;
            resultModel.longitude = location.coordinate.longitude;
            resultModel.formattedAddress = regeocode.formattedAddress;
            resultModel.country = regeocode.country;
            resultModel.province = regeocode.province;
            resultModel.city = regeocode.city;
            resultModel.district = regeocode.district;
            resultModel.citycode = regeocode.citycode;
            resultModel.adcode = regeocode.adcode;
            resultModel.street = regeocode.street;
            resultModel.number = regeocode.number;
            resultModel.POIName = regeocode.POIName;
            resultModel.AOIName = regeocode.AOIName;
            if (self.callBack) {
                
                self.callBack(resultModel);
            }
        }
        else
        {
            NSString * one = [NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude];
            NSString * two = [NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy];
            NSLog(@"%@,%@",one,two);
        }
    }];
}


@end
