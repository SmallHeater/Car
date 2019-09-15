//
//  SHNetworkComponent.h
//  SHNetworkComponent
//
//  Created by xianjun wang on 2019/7/3.
//  Copyright © 2019 xianjun wang. All rights reserved.
//  网络请求接口类,请求依赖MBProgressHUD+WJExtension

#import <Foundation/Foundation.h>

//网络请求成功，失败的默认提示语
#define INTERNETERROR @"网络异常，请稍后再试"
#define INTERNETSUCCESS @"请求成功"

//请求方式结构体
typedef NS_ENUM(NSUInteger,SHRequestType){
    
    SHRequestTypePOST = 0,
    SHRequestTypeGET,
    SHRequestTypeHEAD,//只请求页面的头部
    SHRequestTypePUT,//上传文档
    SHRequestTypePATCH,//部分更新文档数据
    SHRequestTypeDELETE//删除文档
};

@interface SHNetworkComponent : NSObject

//超时时间，默认10秒
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 实例化方法

 @return 返回对象实例
 */
+(SHNetworkComponent *)sharedManager;

/**
 POST网络请求，最常用网络请求封装

 @param urlStr 地址
 @param parameters body数据
 @param headers head数据
 @param showLoading 是否展示loading
 @param mainThread 是否在主线程回调
 @param showSuccessMBP 是否弹出请求成功的提示框
 @param successStr 成功的提示语
 @param showFailureMBP 是否弹出请求失败的提示框
 @param failureStr 失败的提示语
 @param success 成功回调
 @param failure 失败回调
 @return 请求的Task指针
 */
-(NSURLSessionDataTask *)postRequestUrlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers showLoading:(BOOL)showLoading callBackInMainThread:(BOOL)mainThread showSuccessMBP:(BOOL)showSuccessMBP successStr:(NSString *)successStr showFailureMBP:(BOOL)showFailureMBP failureStr:(NSString *)failureStr success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**
 通用网络请求函数

 @param requestType 请求类型
 @param urlStr 请求地址
 @param parameters body参数
 @param headers head参数
 @param downloadProgress 下载进度
 @param showLoading 是否展示loading
 @param mainThread 是否在主线程回调
 @param showSuccessMBP 是否弹出请求成功的提示框
 @param successStr 成功的提示语
 @param showFailureMBP 是否弹出请求失败的提示框
 @param failureStr 失败的提示语
 @param success 成功回调
 @param failure 失败回调
 @return 请求的Task指针
 */
-(NSURLSessionDataTask *)request:(SHRequestType)requestType urlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers progress:(void (^)(NSProgress *downloadProgress))downloadProgress showLoading:(BOOL)showLoading callBackInMainThread:(BOOL)mainThread showSuccessMBP:(BOOL)showSuccessMBP successStr:(NSString *)successStr showFailureMBP:(BOOL)showFailureMBP failureStr:(NSString *)failureStr success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task, NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

@end
