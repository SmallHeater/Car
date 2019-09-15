//
//  ProfitrankingModel.h
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  利润排名项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitrankingModel : NSObject

@property (nonatomic,strong) NSNumber * money_repayed;
//欠款
@property (nonatomic,strong) NSNumber * debt;
//应收
@property (nonatomic,strong) NSNumber * receivable;
//成本
@property (nonatomic,strong) NSNumber * cost;
// 维修量
@property (nonatomic,strong) NSNumber * count;
//利润
@property (nonatomic,strong) NSNumber * profit;
//车牌
@property (nonatomic,strong) NSString * license_number;
//联系人
@property (nonatomic,strong) NSString * contacts;

@end

NS_ASSUME_NONNULL_END
