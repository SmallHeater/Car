//
//  MotorOilMonopolyEvaluationViewController.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖商家页面

#import "SHBaseViewController.h"
#import "ShopModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ParentTBCanScrollCallBack)(BOOL canScroll);

@interface MotorOilMonopolyShopViewController : SHBaseViewController


@property (nonatomic,strong) SHBaseTableView * tableView;
//父tableView
@property (nonatomic,strong) UITableView * parentTableView;

//子tableview能否滑动
@property (nonatomic,assign) BOOL canScroll;
//父viewe能否滑动的回调
@property (nonatomic,copy) ParentTBCanScrollCallBack canScrollCallBack;

-(instancetype)initWithShopModel:(ShopModel *)shopModel;

@end

NS_ASSUME_NONNULL_END
