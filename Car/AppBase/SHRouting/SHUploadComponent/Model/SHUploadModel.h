//
//  UploadModel.h
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/1/16.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  上传模型

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,UploadState){
    
    UploadState_wait = 0,//等待
    UploadState_uploading,//上传中
    UploadState_suspend,//暂停
    UploadState_stop,//停止上传
};

@interface SHUploadModel : NSObject

//上传的数据，可以是UIImage,可以是NSData
@property (nonatomic, strong) NSObject * uploadData;
//上传的类型，Image,Video,Audio
@property (nonatomic, strong) NSString * uploadDataType;
@property (nonatomic, strong) NSString * uploadDataName;
//上传资源时长，音视频用，单位为秒
@property (nonatomic, strong) NSNumber * uploadDataTimeLength;
@property (nonatomic, strong) NSString * uploadDataPath;
//ID
@property (nonatomic,strong) NSString * uploadDataId;


//一下参数不是传递过来的，是上传过程中设置的
//上传开始时间
@property (nonatomic,strong) NSDate * startUploadDate;
//是否上传完成
@property (nonatomic, assign) BOOL isUploaded;
//上传进度
@property (nonatomic,assign) float progress;
//上传状态
@property (nonatomic,assign) UploadState uploadState;

@end

