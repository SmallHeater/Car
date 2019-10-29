//
//  ForumDetailViewController.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情页面

#import "SHBaseTableViewController.h"
#import "ForumArticleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ForumDetailViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andModel:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
