//
//  MiddlewareReflectionControl.h
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/17.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  业务名与中间件类名对应管理器

#import <Foundation/Foundation.h>

@interface MiddlewareReflectionControl : NSObject

+(NSString *)getClassNameWithBusinessName:(NSString *)businessName;

@end
