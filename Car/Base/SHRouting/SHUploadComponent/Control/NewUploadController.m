//
//  UploadController.m
//  JHUploadLibrary
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "NewUploadController.h"
#import "SHUploadModel.h"
#import "ImageCompressionController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVKit/AVKit.h>
#import "SHUploadConfigurationModel.h"
#import "SHRoutingComponent.h"
#import "JHNewUploadLoading.h"
#import "SHUploadRecordingModel.h"


//视频存储路径
#define KVideoUrlPath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]

typedef void(^RuturnBlock)(NSDictionary *retultDic);

@interface NewUploadController ()<NSURLSessionDelegate>

//上传动画
@property (nonatomic,strong) JHNewUploadLoading * loading;

//待上传数据量大小，用以监控保障内存使用，单位M
@property (nonatomic,assign) float willUploadDataSize;

//上传中的任务,key是ID，value是NSURLSessionDataTask *；
@property (nonatomic,strong) NSMutableDictionary * taskDic;

@end


@implementation NewUploadController

#pragma mark  ----  懒加载

-(NSMutableArray<SHUploadModel *> *)uploadDataModelArray{
    
    if (!_uploadDataModelArray) {
        
        _uploadDataModelArray = [[NSMutableArray alloc] init];
    }
    return _uploadDataModelArray;
}

-(NSMutableArray<SHUploadRecordingModel *> *)uploadRecordingModelArray{
    
    if (!_uploadRecordingModelArray) {
        
        _uploadRecordingModelArray = [[NSMutableArray alloc] init];
    }
    return _uploadRecordingModelArray;
}

-(NSMutableDictionary *)taskDic{
    
    if (!_taskDic) {
        
        _taskDic = [[NSMutableDictionary alloc] init];
    }
    return _taskDic;
}

#pragma mark  ----  生命周期函数
+(NewUploadController *)sharedManager{
    
    static NewUploadController * control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        control = [[NewUploadController alloc] init];
//        [control connectMonitoring];
    });
    return control;
}

#pragma mark  ----  自定义函数
//发起网络状态监听

//上传资源
-(void)uploadDatasWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    SHUploadRecordingModel * recordingModel;
    //是否已添加过
    BOOL isAdd = NO;
    for (SHUploadRecordingModel * tempRecordingModel in self.uploadRecordingModelArray) {
        
        if ([tempRecordingModel.configurationModel isEqual:configurationModel]) {
            
            isAdd = YES;
            recordingModel = tempRecordingModel;
            break;
        }
    }
    
    if (!isAdd) {
        
        recordingModel = [[SHUploadRecordingModel alloc] init];
        recordingModel.identifier = configurationModel.Identification;
        recordingModel.configurationModel = configurationModel;
        recordingModel.callBack = callBack;
        [self.uploadRecordingModelArray addObject:recordingModel];
    }
    
    
    if (recordingModel.configurationModel.datasArray.count == 1) {
        
        [self upload:recordingModel andIndex:0 callBack:recordingModel.callBack];
    }
    else{
        
        //上传数据多余1个
        if (recordingModel.configurationModel.isSingleThread) {
            
            //单线程上传
            [self singleThreadUploadWithRecordingModel:recordingModel];
        }
        else{
            
                [self InstantiationWillUploadDataWithConfigurationModel:configurationModel];
                if (self.willUploadDataSize > 1.5) {
                    
                    NSLog(@"多线程转单线程");
                    //如果实际待上传数据大于1.0M，则启动单线程上传
                    //多线程转单线程
                    [self singleThreadUploadWithRecordingModel:recordingModel];
                }
                else{
                
                    //多线程上传
                    [self MultiThreadedUploadWithRecordingModel:recordingModel];
                }
            }
    }
}

