//
//  BaseUIViewController.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//  带导航的基类视图控制器

#import "BaseViewController.h"
#import "SHNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseUIViewController : BaseViewController

@property (nonatomic,strong) SHNavigationBar * navigationbar;

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn;

//返回按钮的响应
-(void)backBtnClicked:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
