//
//  BusinessSummaryHeaderModel.h
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营业汇总头部模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessSummaryHeaderModel : NSObject

//总客户
@property (nonatomic,strong) NSNumber * consumer;
//利润率
@property (nonatomic,strong) NSNumber * profit_rate;
//近6个月应收最大值（用于左侧范围确定）
@property (nonatomic,strong) NSNumber * receivable_max;

@end

NS_ASSUME_NONNULL_END