//暂停上传
-(void)suspendUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    __weak NewUploadController * weakSelf = self;
    for (SHUploadModel * model in configurationModel.datasArray) {
        
        for (SHUploadModel * uploadModel in self.uploadDataModelArray) {
            
            if ([model.uploadDataId isEqualToString:uploadModel.uploadDataId]) {
                
                //修改上传状态
                uploadModel.uploadState = UploadState_suspend;
                NSURLSessionDataTask * task = [weakSelf.taskDic objectForKey:model.uploadDataId];
                [task suspend];
                NSDictionary * dic =@{@"taskIdentifier":model.uploadDataId,@"state":@"暂停"};
                callBack(dic);
            }
        }
    }
}

//暂停单个上传
-(void)suspendUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    //修改上传状态
    uploadModel.uploadState = UploadState_suspend;
    NSURLSessionDataTask * task = [self.taskDic objectForKey:uploadModel.uploadDataId];
    [task suspend];
    NSDictionary * dic =@{@"taskIdentifier":uploadModel.uploadDataId,@"state":@"暂停"};
    callBack(dic);
}

//继续上传
-(void)continueUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    __weak NewUploadController * weakSelf = self;
    for (SHUploadModel * model in configurationModel.datasArray) {
        
        for (SHUploadModel * uploadModel in self.uploadDataModelArray) {
            
            if ([model.uploadDataId isEqualToString:uploadModel.uploadDataId]) {
                
                //修改上传状态
                uploadModel.uploadState = UploadState_uploading;
                NSURLSessionDataTask * task = [weakSelf.taskDic objectForKey:model.uploadDataId];
                [task resume];
                NSDictionary * dic =@{@"taskIdentifier":model.uploadDataId,@"state":@"继续上传"};
                callBack(dic);
            }
        }
    }
}
//继续单个上传
-(void)continueUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    //修改上传状态
    uploadModel.uploadState = UploadState_uploading;
    NSURLSessionDataTask * task = [self.taskDic objectForKey:uploadModel.uploadDataId];
    [task resume];
    NSDictionary * dic =@{@"taskIdentifier":uploadModel.uploadDataId,@"state":@"继续上传"};
    callBack(dic);
}

//停止上传
-(void)stopUploadWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    __weak NewUploadController * weakSelf = self;
    for (SHUploadModel * model in configurationModel.datasArray) {
        
        for (SHUploadModel * uploadModel in self.uploadDataModelArray) {
            
            if ([model.uploadDataId isEqualToString:uploadModel.uploadDataId]) {
                
                //修改上传状态
                uploadModel.uploadState = UploadState_stop;
                NSURLSessionDataTask * task = [weakSelf.taskDic objectForKey:model.uploadDataId];
                [task cancel];
                NSDictionary * dic =@{@"taskIdentifier":model.uploadDataId,@"state":@"停止上传"};
                callBack(dic);
            }
        }
    }
    
    NSMutableArray * deleteModelArray = [[NSMutableArray alloc] init];
    for (SHUploadModel * uploadModel in self.uploadDataModelArray) {
        
        if (uploadModel.uploadState == UploadState_stop) {
            
            [deleteModelArray addObject:uploadModel];
        }
    }
    [self.uploadDataModelArray removeObjectsInArray:deleteModelArray];
}
//停止单个上传
-(void)stopUploadWithUploadModel:(SHUploadModel *)uploadModel callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    uploadModel.uploadState = UploadState_stop;
    NSURLSessionDataTask * task = [self.taskDic objectForKey:uploadModel.uploadDataId];
    [task cancel];
    NSDictionary * dic =@{@"taskIdentifier":uploadModel.uploadDataId,@"state":@"停止上传"};
    callBack(dic);
    
    [self.uploadDataModelArray removeObject:uploadModel];
}

