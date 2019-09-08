//
//  JHNewUploadComponent.h
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  上传组件

#import <Foundation/Foundation.h>

@interface SHUploadComponent : NSObject

//上传
+(void)uploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary * resultDic))callBack;
/*
//暂停上传
+(void)suspendUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary * resultDic))callBack;
//继续上传
+(void)continueUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary * resultDic))callBack;
//停止上传
+(void)stopUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary * resultDic))callBack;
*/

//得到上传列表页面指针
+(void)getUploadTableViewControllerCallBack:(void(^)(NSDictionary *retultDic))callBack;
//上传未上传完的数据
+(void)uploadNotFinishDatasCallBack:(void(^)(NSDictionary *retultDic))callBack;

@end
