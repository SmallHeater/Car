//
//  ResidualTransactionDetailViewController.h
//  Car
//
//  Created by xianjun wang on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  残值交易详情页面

#import "SHBaseTableViewController.h"
#import "ResidualTransactionModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ResidualTransactionDetailViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andModel:(ResidualTransactionModel *)model;

@end

NS_ASSUME_NONNULL_END
