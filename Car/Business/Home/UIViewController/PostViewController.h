//
//  PostViewController.h
//  Car
//
//  Created by mac on 2019/10/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发帖页

#import "BaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostViewController : BaseUIViewController

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andTabID:(NSString *)tabID;

@end

NS_ASSUME_NONNULL_END
