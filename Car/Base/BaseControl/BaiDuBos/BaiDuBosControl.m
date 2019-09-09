//
//  BaiDuBosControl.m
//  Car
//
//  Created by mac on 2019/9/7.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "BaiDuBosControl.h"
#import <BaiduBCEBasic/BaiduBCEBasic.h>
#import <BaiduBCEBOS/BaiduBCEBOS.h>

@interface BaiDuBosControl ()

@property (nonatomic,strong) BOSClient* client;
@property (nonatomic,strong) BOSPutObjectRequest* request;

@end

@implementation BaiDuBosControl

#pragma mark  ----  生命周期函数

+(BaiDuBosControl *)sharedManager{
    
    static BaiDuBosControl * control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        control = [[BaiDuBosControl alloc] init];
    });
    
    return control;
}

-(void)uoploadImage:(UIImage *)image{
    
    // 初始化
    BCECredentials* credentials = [[BCECredentials alloc] init];
    credentials.accessKey = @"cff28a2799b04549b752202ef41ac3da";
    credentials.secretKey = @"5bbfd04f65c446189e1fb08f54c92e3c";
    BOSClientConfiguration* configuration = [[BOSClientConfiguration alloc] init];
//    cdds.su.bcebos.com，https://bos.cdds.zyxczs.com,https://bj.bcebos.com
    configuration.endpoint = @"https://bj.bcebos.com/upload";
    configuration.scheme = @"https";
    configuration.credentials = credentials;
    BOSClient* client = [[BOSClient alloc] initWithConfiguration:configuration];
    self.client = client;
//    // 1. 新建bucket
//    BCETask* task = [client putBucket:@"carmaster"];
//    task.then(^(BCEOutput* output) { // 任务可以异步执行。
//        if (output.response) {
//            // 任务执行成功。
//            NSLog(@"任务执行成功");
//        }
//
//        if (output.error) {
//            // 任务执行失败。
//            NSLog(@"任务执行失败,%@",output.error);
//        }
//
//        if (output.progress) {
//            // 任务执行进度。
//            NSLog(@"任务执行进度");
//        }
//    });
//    [task waitUtilFinished]; // 可以同步方式，等待任务执行完毕。
    
    // 2. 上传Object
    BOSObjectContent* content = [[BOSObjectContent alloc] init];
    content.objectData.data = UIImageJPEGRepresentation(image, 1);
    
    BOSPutObjectRequest* request = [[BOSPutObjectRequest alloc] init];
    request.bucket = @"carmaster";
    NSString * imageName = [[NSUUID UUID] UUIDString];
    request.key = [[NSString alloc] initWithFormat:@"%@.jpg",imageName];
    request.objectContent = content;
    self.request = request;
    
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
            NSLog(@"The eTag is %@", response.metadata.eTag);
        }
        
        if (output.error) {
            NSLog(@"put object failure with %@", output.error);
        }
    });
    [taskOne waitUtilFinished];
}

@end
