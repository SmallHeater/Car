//
//  PositioningResultModel.h
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  定位结果模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//定位错误码
typedef NS_ENUM(NSInteger, LocationErrorCode)
{
    LocationErrorUnknown = 1,               ///<未知错误
    LocationErrorLocateFailed = 2,          ///<定位错误
    LocationErrorReGeocodeFailed  = 3,      ///<逆地理错误
    LocationErrorTimeOut = 4,               ///<超时
    LocationErrorCanceled = 5,              ///<取消
    LocationErrorCannotFindHost = 6,        ///<找不到主机
    LocationErrorBadURL = 7,                ///<URL异常
    LocationErrorNotConnectedToInternet = 8,///<连接异常
    LocationErrorCannotConnectToHost = 9,   ///<服务器连接失败
    LocationErrorRegionMonitoringFailure=10,///<地理围栏错误
    LocationErrorRiskOfFakeLocation = 11,   ///<存在虚拟定位风险
};


@interface PositioningResultModel : NSObject

///纬度
@property (nonatomic, assign) CGFloat latitude;

///经度
@property (nonatomic, assign) CGFloat longitude;

//格式化地址
@property (nonatomic, copy) NSString *formattedAddress;

///国家
@property (nonatomic, copy) NSString *country;

///省/直辖市
@property (nonatomic, copy) NSString *province;

///市
@property (nonatomic, copy) NSString *city;

///区
@property (nonatomic, copy) NSString *district;

///乡镇
@property (nonatomic, copy) NSString *township __attribute__((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取.")));

///社区
@property (nonatomic, copy) NSString *neighborhood __attribute__((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取.")));

///建筑
@property (nonatomic, copy) NSString *building __attribute__((deprecated("该字段从v2.2.0版本起不再返回数据,建议您使用AMapSearchKit的逆地理功能获取.")));

///城市编码
@property (nonatomic, copy) NSString *citycode;

///区域编码
@property (nonatomic, copy) NSString *adcode;

///街道名称
@property (nonatomic, copy) NSString *street;

///门牌号
@property (nonatomic, copy) NSString *number;

///兴趣点名称
@property (nonatomic, copy) NSString *POIName;

///所属兴趣点名称
@property (nonatomic, copy) NSString *AOIName;

//错误码,0,表示成功
@property (nonatomic,assign) LocationErrorCode errorCode;

@end

NS_ASSUME_NONNULL_END
