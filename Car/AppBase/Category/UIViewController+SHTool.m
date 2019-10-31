//
//  UIViewController+SHTool.m
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UIViewController+SHTool.h"

@implementation UIViewController (SHTool)

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
