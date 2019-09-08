//
//  ModifyVehicleFileRequestModel.h
//  Car
//
//  Created by mac on 2019/9/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  修改车辆档案请求模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyVehicleFileRequestModel : NSObject

//车辆ID
@property (nonatomic,strong) NSString * car_id;
//用户ID
@property (nonatomic,strong) NSString * user_id;
//车牌号
@property (nonatomic,strong) NSString * license_number;
//车架号
@property (nonatomic,strong) NSString * vin;
//车型号
@property (nonatomic,strong) NSString * type;
//发动机号
@property (nonatomic,strong) NSString * engine_no;
//联系人
@property (nonatomic,strong) NSString * contacts;
//联系电话
@property (nonatomic,strong) NSString * phone;
//保险期
@property (nonatomic,strong) NSString * insurance_period;
//行驶证照片
@property (nonatomic,strong) NSString * vehicle_license_image;

@end

NS_ASSUME_NONNULL_END
