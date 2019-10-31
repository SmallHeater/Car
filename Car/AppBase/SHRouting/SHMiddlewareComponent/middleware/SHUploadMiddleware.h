//
//  JHUploadMiddleware.h
//  JHMiddlewareComponent
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  上传组件中间件类

#import <Foundation/Foundation.h>

@interface SHUploadMiddleware : NSObject

//上传图片，视频等资源的data数据
+(void)uploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack;
/*
//暂停上传
+(void)suspendUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack;
//继续上传
+(void)continueUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack;
//停止上传
+(void)stopUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack;

//得到上传列表页面指针
+(void)getUploadTableViewControllerCallBack:(void(^)(NSDictionary *retultDic))callBack;
//上传未上传完的数据
+(void)uploadNotFinishDatasCallBack:(void(^)(NSDictionary *retultDic))callBack;
*/
@end
