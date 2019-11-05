//
//  ReportViewController.h
//  Car
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  举报页面

#import "SHBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReportViewController : SHBaseUIViewController

//举报id
-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andId:(NSString *)reportId;

@end

NS_ASSUME_NONNULL_END
