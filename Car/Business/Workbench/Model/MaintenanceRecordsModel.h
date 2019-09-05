//
//  MaintenanceRecordsModel.h
//  Car
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceRecordsModel : NSObject

//记录ID
@property (nonatomic,strong) NSString * recordId;
//车辆ID
@property (nonatomic,strong) NSString * car_id;
@property (nonatomic,strong) NSString * user_id;
//车牌号
@property (nonatomic,strong) NSString * license_number;
// 车辆类型
@property (nonatomic,strong) NSString * type;
//联系人
@property (nonatomic,strong) NSString * contacts;
//手机号码
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * maintain_day;
@property (nonatomic,strong) NSNumber * mileage;
@property (nonatomic,strong) NSString * related_service;
@property (nonatomic,strong) NSNumber * receivable;
@property (nonatomic,strong) NSNumber * received;
@property (nonatomic,strong) NSNumber * cost;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * images;
@property (nonatomic,strong) NSString * createtime;



@end

NS_ASSUME_NONNULL_END
