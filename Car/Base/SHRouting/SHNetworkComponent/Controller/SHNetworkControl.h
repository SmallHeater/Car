//
//  SHNetworkControl.h
//  SHNetworkComponent
//
//  Created by xianjun wang on 2019/7/10.
//  Copyright © 2019 xianjun wang. All rights reserved.
//  网络请求控制器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHNetworkControl : NSObject

//超时时间，默认10秒
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 实例化方法
 
 @return 返回对象实例
 */
+(SHNetworkControl *)sharedManager;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask * _Nonnull task, NSData *data))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;


- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       headers:(NSDictionary<NSString *,NSString *> *)headers
                       success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask * _Nonnull task,NSData *data))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      headers:(NSDictionary<NSString *,NSString *> *)headers
                      success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        headers:(NSDictionary<NSString *,NSString *> *)headers
                        success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         headers:(NSDictionary<NSString *,NSString *> *)headers
                         success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end

NS_ASSUME_NONNULL_END
