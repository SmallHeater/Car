//
//  UIViewController+SHTool.h
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SHTool)

/**
 *  返回上一级控制器
 *
 *  @return 上一级控制器
 */
+ (UIViewController*) topMostController;

@end

NS_ASSUME_NONNULL_END