//将待上传数据实例化,记录待上传数据大小
-(void)InstantiationWillUploadDataWithConfigurationModel:(SHUploadConfigurationModel *)configurationModel{
    
    //上传图片压缩前总大小,单位M
    __weak NewUploadController * weakSelf = self;
    for (NSUInteger i = 0; i < configurationModel.datasArray.count; i++) {
        
        SHUploadModel * model = configurationModel.datasArray[i];
        if (weakSelf.willUploadDataSize > 1.5) {
            
            //如果待上传数据大于1.0，就不能再执行image转data了。同时开启单线程上传
            return;
        }
        id uploadData = model.uploadData;
        NSData * willUploadData;
        if ([model.uploadDataType isEqualToString:@"Image"]) {
            
            //图片
            if ([uploadData isKindOfClass:[UIImage class]]) {
                
                @autoreleasepool {
                    
                    UIImage * uploadImage = (UIImage *)model.uploadData;
                    NSData * imageData = UIImageJPEGRepresentation(uploadImage,1);
                    if (!imageData) {
                        
                        imageData = UIImagePNGRepresentation(uploadImage);
                    }
                    
                    if (configurationModel.isCompression) {
                        
                        //压缩
                        float length = [imageData length] / 1000.0;
                        if (length > 300.0) {
                            
                            float radio = [ImageCompressionController getCompressionFactorWithLength:length andExpextLength:300];
                            //需要压缩
                            willUploadData=UIImageJPEGRepresentation(uploadImage,radio);
                        }
                        else{
                            
                            willUploadData=UIImageJPEGRepresentation(uploadImage, 1);
                        }
                    }
                    else{
                        
                        //不压缩
                        willUploadData = imageData;
                    }
                }
            }
            else if ([uploadData isKindOfClass:[NSData class]]){
                
                willUploadData = uploadData;
            }
            else{
                
                if ([NSString strIsEmpty:model.uploadDataPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:model.uploadDataPath];
                }
            }
        } else if ([model.uploadDataType isEqualToString:@"Video"]){
            
            //视频
            id videoPath = model.uploadDataPath;
            if ([videoPath isKindOfClass:[NSURL class]]) {
                
                
//                [weakSelf videoWithUrl:videoPath withFileName:model.uploadDataName];
                return;
            }
            else if ([videoPath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:videoPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:model.uploadDataPath];
                }
            }
        }
        else if ([model.uploadDataType isEqualToString:@"Audio"]){
            
            //音频
            id audioPath = model.uploadDataPath;
            if ([audioPath isKindOfClass:[NSURL class]]) {
                
                NSLog(@"音频文件路径异常");
                return;
            }
            else if ([audioPath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:audioPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:model.uploadDataPath];
                }
            }
        }
        else if ([model.uploadDataType isEqualToString:@"File"]){
            
            //文件
            id filePath = model.uploadDataPath;
            if ([filePath isKindOfClass:[NSURL class]]) {
                
                NSLog(@"文件路径异常");
                return;
            }
            else if ([filePath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:filePath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:model.uploadDataPath];
                }
            }
        }
        
        model.uploadData = willUploadData;
        weakSelf.willUploadDataSize += willUploadData.length;
    }
}

//单线程上传
-(void)singleThreadUploadWithRecordingModel:(SHUploadRecordingModel *)recordingModel{
    
    __weak NewUploadController * weakSelf = self;
    [weakSelf upload:recordingModel andIndex:recordingModel.configurationModel.finishUploadCount callBack:^(NSDictionary *retultDic) {
       
        if (recordingModel.configurationModel.finishUploadCount < recordingModel.configurationModel.datasArray.count) {
            
            //数组中的数据还未上传完
            recordingModel.configurationModel.finishUploadCount++;
            [weakSelf singleThreadUploadWithRecordingModel:recordingModel];
            
            if (recordingModel.configurationModel.isCallBackSchedule) {
                
                //回调进度
                float progress = 1.0 * recordingModel.configurationModel.finishUploadCount / recordingModel.configurationModel.datasArray.count;
                recordingModel.callBack(@{@"taskIdentifier":recordingModel.configurationModel.Identification,@"progress":[NSNumber numberWithFloat:progress]});
            }
            
            
            if (recordingModel.configurationModel.isSingleReturn) {
                
                //单个数据传完就回调
                recordingModel.callBack(retultDic);
            }
            else{
                
                [recordingModel.configurationModel.callBackDatasArray addObject:retultDic];
            }
        }
        else{
            
            //全部上传完成，回调
            recordingModel.callBack(@{@"returnDicArray":recordingModel.configurationModel.callBackDatasArray});
        }
    }];
}

