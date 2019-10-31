//
//  JHUploadRecordingModel.h
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/4/30.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  网络请求记录模型，记录id,task,callBack等

#import <Foundation/Foundation.h>
#import "SHUploadConfigurationModel.h"

typedef void(^CallBack)(NSDictionary * retultDic);

NS_ASSUME_NONNULL_BEGIN

@interface SHUploadRecordingModel : NSObject

//唯一标识
@property (nonatomic,strong) NSString * identifier;
//配置模型
@property (nonatomic,strong) SHUploadConfigurationModel * configurationModel;
//任务
@property (nonatomic,strong) NSURLSessionTask * task;
//回调
@property (nonatomic,copy) CallBack callBack;

@end

NS_ASSUME_NONNULL_END
