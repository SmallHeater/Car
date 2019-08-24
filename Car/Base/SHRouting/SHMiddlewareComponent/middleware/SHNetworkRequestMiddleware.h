//
//  JHNetworkRequestMiddleware.h
//  JHMiddlewareComponent
//
//  Created by xianjun wang on 2019/3/7.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  网络请求组件中间件类

#import <Foundation/Foundation.h>

@interface SHNetworkRequestMiddleware : NSObject

//获取网络类型
+(void)getConnectTypeCallBack:(void(^)(NSDictionary *retultDic))callBack;
//发起网络请求
+(void)requestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;
//暂停网络请求
+(void)suspendRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;
//恢复网络请求
+(void)resumeRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;
//停止网络请求
+(void)stopRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;

@end
