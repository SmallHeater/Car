//
//  SHCameraComponent.h
//  Car
//
//  Created by mac on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  相机组件接口类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCameraComponent : NSObject

//去拍照
+(void)takePhotoWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;

@end

NS_ASSUME_NONNULL_END
