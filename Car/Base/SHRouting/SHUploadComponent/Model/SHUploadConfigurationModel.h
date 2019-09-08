//
//  JHNewUploadConfigurationModel.h
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/2/25.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  上传组件配置模型

#import <Foundation/Foundation.h>


@class SHUploadModel;

@interface SHUploadConfigurationModel : NSObject

//标识(可以用户传，用户不传则自己生成)
@property (nonatomic,strong) NSString * Identification;
//是否是单个数据传完就回调
@property (nonatomic,assign) BOOL isSingleReturn;
//是否压缩
@property (nonatomic,assign) BOOL isCompression;
//是否单线程上传
@property (nonatomic,assign) BOOL isSingleThread;
//是否显示默认上传效果
@property (nonatomic,assign) BOOL isShowLoading;
//是否添加到上传列表
@property (nonatomic,assign) BOOL isAddUploadList;
//是否回传进度
@property (nonatomic,assign) BOOL isCallBackSchedule;
//上传服务器地址
@property (nonatomic,strong) NSString * serverUrlStr;
//数据数组
@property (nonatomic,strong) NSMutableArray<SHUploadModel *> * datasArray;
//已上传个数
@property (nonatomic,assign) NSUInteger finishUploadCount;
//已上传数据回调的数组
@property (nonatomic,strong) NSMutableArray * callBackDatasArray;
//超时时间，默认是300秒
@property (nonatomic,strong) NSNumber * timeoutNumber;

@end
