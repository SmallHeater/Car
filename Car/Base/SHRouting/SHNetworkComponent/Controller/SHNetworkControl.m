//
//  SHNetworkControl.m
//  SHNetworkComponent
//
//  Created by xianjun wang on 2019/7/10.
//  Copyright © 2019 xianjun wang. All rights reserved.
//

#import "SHNetworkControl.h"
#import <objc/message.h>


static SHNetworkControl * manager = nil;

@interface SHNetworkControl ()<NSURLSessionDelegate>

@end


@implementation SHNetworkControl

#pragma mark  ----  生命周期函数

+(SHNetworkControl *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
        manager.timeoutInterval = 10.0f;
    });
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHNetworkControl"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    
    return manager;
}

//重写创建对象空间的方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHNetworkControl"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    return [self sharedManager];
}

//重写copy
-(id)copy{
    
    return [self.class sharedManager];
}

//重写mutableCopy
-(id)mutableCopy{
    
    return [self.class sharedManager];
}

#pragma mark  ----  代理
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}


#pragma mark  ----  自定义函数

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters headers:headers uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask * _Nonnull task, NSData *data))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                        URLString:URLString
                                                       parameters:parameters
                                                          headers:headers
                                                   uploadProgress:nil
                                                 downloadProgress:downloadProgress
                                                          success:success
                                                          failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       headers:(NSDictionary<NSString *,NSString *> *)headers
                       success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask * _Nonnull task,NSData *data))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"HEAD" URLString:URLString parameters:parameters headers:headers uploadProgress:nil downloadProgress:nil success:^(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data) {
        if (success) {
            success(response,task,data);
        }
    } failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      headers:(NSDictionary<NSString *,NSString *> *)headers
                      success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PUT" URLString:URLString parameters:parameters headers:headers uploadProgress:nil downloadProgress:nil success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        headers:(NSDictionary<NSString *,NSString *> *)headers
                        success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PATCH" URLString:URLString parameters:parameters headers:headers uploadProgress:nil downloadProgress:nil success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         headers:(NSDictionary<NSString *,NSString *> *)headers
                         success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"DELETE" URLString:URLString parameters:parameters headers:headers uploadProgress:nil downloadProgress:nil success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],
                          [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)
                           ];
    return [NSURL URLWithString:URLString];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         headers:(NSDictionary <NSString *, NSString *> *)headers
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task, NSData *data))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSURL * url = [NSURL URLWithString:URLString];
    // Headers
    if (headers && [headers isKindOfClass:[NSDictionary class]] && headers.allKeys.count > 0) {
        
        url = NSURLByAppendingQueryParameters(url, headers);
    }
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    //超时时间
    request.timeoutInterval = self.timeoutInterval;
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = method;
    
    NSDictionary * bodyPara = parameters;
    if (bodyPara && [bodyPara isKindOfClass:[NSDictionary class]] && bodyPara.allKeys.count > 0) {

        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:bodyPara options:kNilOptions error:NULL];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse *response, NSData *data, NSError * _Nullable error) {
        
        if (error) {
            
            if (failure) {
                
                failure(dataTask, error);
            }
        } else {
            
            if (success) {
                
                success(response,dataTask,data);
            }
        }
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response,NSData *data,NSError * _Nullable error))completionHandler {
    // Connection
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    NSURLSessionDataTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler(response,data,error);
    }];
    [task resume];
    return task;
}

@end