//多线程上传
-(void)MultiThreadedUploadWithRecordingModel:(SHUploadRecordingModel *)recordingModel{
    
    for (NSUInteger i = 0; i < recordingModel.configurationModel.datasArray.count; i++) {
        
        [self upload:recordingModel andIndex:i callBack:^(NSDictionary *retultDic) {
            
            if (recordingModel.configurationModel.finishUploadCount < recordingModel.configurationModel.datasArray.count) {
                
                //数组中的数据还未上传完
                if (recordingModel.configurationModel.isCallBackSchedule) {
                    
                    //回调进度
                    float progress = 1.0 * recordingModel.configurationModel.finishUploadCount / recordingModel.configurationModel.datasArray.count;
                    recordingModel.callBack(@{@"taskIdentifier":recordingModel.configurationModel.Identification,@"progress":[NSNumber numberWithFloat:progress]});
                }
                
                
                if (recordingModel.configurationModel.isSingleReturn) {
                    
                    //单个数据传完就回调
                    recordingModel.callBack(retultDic);
                }
                else{
                    
                    [recordingModel.configurationModel.callBackDatasArray addObject:retultDic];
                }
            }
            else{
                
                //全部上传完成，回调
                recordingModel.callBack(@{@"returnDicArray":recordingModel.configurationModel.callBackDatasArray});
            }
        }];
    }
}

