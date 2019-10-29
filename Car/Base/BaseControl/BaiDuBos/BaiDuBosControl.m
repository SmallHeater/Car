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
#import "SHImageCompressionController.h"

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

@end
