//
//  SHNetworkRequestMiddleware.m
//  SHMiddlewareComponent
//
//  Created by xianjun wang on 2019/3/7.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "SHNetworkRequestMiddleware.h"
#import <objc/message.h>
#import "SHNetworkControl.h"


@implementation SHNetworkRequestMiddleware

//获取网络类型
+(void)getConnectTypeCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    id SHNetworkStatusManagementComponent = ((id(*)(id,SEL))objc_msgSend)(NSClassFromString(@"SHNetworkStatusManagementComponent"),NSSelectorFromString(@"sharedManager"));
    int networkStatus = ((int(*)(id,SEL))objc_msgSend)(SHNetworkStatusManagementComponent,NSSelectorFromString(@"currentNetworkStatus"));
    
    int wanType = 0;
    if (networkStatus == 1) {
        
        wanType = ((int(*)(id,SEL))objc_msgSend)(SHNetworkStatusManagementComponent,NSSelectorFromString(@"currentWWANtype"));
    }
    
    callBack(@{@"SHNetworkStatus":[NSNumber numberWithInt:networkStatus],@"SHWWANType":[NSNumber numberWithInt:wanType]});
}

//发起网络请求
+(void)requestDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{

    NSDictionary * paramDic = dic;
    NSString * urlStr = paramDic[@"requestUrlStr"];
    NSString * bodyParameters = paramDic[@"bodyParameters"];
    
    [[SHNetworkControl sharedManager] POST:urlStr parameters:bodyParameters headers:nil progress:nil success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
        
        id dataId = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]; callBack(@{@"response":response,@"task":task,@"data":data,@"dataId":dataId});
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(@{@"task":task,@"error":error});
    }];

}



@end
