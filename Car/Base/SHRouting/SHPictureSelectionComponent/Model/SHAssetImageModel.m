//
//  SHAssetModel.m
//  SHUIImagePickerController
//
//  Created by xianjunwang on 2017/10/24.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SHAssetImageModel.h"
#import <Photos/Photos.h>


@implementation SHAssetImageModel

#pragma mark  ----  生命周期函数

- (instancetype)initWithAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        _asset = asset;
    }
    
    return self;
}

- (UIImage *)originalImage {
    
    if (_originalImage) {
        return _originalImage;
    }
    __block UIImage *resultImage = nil;
    
    PHImageRequestOptions * requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.synchronous = YES;
    //原图
    [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];

    _originalImage = resultImage;
    
    return _originalImage;
}

- (UIImage *)thumbnails {
    
    if (super.thumbnails) {
        
        return super.thumbnails;
    }
    __block UIImage *resultImage;
    
    PHImageRequestOptions * requestOptions = [[PHImageRequestOptions alloc] init];
    //保证与给定大小相等
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    requestOptions.synchronous = YES;
    //加载质量
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    CGFloat width = (MAINWIDTH - 6.0 * 3)/3.0*3;
    //缩略图
  
    [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(width, width) contentMode:PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        resultImage = result;
    }];
    
    super.thumbnails = resultImage;
    
    return super.thumbnails;
}

-(UIImage *)screenSizeImage{
    
    __block UIImage *resultImage;
    
    PHImageRequestOptions * requestOptions = [[PHImageRequestOptions alloc] init];
    //保证与给定大小相等
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    requestOptions.synchronous = YES;

    //加载质量
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(1080, 1440) contentMode:PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        resultImage = result;
    }];
    
    super.thumbnails = resultImage;
    
    return super.thumbnails;
}

-(NSData *)originalImageData{
    
    __block NSData * data;
    PHImageRequestOptions * requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageDataForAsset:self.asset options:requestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        data = imageData;
    }];
    return data;
}

- (NSString *)identifier {
    return self.asset.localIdentifier;
}

@end