/*
//使用JHNetworkRequestCompont上传
//上传
- (void)upload:(SHUploadRecordingModel *)recordingModel andIndex:(NSUInteger)index callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    __weak NewUploadController * weakSelf = self;
    NSLog(@"耗时纪录");
    SHUploadModel * uploadModel = recordingModel.configurationModel.datasArray[index];
    uploadModel.uploadState = UploadState_uploading;
    id uploadData = uploadModel.uploadData;
    __block NSData * willUploadData;
    if ([uploadModel.uploadDataType isEqualToString:@"Image"]) {
        
        //图片
        if ([uploadData isKindOfClass:[UIImage class]]) {
            
            @autoreleasepool {
                UIImage * uploadImage = (UIImage *)uploadModel.uploadData;
                NSData * imageData = UIImageJPEGRepresentation(uploadImage,1);
                if (!imageData) {
                    
                    imageData = UIImagePNGRepresentation(uploadImage);
                }
                
                if (recordingModel.configurationModel.isCompression) {
                    
                    //压缩
                    float length = [imageData length] / 1000.0;
                    if (length > 300.0) {
                        
                        float radio = [NewImageCompressionController getCompressionFactorWithLength:length andExpextLength:300];
                        //需要压缩
                        willUploadData=UIImageJPEGRepresentation(uploadImage,radio);
                    }
                    else{
                        
                        willUploadData=UIImageJPEGRepresentation(uploadImage, 1);
                    }
                }
                else{
                    
                    //不压缩
                    willUploadData = imageData;
                }
            }
        }
        else if ([uploadData isKindOfClass:[NSData class]]){
            
            willUploadData = uploadData;
        }
        else{
            
            if ([NSString strIsEmpty:uploadModel.uploadDataPath]) {
                
                //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                //上报异常命令,reason为上报异常的描述，字符串类型
                [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                return;
            }
        }
    } else if ([uploadModel.uploadDataType isEqualToString:@"Video"]){
        
        //视频
        id videoPath = uploadModel.uploadDataPath;
        if ([videoPath isKindOfClass:[NSURL class]]) {
            
            NSURL * tempVideoPath = videoPath;
            uploadModel.uploadDataPath = tempVideoPath.absoluteString;
        }
        else if ([videoPath isKindOfClass:[NSString class]]){
            
            if ([NSString strIsEmpty:videoPath]) {
                
                //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                //上报异常命令,reason为上报异常的描述，字符串类型
                [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                return;
            }
        }
    }
    else if ([uploadModel.uploadDataType isEqualToString:@"Audio"]){
        
        //音频
        id AudioPath = uploadModel.uploadDataPath;
        if ([AudioPath isKindOfClass:[NSURL class]]) {
            
            NSURL * tempAudioPath = AudioPath;
            uploadModel.uploadDataPath = tempAudioPath.absoluteString;
        }
        else if ([AudioPath isKindOfClass:[NSString class]]){
            
            if ([NSString strIsEmpty:AudioPath]) {
                
                //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                //上报异常命令,reason为上报异常的描述，字符串类型
                [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                return;
            }
        }
    }
    else if ([uploadModel.uploadDataType isEqualToString:@"File"]){
        
        //文件
        id FilePath = uploadModel.uploadDataPath;
        if ([FilePath isKindOfClass:[NSURL class]]) {
            
            NSURL * tempFilePath = FilePath;
            uploadModel.uploadDataPath = tempFilePath.absoluteString;
        }
        else if ([FilePath isKindOfClass:[NSString class]]){
            
            if ([NSString strIsEmpty:FilePath]) {
                
                //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                //上报异常命令,reason为上报异常的描述，字符串类型
                [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                return;
            }
        }
    }
    NSLog(@"耗时纪录");
  
    //添加到上传列表
    if (recordingModel.configurationModel.isAddUploadList) {
        
        NSString * dataPath;
        if ([NSString strIsEmpty:uploadModel.uploadDataPath]) {
            
            dataPath = uploadModel.uploadDataPath;
        }
        else{
            
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", uploadModel.uploadDataId]];
            [willUploadData writeToFile:filePath atomically:YES];
            dataPath = filePath;
        }
        //添加到上传列表,SourceID,资源标识;Name,资源名;DataPath,资源的二进制数据路径;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[UploadDataManagerController sharedManager] addUploadDataDic:@{@"SourceID":uploadModel.uploadDataId,@"Name":uploadModel.uploadDataName,@"DataPath":dataPath}];
        });
        
        [self.uploadDataModelArray addObject:uploadModel];
    }
    
    
    NSLog(@"开始上传开始上传开始上传");
    NSDictionary * parameter =@{@"requestUrlStr":recordingModel.configurationModel.serverUrlStr,@"businessType":[NSNumber numberWithInteger:2],@"isShowLoading":[NSNumber numberWithBool:NO],@"taskIdentifier":uploadModel.uploadDataId,@"uploadData":willUploadData?willUploadData:@"",@"uploadDataFile":[NSString strIsEmpty:uploadModel.uploadDataPath]?@"":uploadModel.uploadDataPath,@"isCallbackProgress":[NSNumber numberWithBool:YES],@"uploadDataType":uploadModel.uploadDataType};
    [SHRoutingComponent openURL:REQUESTDATA withParameter:parameter callBack:^(NSDictionary *resultDic) {
        
        //taskIdentifier,唯一标识
        if ([resultDic.allKeys containsObject:@"progress"]) {
            
            if ([uploadModel.uploadDataId isEqualToString:resultDic[@"taskIdentifier"]]) {
                
                NSNumber * progressNumber = resultDic[@"progress"];
                uploadModel.progress = progressNumber.floatValue;
            }
            
            NSDictionary * returnDic = @{@"taskIdentifier":resultDic[@"taskIdentifier"],@"progress":resultDic[@"progress"]};
            if (callBack) {
                
                callBack(returnDic);
            }
        }
        
        if ([resultDic.allKeys containsObject:@"FilePath"]) {
           
            NSString * filePath = [[NSString alloc] initWithFormat:@"%@/%@",recordingModel.configurationModel.serverUrlStr,resultDic[@"FilePath"]];
            NSDictionary * tempReturnDic = @{@"taskIdentifier":recordingModel.configurationModel.Identification,@"FilePath":filePath,@"LastWriteTime":resultDic[@"LastWriteTime"]};
            NSDictionary * returnDic = @{@"returnDicArray":@[tempReturnDic]};
            if (callBack) {
                
                callBack(returnDic);
            }
            else{
                
                recordingModel.callBack(returnDic);
            }
        }
    }];
}
*/

