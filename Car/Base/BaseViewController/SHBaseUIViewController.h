//
//  BaseUIViewController.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//  带导航的基类视图控制器

#import "SHBaseViewController.h"
#import "SHNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHBaseUIViewController : SHBaseViewController

//标题
@property (nonatomic,strong) NSString * navTitle;
@property (nonatomic,strong) SHNavigationBar * navigationbar;

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn;

//返回按钮的响应
-(void)backBtnClicked:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
