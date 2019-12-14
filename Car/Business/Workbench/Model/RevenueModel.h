//
//  RevenueModel.h
//  Car
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营收列表模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RevenueModel : NSObject

@property (nonatomic,strong) NSNumber * receivable;
//车主付款
@property (nonatomic,strong) NSNumber * received;
//欠款
@property (nonatomic,strong) NSNumber * debt;
@property (nonatomic,strong) NSNumber * cost;
@property (nonatomic,strong) NSNumber * profit;
@property (nonatomic,strong) NSString * license_number;
@property (nonatomic,strong) NSString * contacts;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * phone;


@end

NS_ASSUME_NONNULL_END
