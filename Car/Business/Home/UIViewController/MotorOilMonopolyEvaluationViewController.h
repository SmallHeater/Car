//
//  MotorOilMonopolyEvaluationViewController.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖评价页面

#import "SHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ParentTBCanScrollCallBack)(BOOL canScroll);

@interface MotorOilMonopolyEvaluationViewController : SHBaseViewController

@property (nonatomic,strong) SHBaseTableView * tableView;
//父tableView
@property (nonatomic,strong) UITableView * parentTableView;

//子tableview能否滑动
@property (nonatomic,assign) BOOL canScroll;
//父viewe能否滑动的回调
@property (nonatomic,copy) ParentTBCanScrollCallBack canScrollCallBack;

-(instancetype)initWithShopId:(NSString *)shopId;

@end

NS_ASSUME_NONNULL_END
