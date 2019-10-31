//
//  SHNetworkRequestMiddleware.m
//  SHMiddlewareComponent
//
//  Created by xianjun wang on 2019/3/7.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "SHNetworkRequestMiddleware.h"
#import <objc/message.h>
#import "SHNetworkComponent.h"


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
    BOOL isShowLoading;
    if ([paramDic.allKeys containsObject:@"isShowLoading"]) {
        
        NSNumber * isShowLoadingNumber = paramDic[@"isShowLoading"];
        isShowLoading = isShowLoadingNumber.boolValue;
    }
    else{
        
        isShowLoading = YES;
    }
    
    BOOL isCallBackInMainThread;
    if ([paramDic.allKeys containsObject:@"isCallBackInMainThread"]) {
        
        NSNumber * isCallBackInMainThreadNumber = paramDic[@"isCallBackInMainThread"];
        isCallBackInMainThread = isCallBackInMainThreadNumber.boolValue;
    }
    else{
        
        isCallBackInMainThread = YES;
    }
    
    BOOL isShowSuccessLoading;
    if ([paramDic.allKeys containsObject:@"isShowSuccessLoading"]) {
        
        NSNumber * isShowSuccessLoadingNumber = paramDic[@"isShowSuccessLoading"];
        isShowSuccessLoading = isShowSuccessLoadingNumber.boolValue;
    }
    else{
        
        isShowSuccessLoading = NO;
    }
    
    NSString * successStr = @"";
    if ([paramDic.allKeys containsObject:@"successStr"]) {
        
        successStr = paramDic[@"successStr"];
    }
    
    
    BOOL isShowFailureLoading;
    if ([paramDic.allKeys containsObject:@"isShowFailureLoading"]) {
        
        NSNumber * isShowFailureLoadingNumber = paramDic[@"isShowFailureLoading"];
        isShowFailureLoading = isShowFailureLoadingNumber.boolValue;
    }
    else{
        
        isShowFailureLoading = YES;
    }
    
    NSString * failureStr = @"";
    if ([paramDic.allKeys containsObject:@"failureStr"]) {
        
        failureStr = paramDic[@"failureStr"];
    }
    
    [[SHNetworkComponent sharedManager] postRequestUrlString:urlStr parameters:bodyParameters headers:nil showLoading:isShowLoading callBackInMainThread:isCallBackInMainThread showSuccessMBP:isShowSuccessLoading successStr:successStr showFailureMBP:isShowFailureLoading failureStr:failureStr success:^(NSURLResponse *response, NSURLSessionDataTask *task, NSData *data) {
        
        id dataId = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dataId) {
            
            callBack(@{@"response":response,@"task":task,@"data":data,@"dataId":dataId});
        }
        else{
            
            callBack(@{@"response":response,@"task":task,@"data":data,@"dataId":@""});
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callBack(@{@"task":task,@"error":error});
    }];
}



@end
