//
//  SHUIScreenControl.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 IP. All rights reserved.
//

#import "SHUIScreenControl.h"

@implementation SHUIScreenControl

#pragma mark  ----  自定义函数

//是否是刘海屏
+(BOOL)isLiuHaiScreen{
    
    BOOL isLiuHai = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        
        //判断是否是刘海屏
        return isLiuHai;
    }
    if (@available(iOS 11.0, *)) {
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            
            isLiuHai = YES;
        }
    }
    return isLiuHai;
}

//刘海高度
+(float)liuHaiHeight{
    
    float liuHaiHeight = 0.0;
    if (@available(iOS 11.0, *)) {
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        liuHaiHeight = mainWindow.safeAreaInsets.bottom;
    }
    return liuHaiHeight;
}
//导航高度
+(float)navigationBarHeight{
    
    return 64.0 + [SHUIScreenControl liuHaiHeight];
}

//底部安全区高度
+(float)bottomSafeHeight{
    
    if ([SHUIScreenControl isLiuHaiScreen]) {
        
        return 34;
    }
    return 0;
}

@end
