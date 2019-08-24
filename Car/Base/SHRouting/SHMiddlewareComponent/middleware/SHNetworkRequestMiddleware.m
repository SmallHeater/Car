//
//  JHNetworkRequestMiddleware.m
//  JHMiddlewareComponent
//
//  Created by xianjun wang on 2019/3/7.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "SHNetworkRequestMiddleware.h"
//#import "SHNetworkRequestCompont.h"


@implementation SHNetworkRequestMiddleware

//获取网络类型
+(void)getConnectTypeCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
//    [SHNetworkRequestCompont getConnectTypeCallBack:callBack];
}

//发起网络请求
+(void)requestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
//    [SHNetworkRequestCompont requestDataWithDic:dic callBack:callBack];
}

//暂停网络请求
+(void)suspendRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
//    [SHNetworkRequestCompont suspendRequestDataWithDic:dic callBack:callBack];
}

//恢复网络请求
+(void)resumeRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
//    [SHNetworkRequestCompont resumeRequestDataWithDic:dic callBack:callBack];
}

//停止网络请求
+(void)stopRequestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
//    [SHNetworkRequestCompont stopRequestDataWithDic:dic callBack:callBack];
}

@end
