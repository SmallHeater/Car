//
//  MotorOilMonopolyEvaluationViewController.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖商家页面

#import "HoverChildViewController.h"
#import "ShopModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ParentTBCanScrollCallBack)(BOOL canScroll);

@interface MotorOilMonopolyShopViewController : HoverChildViewController

-(instancetype)initWithShopModel:(ShopModel *)shopModel;

@end

NS_ASSUME_NONNULL_END
