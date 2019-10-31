//
//  JHMiddlewareComponent.h
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  中间件组件

#import <Foundation/Foundation.h>

@interface SHMiddlewareComponent : NSObject

//执行命令，操作名，命令
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command;
//执行命令，操作名，命令，传参
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andInitDic:(NSDictionary *)initDic;
//执行命令，操作名，命令，回调。
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andCallBack:(void(^)(NSDictionary *retultDic))callBack;
//执行命令，操作名，命令，传参，回调。（本类的initDic和callBack参数在路由组件分发时已进行格式校验）
+(void)runCommandWithBusinessName:(NSString *)BusinessName andCommand:(NSString *)command andInitDic:(NSDictionary *)initDic andCallBack:(void(^)(NSDictionary *retultDic))callBack;

@end
