//
//  HttpRequestManager.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/6/16.
//  Copyright © 2019 IP. All rights reserved.
//

#import "HttpRequestManager.h"

@interface HttpRequestManager ()

@property (nonatomic,strong) AFHTTPSessionManager * sessionManager;

@end

@implementation HttpRequestManager

#pragma mark  ----  懒加载

-(AFHTTPSessionManager *)sessionManager{
    
    if (!_sessionManager) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return _sessionManager;
}

#pragma mark  ----  生命周期函数

+(HttpRequestManager *)manager{
    
    static HttpRequestManager * nanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nanager = [[HttpRequestManager alloc] init];
    });
    
    return nanager;
}

#pragma mark  ----  自定义函数

-(void)postWithURLStr:(NSString *)urlStr parameters:(NSDictionary *)bodyDic progressBlock:(ProgressBlcok)progressBlock successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    [self.sessionManager POST:urlStr parameters:bodyDic progress:progressBlock success:successBlock failure:failureBlock];
}







@end
