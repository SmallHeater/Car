//
//  SHCacheManagementMiddleware.h
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  缓存管理组件中间件类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCacheManagementMiddleware : NSObject

//缓存
+(void)cacheDataWithDic:(NSDictionary *)dic;

//获取数据
+(void)obtainDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack;

@end

NS_ASSUME_NONNULL_END
