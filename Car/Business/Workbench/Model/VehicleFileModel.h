//
//  VehicleFileModel.h
//  Car
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆档案模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleFileModel : NSObject

//车辆ID
@property (nonatomic,strong) NSString * carId;
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSString * license_number;
@property (nonatomic,strong) NSString * vin;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * engine_no;
@property (nonatomic,strong) NSString * contacts;
@property (nonatomic,strong) NSString * insurance_period;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSString * vehicle_license_image;
//维修次数
@property (nonatomic,strong) NSNumber * maintain_count;
//联系电话
@property (nonatomic,strong) NSString * phone;

@end

NS_ASSUME_NONNULL_END
