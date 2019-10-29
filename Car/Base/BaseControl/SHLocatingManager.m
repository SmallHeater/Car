//
//  SHLocatingManager.m
//  Car
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHLocatingManager.h"
#import <AddressBook/AddressBook.h>


@interface SHLocatingManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager * locationManager;
// 用作地理编码、反地理编码的工具类
@property (nonatomic, strong) CLGeocoder *geoC;
@property (nonatomic,copy) CallBack callBack;

@end

@implementation SHLocatingManager

#pragma mark  ----  懒加载

-(SHLocatingManager *)locationManager
{
    if (!_locationManager) {
        
        _locationManager = [[SHLocatingManager alloc]init];
        // 设置定位距离过滤参数 （当上次定位和本次定位之间的距离 > 此值时，才会调用代理通知开发者）
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 设置定位精度 （精确度越高，越耗电，所以需要我们根据实际情况，设定对应的精度）
        //允许后台获取信息
        _locationManager.allowsBackgroundLocationUpdates = NO;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(CLGeocoder *)geoC
{
    if (!_geoC) {
        
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

#pragma mark  ----  生命周期函数

+(SHLocatingManager *)sharedManager{
    
    static SHLocatingManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SHLocatingManager alloc] init];
    });
    
    return manager;
}

#pragma mark  ----  代理

#pragma mark  ----  CLLocationManagerDelegate

-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    
    CLLocation * currLocationl = locations.firstObject;
    if (currLocationl.horizontalAccuracy > 0) {//已经定位成功了
        
        [_locationManager stopUpdatingLocation];
    }else{
        
    }
    CLLocation * location = locations.lastObject;
    // 根据CLLocation对象进行反地理编码
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
        
        // 包含区，街道等信息的地标对象
        CLPlacemark *placemark = [placemarks firstObject];
        NSString * str = [[NSString alloc] initWithFormat:@"%@%@%@%@",placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.name];
        self.callBack(@{@"isSuccess":[NSNumber numberWithBool:YES],@"location":str,@"longitude":[NSNumber numberWithDouble:location.coordinate.longitude],@"latitude":[NSNumber numberWithDouble:location.coordinate.latitude]});
    }];
}

#pragma mark  ----  自定义函数

//定位
-(void)startLocating:(CallBack)callBack{
    
    self.callBack = callBack;
    // 2.判断定位服务是否可用
    if([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }else
    {
        self.callBack(@{@"isSuccess":[NSNumber numberWithBool:NO],@"location":@"定位失败"});
    }
}

@end
