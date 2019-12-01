//
//  PostListViewController.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  帖子列表（营销课，疑难杂症等页面,我的帖子列表页面）

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,PostListVCType){
    
    PostListVCType_tieziliebiao = 0,//帖子列表
    PostListVCType_wodetieziliebiao = 1 //用户的帖子列表
};

@interface PostListViewController : SHBaseTableViewController

//帖子列表
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId;
//用户的帖子列表
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andUserId:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