-(void)getUploadDataWithRecordingModel:(SHUploadRecordingModel *)recordingModel andIndex:(NSUInteger)index callBack:(void(^)(NSData * uploadData))CallBack{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        SHUploadModel * uploadModel = recordingModel.configurationModel.datasArray[index];
        id uploadData = uploadModel.uploadData;
        __block NSData * willUploadData;
        if ([uploadModel.uploadDataType isEqualToString:@"Image"]) {
            
            //图片
            if ([uploadData isKindOfClass:[UIImage class]]) {
                
                @autoreleasepool {
                    
                    UIImage * uploadImage = (UIImage *)uploadModel.uploadData;
                    NSData * imageData = UIImageJPEGRepresentation(uploadImage,1);
                    if (!imageData) {
                        
                        imageData = UIImagePNGRepresentation(uploadImage);
                    }
                    
                    if (recordingModel.configurationModel.isCompression) {
                        
                        //压缩
                        float length = [imageData length] / 1000.0;
                        if (length > 300.0) {
                            
                            float radio = [ImageCompressionController getCompressionFactorWithLength:length andExpextLength:300];
                            //需要压缩
                            willUploadData=UIImageJPEGRepresentation(uploadImage,radio);
                        }
                        else{
                            
                            willUploadData=UIImageJPEGRepresentation(uploadImage, 1);
                        }
                    }
                    else{
                        
                        //不压缩
                        willUploadData = imageData;
                    }
                    
                }
            }
            else if ([uploadData isKindOfClass:[NSData class]]){
                
                willUploadData = uploadData;
            }
            else{
                
                if ([NSString strIsEmpty:uploadModel.uploadDataPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:uploadModel.uploadDataPath];
                }
            }
        } else if ([uploadModel.uploadDataType isEqualToString:@"Video"]){
            
            //视频
            id videoPath = uploadModel.uploadDataPath;
            if ([videoPath isKindOfClass:[NSURL class]]) {
                
                [self videoSHUploadRecordingModel:recordingModel  andIndex:index];
                return;
            }
            else if ([videoPath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:videoPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:uploadModel.uploadDataPath];
                }
            }
        }
        else if ([uploadModel.uploadDataType isEqualToString:@"Audio"]){
            
            //音频
            id AudioPath = uploadModel.uploadDataPath;
            if ([AudioPath isKindOfClass:[NSURL class]]) {
                
                willUploadData = [NSData dataWithContentsOfURL:AudioPath];
            }
            else if ([AudioPath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:AudioPath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:AudioPath];
                }
            }
        }
        else if ([uploadModel.uploadDataType isEqualToString:@"File"]){
            
            //文件
            id FilePath = uploadModel.uploadDataPath;
            if ([FilePath isKindOfClass:[NSURL class]]) {
                
                willUploadData = [NSData dataWithContentsOfURL:FilePath];
            }
            else if ([FilePath isKindOfClass:[NSString class]]){
                
                if ([NSString strIsEmpty:FilePath]) {
                    
                    //异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据
                    //上报异常命令,reason为上报异常的描述，字符串类型
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据"}];
                    NSLog(@"上传组件，异常，uploadData既不是UIImage也不是NSData,uploadDataPath还为空，无上传数据");
                    return;
                }
                else{
                    
                    willUploadData = [NSData dataWithContentsOfFile:FilePath];
                }
            }
        }
        if (willUploadData) {
            
            CallBack(willUploadData);
        }
        else{
            
            CallBack(nil);
        }
    });
}

