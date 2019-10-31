//
//  SHCameraMiddleware.h
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  相机组件中间件类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCameraMiddleware : NSObject

//拍照
+(void)takePhotoWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;

@end

NS_ASSUME_NONNULL_END
