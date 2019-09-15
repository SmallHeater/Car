//
//  ProfitstatisticsModel.h
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  利润统计模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitstatisticsModel : NSObject

//合计利润
@property (nonatomic,strong) NSNumber * profit;
//合计应收
@property (nonatomic,strong) NSNumber * receivable;
//合计成本
@property (nonatomic,strong) NSNumber * cost;
//合计欠款
@property (nonatomic,strong) NSNumber * debt;
// 合计维修量
@property (nonatomic,strong) NSNumber * count;


@end

NS_ASSUME_NONNULL_END
