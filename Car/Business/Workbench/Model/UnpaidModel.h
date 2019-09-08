//
//  UnpaidModel.h
//  Car
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  未回款模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnpaidModel : NSObject

@property (nonatomic,strong) NSString * license_number;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * contacts;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * unpaidId;
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSString * car_id;
@property (nonatomic,strong) NSString * maintain_day;
@property (nonatomic,strong) NSNumber * mileage;
@property (nonatomic,strong) NSNumber * related_service;
@property (nonatomic,strong) NSNumber * receivable;
@property (nonatomic,strong) NSNumber * received;
@property (nonatomic,strong) NSNumber * cost;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * images;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSNumber * money_repayed;
//欠款
@property (nonatomic,strong) NSNumber * debt;


@end

NS_ASSUME_NONNULL_END
