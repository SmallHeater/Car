//
//  RepaidModel.h
//  Car
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  已回款模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RepayModel : NSObject

@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSNumber * money;

@end

@interface RepaidModel : NSObject

@property (nonatomic,strong) NSString * car_id;
@property (nonatomic,strong) NSString * contacts;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSNumber * cost;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * maintain_id;
@property (nonatomic,strong) NSString * images;
@property (nonatomic,strong) NSString * license_number;
@property (nonatomic,strong) NSString * maintain_day;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSNumber * receivable;
@property (nonatomic,strong) NSNumber * received;
@property (nonatomic,strong) NSNumber * related_service;
@property (nonatomic,strong) NSArray<RepayModel *> * repaylist;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * user_id;

@end

NS_ASSUME_NONNULL_END
