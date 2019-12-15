//
//  MotorOilMonopolyGoodsViewController.h
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油销售商品页面

#import "HoverChildViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ArrayCallBack)(NSMutableArray * dataArray);

@interface MotorOilMonopolyGoodsViewController : HoverChildViewController

//购买的机油数据模型的回调
@property (nonatomic,copy) ArrayCallBack callBack;

@end

NS_ASSUME_NONNULL_END
