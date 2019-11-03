//
//  PostListViewController.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  帖子列表（营销课，疑难杂症等页面,我的帖子列表页面）

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,VCType){
    
    VCType_tieziliebiao = 0,//帖子列表
    VCType_wodetieziliebiao = 1 //我的帖子列表
};

@interface PostListViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId vcType:(VCType)vcType;

@end

NS_ASSUME_NONNULL_END
