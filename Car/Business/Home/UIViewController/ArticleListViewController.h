//
//  ArticleListViewController.h
//  Car
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  文章列表页

#import "HoverChildViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleListViewController : HoverChildViewController

//请求数据
-(void)requestWithTabID:(NSString *)tabID;

@end

NS_ASSUME_NONNULL_END
