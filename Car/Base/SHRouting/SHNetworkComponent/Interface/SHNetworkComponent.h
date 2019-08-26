//
//  SHNetworkComponent.h
//  SHNetworkComponent
//
//  Created by xianjun wang on 2019/7/3.
//  Copyright © 2019 xianjun wang. All rights reserved.
//  网络请求接口类

#import <Foundation/Foundation.h>


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
 @param show 是否展示loading
 @param mainThread 是否在主线程回调
 @param success 成功回调
 @param failure 失败回调
 @return 请求的Task指针
 */
-(NSURLSessionDataTask *)postRequestUrlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers showLoading:(BOOL)show callBackInMainThread:(BOOL)mainThread success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task,NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**
 通用网络请求函数

 @param requestType 请求类型
 @param urlStr 请求地址
 @param parameters body参数
 @param headers head参数
 @param downloadProgress 下载进度
 @param show 是否展示loading
 @param mainThread 是否在主线程回调
 @param success 成功回调
 @param failure 失败回调
 @return 请求的Task指针
 */
-(NSURLSessionDataTask *)request:(SHRequestType)requestType urlString:(NSString *)urlStr parameters:(id)parameters headers:(NSDictionary <NSString *, NSString *> *)headers progress:(void (^)(NSProgress *downloadProgress))downloadProgress showLoading:(BOOL)show callBackInMainThread:(BOOL)mainThread success:(void (^)(NSURLResponse * __unused response,NSURLSessionDataTask *task, NSData *data))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

@end
