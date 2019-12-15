//
//  MotorOilMonopolyEvaluationViewController.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖评价页面

#import "HoverChildViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ParentTBCanScrollCallBack)(BOOL canScroll);

typedef void(^EvaluationCountCallBack)(NSUInteger count);

@interface MotorOilMonopolyEvaluationViewController : HoverChildViewController

@property (nonatomic,copy) EvaluationCountCallBack callBack;

-(instancetype)initWithShopId:(NSString *)shopId;

@end

NS_ASSUME_NONNULL_END
