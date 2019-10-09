//
//  TopicForumViewController.h
//  Car
//
//  Created by xianjun wang on 2019/10/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  主题论坛页面

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicForumViewController : BaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andTabID:(NSString *)tabID;

@end

NS_ASSUME_NONNULL_END
