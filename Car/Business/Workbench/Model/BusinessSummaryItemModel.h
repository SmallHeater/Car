//
//  BusinessSummaryItemModel.h
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营业列表项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessSummaryItemModel : NSObject

@property (nonatomic,strong) NSString * month;
//应收
@property (nonatomic,strong) NSNumber * receivable;
//成本
@property (nonatomic,strong) NSNumber * cost;
//欠款
@property (nonatomic,strong) NSNumber * debt;
//利润
@property (nonatomic,strong) NSNumber * profit;
//新客
@property (nonatomic,strong) NSNumber * xinke;
//维修
@property (nonatomic,strong) NSNumber * weixiu;
@property (nonatomic,strong) NSNumber * money_repayed;


@end

NS_ASSUME_NONNULL_END
