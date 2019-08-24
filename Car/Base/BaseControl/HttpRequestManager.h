//
//  HttpRequestManager.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/6/16.
//  Copyright © 2019 IP. All rights reserved.
//  网络请求管理类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ProgressBlcok)(NSProgress * _Nonnull uploadProgress);
typedef void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);




@interface HttpRequestManager : NSObject

+(HttpRequestManager *)manager;

-(void)postWithURLStr:(NSString *)urlStr parameters:(NSDictionary *)bodyDic progressBlock:(ProgressBlcok)progressBlock successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
