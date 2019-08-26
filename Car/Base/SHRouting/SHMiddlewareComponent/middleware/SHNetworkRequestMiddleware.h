//
//  JHNetworkRequestMiddleware.h
//  JHMiddlewareComponent
//
//  Created by xianjun wang on 2019/3/7.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  网络请求组件中间件类

#import <Foundation/Foundation.h>

@interface SHNetworkRequestMiddleware : NSObject

//获取网络类型;回调:SHNetworkStatus:网络类型,-1:未知,0:无网,1:流量,2:wifi;SHWWANType:移动网络类型,-1:未知,0:2G,1:3G,2:4G;
+(void)getConnectTypeCallBack:(void(^)(NSDictionary *retultDic))callBack;
//发起网络请求
+(void)requestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;


@end
