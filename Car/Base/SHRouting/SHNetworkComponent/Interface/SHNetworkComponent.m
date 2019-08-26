//
//  SHNetworkComponent.m
//  SHNetworkComponent
//
//  Created by xianjun wang on 2019/7/3.
//  Copyright © 2019 xianjun wang. All rights reserved.
//

#import "SHNetworkComponent.h"
#import "SHNetworkControl.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>

static SHNetworkComponent * manager = nil;

@implementation SHNetworkComponent

#pragma mark  ----  SET

-(void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    
    _timeoutInterval = timeoutInterval;
    [SHNetworkControl sharedManager].timeoutInterval = timeoutInterval;
}

#pragma mark  ----  生命周期函数

+(SHNetworkComponent *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
    });
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHNetworkComponent"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    
    return manager;
}

//重写创建对象空间的方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHNetworkComponent"]) {
        
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

#pragma mark  ----  自定义函数

-(NSURLSessionDataTask *)postRequestUrlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers showLoading:(BOOL)show callBackInMainThread:(BOOL)mainThread success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
    if (![parameters isKindOfClass:[NSDictionary class]] && ![parameters isKindOfClass:[NSArray class]]) {
        
        NSLog(@"异常：parameters格式异常，不是字典，不是数组");
    }
    
    return [self request:SHRequestTypePOST urlString:urlStr parameters:parameters headers:headers progress:nil showLoading:show callBackInMainThread:mainThread success:success failure:failure];
}

-(NSURLSessionDataTask *)request:(SHRequestType)requestType urlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers progress:(void (^)(NSProgress *downloadProgress))downloadProgress showLoading:(BOOL)show callBackInMainThread:(BOOL)mainThread success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task, NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
    void(^ShowLoadingBlock)(void) = ^{
        
        if ([[NSThread currentThread] isMainThread]) {
            
            if (NSClassFromString(@"MBProgressHUD")) {
                
                ((void(*)(id,SEL,UIView *,BOOL))objc_msgSend)(NSClassFromString(@"MBProgressHUD"),NSSelectorFromString(@"showHUDAddedTo:animated:"),[UIApplication sharedApplication].keyWindow,YES);
            }
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (NSClassFromString(@"MBProgressHUD")) {
                    
                    ((void(*)(id,SEL,UIView *,BOOL))objc_msgSend)(NSClassFromString(@"MBProgressHUD"),NSSelectorFromString(@"showHUDAddedTo:animated:"),[UIApplication sharedApplication].keyWindow,YES);
                }
            });
        }
    };
    
    void(^HidLoadingBlock)(void) = ^{
        
        if ([[NSThread currentThread] isMainThread]) {
            
            if (NSClassFromString(@"MBProgressHUD")) {
                
                ((void(*)(id,SEL,UIView *,BOOL))objc_msgSend)(NSClassFromString(@"MBProgressHUD"),NSSelectorFromString(@"hideAllHUDsForView:animated:"),[UIApplication sharedApplication].keyWindow,YES);
            }
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (NSClassFromString(@"MBProgressHUD")) {
                    
                    ((void(*)(id,SEL,UIView *,BOOL))objc_msgSend)(NSClassFromString(@"MBProgressHUD"),NSSelectorFromString(@"hideAllHUDsForView:animated:"),[UIApplication sharedApplication].keyWindow,YES);
                }
            });
        }
    };
    
    if (show) {
     
        ShowLoadingBlock();
    }
    
    switch (requestType) {
        case SHRequestTypePOST:
        {
        
            return [[SHNetworkControl sharedManager] POST:urlStr parameters:parameters headers:headers progress:downloadProgress success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                if (show) {
                    
                    HidLoadingBlock();
                }
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,data);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,data);
                        });
                    }
                }
                else{
                    
                    success(response,task,data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
        case SHRequestTypeGET:
        {
            return [[SHNetworkControl sharedManager] GET:urlStr parameters:parameters headers:headers progress:downloadProgress success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,data);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,data);
                        });
                    }
                }
                else{
                    
                    success(response,task,data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
        case SHRequestTypeHEAD:
        {
        
            return [[SHNetworkControl sharedManager] HEAD:urlStr parameters:parameters headers:headers success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,nil);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,nil);
                        });
                    }
                }
                else{
                    
                    success(response,task,nil);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
        case SHRequestTypePUT:
        {
            return [[SHNetworkControl sharedManager] PUT:urlStr parameters:parameters headers:headers success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,data);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,data);
                        });
                    }
                }
                else{
                    
                    success(response,task,data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
        case SHRequestTypePATCH:
        {
            return [[SHNetworkControl sharedManager] PATCH:urlStr parameters:parameters headers:headers success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,data);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,data);
                        });
                    }
                }
                else{
                    
                    success(response,task,data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
        case SHRequestTypeDELETE:
        {
            return [[SHNetworkControl sharedManager] DELETE:urlStr parameters:parameters headers:headers success:^(NSURLResponse * _Nonnull response, NSURLSessionDataTask * _Nonnull task, NSData * _Nonnull data) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        success(response,task,data);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(response,task,data);
                        });
                    }
                }
                else{
                    
                    success(response,task,data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                HidLoadingBlock();
                if (mainThread) {
                    
                    if ([[NSThread currentThread] isMainThread]) {
                        
                        failure(task,error);
                    }
                    else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failure(task,error);
                        });
                    }
                }
                else{
                    
                    failure(task,error);
                }
            }];
            break;
        }
    }
}

@end
