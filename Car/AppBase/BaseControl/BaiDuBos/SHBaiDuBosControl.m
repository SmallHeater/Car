//
//  SHBaiDuBosControl.m
//  Car
//
//  Created by mac on 2019/9/7.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaiDuBosControl.h"
#import <BaiduBCEBasic/BaiduBCEBasic.h>
#import <BaiduBCEBOS/BaiduBCEBOS.h>
#import <BaiduBCEVOD/BaiduBCEVOD.h>
#import "SHImageCompressionController.h"

@interface SHBaiDuBosControl ()

@property (nonatomic,strong) BOSClient* client;
@property (nonatomic,strong) BOSPutObjectRequest* request;

@end

@implementation SHBaiDuBosControl

#pragma mark  ----  生命周期函数

+(SHBaiDuBosControl *)sharedManager{
    
    static SHBaiDuBosControl * control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        control = [[SHBaiDuBosControl alloc] init];
    });
    
    return control;
}

//上传图片
-(void)uploadImage:(UIImage *)image callBack:(void (^)(NSString * _Nonnull imagePath))callback{
    
    if (image) {
     
        NSData * imageData = UIImageJPEGRepresentation(image, 1);
        float compression = [SHImageCompressionController getCompressionFactorWithLength:imageData.length andExpextLength:500];
        NSData * usedImageData = UIImageJPEGRepresentation(image, compression);
        NSLog(@"%lu,%lu",(unsigned long)imageData.length,(unsigned long)usedImageData.length);
        // 初始化
        BCECredentials* credentials = [[BCECredentials alloc] init];
        credentials.accessKey = @"cff28a2799b04549b752202ef41ac3da";
        credentials.secretKey = @"5bbfd04f65c446189e1fb08f54c92e3c";
        BOSClientConfiguration* configuration = [[BOSClientConfiguration alloc] init];
        configuration.endpoint = @"https://bj.bcebos.com";
        configuration.scheme = @"https";
        configuration.credentials = credentials;
        BOSClient* client = [[BOSClient alloc] initWithConfiguration:configuration];
        self.client = client;
        
        // 2. 上传Object
        BOSObjectContent* content = [[BOSObjectContent alloc] init];
        content.objectData.data = usedImageData;
        
        BOSPutObjectRequest* request = [[BOSPutObjectRequest alloc] init];
        request.bucket = @"carmaster";
        NSString * imageName = [[NSString alloc] initWithFormat:@"%@.jpg",[[NSUUID UUID] UUIDString]];
        request.key = imageName;
        request.objectContent = content;
        self.request = request;
        NSString * imagePath = [[NSString alloc] initWithFormat:@"https://%@bj.bcebos.com/%@",@"carmaster.",imageName];
        __block BOSPutObjectResponse* response = nil;
        BCETask* taskOne = [client putObject:request];
        taskOne.then(^(BCEOutput* output) {
            if (output.progress) {
                // 打印进度
                NSLog(@"put object progress is %@", output.progress);
            }
            
            if (output.response) {
                response = (BOSPutObjectResponse*)output.response;
                // 打印eTag
                NSLog(@"The eTag is %@,路径：%@", response.metadata.eTag,imagePath);
                callback(imagePath);
            }
            
            if (output.error) {
                NSLog(@"put object failure with %@", output.error);
            }
        });
        [taskOne waitUtilFinished];
    }
    else{
        
        callback(@"");
    }
}

