//
//  JHMiddlewareComponent.m
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHMiddlewareComponent.h"
#import "MiddlewareReflectionControl.h"
#import "SHRoutingComponent.h"

@implementation SHMiddlewareComponent

//执行命令，操作名，命令
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command{
    
    if ([self checkCommandWithBusinessName:BusinessName andCommand:command]) {
        
        NSString * className = [MiddlewareReflectionControl getClassNameWithBusinessName:BusinessName];
        SEL selector = NSSelectorFromString(command);
        IMP imp = [NSClassFromString(className) methodForSelector:selector];
        void (*func)(id,SEL) = (void *)imp;
        func(NSClassFromString(className),selector);
    }
}
//执行命令，操作名，命令，传参
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andInitDic:(NSDictionary *)initDic{
    
    if ([self checkCommandWithBusinessName:BusinessName andCommand:command]) {
        
        NSString * className = [MiddlewareReflectionControl getClassNameWithBusinessName:BusinessName];
        SEL selector = NSSelectorFromString(command);
        IMP imp = [NSClassFromString(className) methodForSelector:selector];
        void (*func)(id,SEL,id) = (void *)imp;
        func(NSClassFromString(className),selector,initDic);
    }
}
//执行命令，操作名，命令，回调。
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if ([self checkCommandWithBusinessName:BusinessName andCommand:command]) {
        
        NSString * className = [MiddlewareReflectionControl getClassNameWithBusinessName:BusinessName];
        SEL selector = NSSelectorFromString(command);
        IMP imp = [NSClassFromString(className) methodForSelector:selector];
        void (*func)(id,SEL,id) = (void *)imp;
        func(NSClassFromString(className),selector,callBack);
    }
}
//执行命令，操作名，命令，传参，回调。
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andInitDic:(NSDictionary *)initDic andCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if ([self checkCommandWithBusinessName:BusinessName andCommand:command]) {
        
        NSString * className = [MiddlewareReflectionControl getClassNameWithBusinessName:BusinessName];
        SEL selector = NSSelectorFromString(command);
        IMP imp = [NSClassFromString(className) methodForSelector:selector];
        void (*func)(id,SEL,id,id) = (void *)imp;
        func(NSClassFromString(className),selector,initDic,callBack);
    }
}

//校验操作名对应的类能否执行操作命令
+(BOOL)checkCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command{
    
    NSString * className = [MiddlewareReflectionControl getClassNameWithBusinessName:BusinessName];
    //className的异常在MiddlewareReflectionControl中已上报
    if (className.length > 0) {
        
        //判断操作对应的中间件类能否执行方法
        if ([NSClassFromString(className) respondsToSelector:NSSelectorFromString(command)]) {
            
            return YES;
        }
        else{
        
            //异常
            NSString * error = [[NSString alloc] initWithFormat:@"中间件类%@无该方法%@",className,command];
//            [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
            NSLog(@"%@",error);
            return NO;
        }
    }
    return NO;
}


@end
