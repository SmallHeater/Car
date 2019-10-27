//
//  PostListViewController.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  帖子列表（营销课页面，疑难杂症页面）

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,VCType){
    
    VCType_yingxiaoke = 0,//营销课页面
    VCType_yinanzazheng = 1 //疑难杂症页面
};

@interface PostListViewController : BaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andVCType:(VCType)type;

@end

NS_ASSUME_NONNULL_END
