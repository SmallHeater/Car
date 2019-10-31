//
//  JHRoutingComponent.h
//  JHRoutingComponent
//
//  Created by xianjunwang on 2018/10/15.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  路由组件

#import <Foundation/Foundation.h>
#import "CommandList.h"


@interface SHRoutingComponent : NSObject

//只有命令，无传参，无回调
+(void)openURL:(NSString *)url;
//只有命令和传参，无回调
+(void)openURL:(NSString *)url withParameter:(NSDictionary *)parameterDic;
//只有命令和回调，无传参
+(void)openURL:(NSString *)url callBack:(void(^)(NSDictionary *resultDic))returnBlock;
//有命令，传参，回调
+(void)openURL:(NSString *)url withParameter:(NSDictionary *)parameterDic callBack:(void(^)(NSDictionary *resultDic))returnBlock;


@end
