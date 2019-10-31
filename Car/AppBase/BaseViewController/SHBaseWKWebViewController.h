//
//  SHBaseWKWebViewController.h
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  网页控制器

#import "SHBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHBaseWKWebViewController : SHBaseUIViewController

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andURLStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