//上传视频
-(void)uploadWithVideoTitle:(NSString *)videoTitle videoPath:(NSString *)path callBack:(void(^)(NSString * videoPath,NSString * imgPath))callback{
    
    if (![NSString strIsEmpty:path]) {
  
        __block NSString * videoPath = @"";
        __block NSString * imgPath = @"";
        BCETask* task;
        NSString* uploadFile = path;
        
        //1.设置AK、SK，以及BOS、VOD的endpoint
        //AKSK验证方式
        BCECredentials* credentials = [BCECredentials new];
        credentials.accessKey = @"cff28a2799b04549b752202ef41ac3da";
        credentials.secretKey = @"5bbfd04f65c446189e1fb08f54c92e3c";
        
        BOSClientConfiguration* bosConfig = [BOSClientConfiguration new];
        bosConfig.credentials = credentials;
        BOSClient* bosClient = [[BOSClient alloc] initWithConfiguration:bosConfig];
        
        VODClientConfiguration* vodConfig = [VODClientConfiguration new];
        vodConfig.credentials = credentials;
        VODClient* vodClient = [[VODClient alloc] initWithConfiguration:vodConfig];
        
        //2.生成一个mediaID并将信息存储下来
        VODGenerateMediaIDRequest* request = [[VODGenerateMediaIDRequest alloc] init];
//        request.mode = @"<mode>";
        __block VODGenerateMediaIDResponse* mediaIdResponse = nil;
        
        task = [vodClient generateMediaID:request];
        task.then(^(BCEOutput* output) {
            if (output.response) {//上传成功
                //处理相关业务逻辑
                mediaIdResponse = (VODGenerateMediaIDResponse*)output.response;
            }
            if (output.error) {
                //处理相关业务逻辑
            }
        });
        [task waitUtilFinished];
        
        //3.通过BOS上传媒资
        if (!mediaIdResponse) {
            return;
        }
        
        BOSObjectContent* content = [[BOSObjectContent alloc] init];
        content.objectData.file = uploadFile;
        
        BOSPutObjectRequest* requestTwo = [[BOSPutObjectRequest alloc] init];
        requestTwo.bucket = mediaIdResponse.sourceBucket;
        requestTwo.key = mediaIdResponse.sourceKey;
        requestTwo.objectContent = content;
        
        BCETask* taskTwo = [bosClient putObject:requestTwo];
        taskTwo.then(^(BCEOutput* output) {
            if (output.progress) {//正在上传
                //处理相关业务逻辑
                NSLog(@"进度:%lf",output.progress.floatValue);
            }
            
            if (output.response) {//上传成功
                //处理相关业务逻辑
                NSLog(@"上传成功");
            }
            
            if (output.error) {//上传错误
                //处理相关业务逻辑
            }
        });
        [taskTwo waitUtilFinished];
        
        
        //4.处理媒资
        VODProcessMediaRequest* requestThree = [VODProcessMediaRequest new];
        requestThree.mediaId = mediaIdResponse.mediaID;
        requestThree.attributes.mediaTitle = [NSString repleaseNilOrNull:videoTitle];
        requestThree.attributes.mediaDescription = @"";
        requestThree.sourceExtension = @"mp4";
//        requestThree.transcodingPresetGroupName = @"notranscoding";
        //视频id
        __block NSString * videoId = @"";
        task = [vodClient processMedia:requestThree];
        task.then(^(BCEOutput* output) {
            if (output.response) {//处理媒资请求成功
                //处理相关业务逻辑
                VODProcessMediaResponse * mediaResponse = (VODProcessMediaResponse *)output.response;
                if (mediaResponse && [mediaResponse isKindOfClass:[VODProcessMediaResponse class]]) {
                    
                    videoId = mediaResponse.mediaId;
                }
            }
            
            if (output.error) {//处理媒资请求错误
                //处理相关业务逻辑
            }
        });
        [task waitUtilFinished];
        
        //延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            //5.查询媒资状态
            __block VODGetMediaResponse* response = nil;
            BCETask* newTask = [vodClient getMedia:mediaIdResponse.mediaID];
            newTask.then(^(BCEOutput* output) {
                
                if (output.response) {//查询媒资请求成功
                    //处理相关业务逻辑
                    response = (VODGetMediaResponse*)output.response;
                    for (VODPlayableURL * urlModel in response.media.playableUrlList) {
                        
                        if ([urlModel.url containsString:videoId]) {
                            
                            videoPath = urlModel.url;
                            break;
                        }
                    }
                    
                    for (NSString * str in response.media.thumbnailList) {
                        
                        if ([str containsString:videoId]) {
                            
                            imgPath = str;
                            break;
                        }
                    }
                }
                
                if (output.error) {//查询媒资请求错误
                    //处理相关业务逻辑
                    
                }
            });
            [newTask waitUtilFinished];
            
            callback(videoPath,imgPath);
        });
    }
}

@end