//使用AFHTTPSessionManager上传
//上传
- (void)upload:(SHUploadRecordingModel *)recordingModel andIndex:(NSUInteger)index callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    __weak NewUploadController * weakSelf = self;
    [self getUploadDataWithRecordingModel:recordingModel andIndex:index callBack:^(NSData * uploadData) {
        
        if (uploadData) {
            
            SHUploadModel * uploadModel = recordingModel.configurationModel.datasArray[index];
            NSDate * startDate = [NSDate date];
            uploadModel.startUploadDate = startDate;
            
            BOOL isAdd = NO;
            for (SHUploadModel * tempUploadModel in self.uploadDataModelArray) {
                
                if (tempUploadModel && [tempUploadModel isKindOfClass:[SHUploadModel class]] && ![NSString strIsEmpty:tempUploadModel.uploadDataId]) {
                    
                    if ([uploadModel.uploadDataId isEqualToString:tempUploadModel.uploadDataId]) {
                        
                        isAdd = YES;
                        break;
                    }
                }
            }
            
            if (!isAdd) {
                
                if (uploadModel && [uploadModel isKindOfClass:[SHUploadModel class]] && ![NSString strIsEmpty:uploadModel.uploadDataId]) {
                    
                    [self.uploadDataModelArray addObject:uploadModel];
                }
            }
            
            [weakSelf AFHTTPSessionManagerUpload:recordingModel andIndex:index andData:uploadData];
        }
        else{
            
            NSLog(@"数据转换异常");
        }
    }];
}

