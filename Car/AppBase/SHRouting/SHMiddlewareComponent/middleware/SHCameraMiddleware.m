//
//  SHCameraMiddleware.m
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCameraMiddleware.h"
#import "SHCameraComponent.h"


@implementation SHCameraMiddleware

//拍照
+(void)takePhotoWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    [SHCameraComponent takePhotoWithDic:dic callBack:callBack];
}

@end
