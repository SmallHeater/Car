//
//  MotorOilMonopolyGoodsViewController.h
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油销售商品页面

#import "SHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ArrayCallBack)(NSMutableArray * dataArray);
typedef void(^ParentTBCanScrollCallBack)(BOOL canScroll);

@interface MotorOilMonopolyGoodsViewController : SHBaseViewController

//子tableview能否滑动
@property (nonatomic,assign) BOOL canScroll;
//父viewe能否滑动的回调
@property (nonatomic,copy) ParentTBCanScrollCallBack canScrollCallBack;

//购买的机油数据模型的回调
@property (nonatomic,copy) ArrayCallBack callBack;



@end

NS_ASSUME_NONNULL_END