-(void)AFHTTPSessionManagerUpload:(SHUploadRecordingModel *)recordingModel andIndex:(NSUInteger)index andData:(NSData *)willUploadData{
    
    SHUploadModel * uploadModel = recordingModel.configurationModel.datasArray[index];
    uploadModel.uploadState = UploadState_uploading;
    //获取文件的后缀名
    NSString *extension = [uploadModel.uploadDataName componentsSeparatedByString:@"."].lastObject;
    //设置mimeType
    NSString *mimeType;
    if ([uploadModel.uploadDataType isEqualToString:@"Image"]) {
        
        mimeType = [NSString stringWithFormat:@"image/%@", extension];
    }
    else if ([uploadModel.uploadDataType isEqualToString:@"Video"]){
        
        mimeType = [NSString stringWithFormat:@"video/%@", extension];
    }
    else if ([uploadModel.uploadDataType isEqualToString:@"Audio"]){
        
        mimeType = [NSString stringWithFormat:@"audio/%@", extension];
    }
    else if ([uploadModel.uploadDataType isEqualToString:@"File"]){
        
        mimeType = [NSString stringWithFormat:@"file/%@", extension];
    }

    
    //创建AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置响应文件类型为JSON类型
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    //初始化requestSerializer
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;
    //设置timeout
    [manager.requestSerializer setTimeoutInterval:recordingModel.configurationModel.timeoutNumber.integerValue];
    //设置请求头类型
    [manager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
    //设置请求头, 授权码
    [manager.requestSerializer setValue:@"YgAhCMxEehT4N/DmhKkA/M0npN3KO0X8PMrNl17+hogw944GDGpzvypteMemdWb9nlzz7mk1jBa/0fpOtxeZUA==" forHTTPHeaderField:@"Authentication"];
    
    //IsClient，是否是客户端
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:uploadModel.uploadDataName,@"UploadFileName",[NSNumber numberWithBool:YES],@"IsClient",[NSNumber numberWithInt:0],@"StartPosition",[NSNumber numberWithFloat:willUploadData.length / 8],@"FileSize",@"1",@"isFromMobilePhone",nil];
    
    //开始上传
    NSURLSessionDataTask * task = [manager POST:recordingModel.configurationModel.serverUrlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:willUploadData name:@"FileDataFromPhone" fileName:uploadModel.uploadDataName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        uploadModel.uploadState = UploadState_uploading;
        NSNumber * progressNumber = [NSNumber numberWithDouble:1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
        //taskIdentifier,唯一标识
        uploadModel.progress = progressNumber.floatValue;
        NSDictionary * returnDic = @{@"taskIdentifier":uploadModel.uploadDataId,@"progress":progressNumber};
        if (recordingModel.callBack) {
            
            recordingModel.callBack(returnDic);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * resultDic = responseObject;
        NSDictionary * tempReturnDic = @{@"taskIdentifier":uploadModel.uploadDataId,@"FilePath":resultDic[@"FilePath"],@"LastWriteTime":resultDic[@"LastWriteTime"]};
        NSDictionary * returnDic = @{@"returnDicArray":@[tempReturnDic]};
        //移除记录的task
        [self.uploadDataModelArray removeObject:uploadModel];
        [self.uploadRecordingModelArray removeObject:recordingModel];
        
        
        if (recordingModel.callBack) {
            
            recordingModel.callBack(returnDic);
        }
        else{
            
            recordingModel.callBack(returnDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        uploadModel.uploadState = UploadState_stop;
        NSLog(@"失败");
    }];
    recordingModel.task = task;
    [self.taskDic setObject:task  forKey:uploadModel.uploadDataId];
}

-(void)videoSHUploadRecordingModel:(SHUploadRecordingModel *)recordingModel andIndex:(NSUInteger)index{
    
    SHUploadModel * uploadModel = recordingModel.configurationModel.datasArray[index];
    NSURL * url = (NSURL *)uploadModel.uploadDataPath;
    NSString * fileName = uploadModel.uploadDataName;
    
    // 解析一下,为什么视频不像图片一样一次性开辟本身大小的内存写入?
    // 想想,如果1个视频有1G多,难道直接开辟1G多的空间大小来写?
    // 创建存放原始图的文件夹--->VideoURL
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:KVideoUrlPath]) {
        
        [fileManager createDirectoryAtPath:KVideoUrlPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    __weak NewUploadController * weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                NSString * videoPath = [KVideoUrlPath stringByAppendingPathComponent:fileName];
                const char *cvideoPath = [videoPath UTF8String];
                FILE *file = fopen(cvideoPath, "a+");
                if (file) {
                    const int bufferSize = 11024 * 1024;
                    // 初始化一个1M的buffer
                    Byte *buffer = (Byte*)malloc(bufferSize);
                    NSUInteger read = 0, offset = 0, written = 0;
                    NSError* err = nil;
                    if (rep.size != 0)
                    {
                        do {
                            read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                            written = fwrite(buffer, sizeof(char), read, file);
                            offset += read;
                        } while (read != 0 && !err);//没到结尾，没出错，ok继续
                    }
                    // 释放缓冲区，关闭文件
                    free(buffer);
                    buffer = NULL;
                    fclose(file);
                    file = NULL;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSLog(@"视频大小：%lf",[weakSelf getFileSize:videoPath]);
                        
                        AVAsset *asset = [AVAsset assetWithURL:url];
                        //设置压缩质量
                        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
                        //输出MP4格式
                        session.outputFileType = AVFileTypeMPEG4;
                        // 创建导出的url
                        NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                        NSString *resultPath = [docuPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
                        session.outputURL = [NSURL fileURLWithPath:resultPath];
                        // 必须配置输出属性
                        //                        session.outputFileType = @"com.apple.quicktime-movie";
                        session.shouldOptimizeForNetworkUse = YES;
                        // 导出视频
                        [session exportAsynchronouslyWithCompletionHandler:^{
                            
                            NSLog(@"新：视频大小:%lf",[weakSelf getFileSize:resultPath]);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                uploadModel.uploadDataPath = resultPath;
                                [weakSelf upload:recordingModel andIndex:index callBack:recordingModel.callBack];
                            });
                        }];
                    });
                    
                }
            } failureBlock:nil];
        }
    });
}

// 获取视频的大小
- (CGFloat)getFileSize:(NSString *)path{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init] ;
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}

-(void)cleanMemory{
    
    //上传流程结束，上传组件初始化
}



@end
