//
//  UploadController.h
//  JHUploadLibrary
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  上传控制器

#import <Foundation/Foundation.h>


@class SHUploadModel,SHUploadConfigurationModel,SHUploadRecordingModel;



@interface NewUploadController : NSObject

//正在上传的数据模型数组
@property (nonatomic,strong) NSMutableArray<SHUploadModel *> * uploadDataModelArray;
@property (nonatomic,strong) NSMutableArray<SHUploadRecordingModel *> * uploadRecordingModelArray;


//因为指针持有问题，本类修改为单利类，避免指针的过早销毁
+(NewUploadController *)sharedManager;

//上传资源
-(void)uploadDatasWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary * retultDic))callBack;
/*
//暂停上传
-(void)suspendUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary * retultDic))callBack;
//暂停单个上传
-(void)suspendUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary * retultDic))callBack;
//继续上传  
-(void)continueUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary * retultDic))callBack;
//继续单个上传
-(void)continueUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary * retultDic))callBack;
//停止上传
-(void)stopUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary * retultDic))callBack;
//停止单个上传
-(void)stopUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary * retultDic))callBack;
*/
@end
