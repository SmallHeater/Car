//
//  SHUIScreenControl.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 IP. All rights reserved.
//  屏幕管理类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHUIScreenControl : NSObject

//是否是刘海屏
+(BOOL)isLiuHaiScreen;
//刘海高度
+(float)liuHaiHeight;
//导航高度
+(float)navigationBarHeight;
//底部安全区高度
+(float)bottomSafeHeight;

@end

NS_ASSUME_NONNULL_END
