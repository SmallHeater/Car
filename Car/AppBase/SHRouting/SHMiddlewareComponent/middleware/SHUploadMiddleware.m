//
//  JHUploadMiddleware.m
//  JHMiddlewareComponent
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "SHUploadMiddleware.h"
#import "SHUploadComponent.h"

@implementation SHUploadMiddleware

#pragma mark  ----  自定义函数

//上传图片，视频等资源的data数据
+(void)uploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if (initDic && [initDic isKindOfClass:[NSDictionary class]] && [initDic.allKeys containsObject:@"datasArray"]) {
        
        [SHUploadComponent uploadDatas:initDic callBack:callBack];
    }
}
/*
//暂停上传
+(void)suspendUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if (initDic && [initDic isKindOfClass:[NSDictionary class]] && [initDic.allKeys containsObject:@"datasArray"]) {
        
        [JHNewUploadComponent suspendUploadDatas:initDic callBack:callBack];
    }
}

//继续上传
+(void)continueUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if (initDic && [initDic isKindOfClass:[NSDictionary class]] && [initDic.allKeys containsObject:@"datasArray"]) {
        
        [JHNewUploadComponent continueUploadDatas:initDic callBack:callBack];
    }
}

//停止上传
+(void)stopUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if (initDic && [initDic isKindOfClass:[NSDictionary class]] && [initDic.allKeys containsObject:@"datasArray"]) {
        
        [JHNewUploadComponent stopUploadDatas:initDic callBack:callBack];
    }
}

//得到上传列表页面指针
+(void)getUploadTableViewControllerCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    [JHNewUploadComponent getUploadTableViewControllerCallBack:callBack];
}

//上传未上传完的数据
+(void)uploadNotFinishDatasCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    [JHNewUploadComponent uploadNotFinishDatasCallBack:callBack];
}
*/
@end
