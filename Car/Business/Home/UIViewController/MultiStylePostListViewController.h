//
//  PostListViewController.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  帖子列表，cell多样式

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,MultiStylePostListVCType){
    
    MultiStylePostListVCType_tieziliebiao = 0,//帖子列表
    MultiStylePostListVCType_wodetieziliebiao = 1 //我的帖子列表
};

@interface MultiStylePostListViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId vcType:(MultiStylePostListVCType)vcType;

@end

NS_ASSUME_NONNULL_END
