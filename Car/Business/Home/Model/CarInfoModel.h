//
//  CarInfoModel.h
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆信息模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarInfoModel : NSObject

//厂家名称
@property (nonatomic,strong) NSString * manufacturer;
//品牌
@property (nonatomic,strong) NSString * brand;
//车型
@property (nonatomic,strong) NSString * cartype;
//名称
@property (nonatomic,strong) NSString * name;
//年款
@property (nonatomic,strong) NSString * yeartype;
//排放标准
@property (nonatomic,strong) NSString * environmentalstandards;
//油耗
@property (nonatomic,strong) NSString * comfuelconsumption;
//发动机
@property (nonatomic,strong) NSString * engine;
//变速箱
@property (nonatomic,strong) NSString * gearbox;
//驱动方式
@property (nonatomic,strong) NSString * drivemode;
//车身形式
@property (nonatomic,strong) NSString * carbody;
//前轮胎尺寸
@property (nonatomic,strong) NSString * fronttiresize;
//后轮胎尺寸
@property (nonatomic,strong) NSString * reartiresize;
//车架号
@property (nonatomic,strong) NSString * vin;

@end

NS_ASSUME_NONNULL_END
