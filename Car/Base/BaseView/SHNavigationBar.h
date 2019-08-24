//
//  SHNavigationBar.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//  自定义导航view

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHNavigationBar : BaseView

-(instancetype)initWithTitle:(NSString *)title andShowBackBtn:(BOOL)isShowBackBtn;

-(void)addbackbtnTarget:(id)target andAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
