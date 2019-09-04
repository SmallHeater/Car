//
//  DrivingLicenseModel.h
//  Car
//
//  Created by mac on 2019/9/4.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  行驶证模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrivingLicenseModel : NSObject

//发动机号码
@property (nonatomic,strong) NSString * engineNumber;
//号牌号码
@property (nonatomic,strong) NSString * numberPlateNumber;
//所有人（拥有人）
@property (nonatomic,strong) NSString * owner;
//使用性质
@property (nonatomic,strong) NSString * useTheNature;
//住址
@property (nonatomic,strong) NSString * address;
//注册日期
@property (nonatomic,strong) NSString * registeredDate;
//车辆识别代号
@property (nonatomic,strong) NSString * vehicleIdentificationNumber;
//品牌型号
@property (nonatomic,strong) NSString * brandModelNumber;
//车辆类型
@property (nonatomic,strong) NSString * vehicleType;
//发证日期
@property (nonatomic,strong) NSString * dateIssue;

@end

NS_ASSUME_NONNULL_END
