//
//  SHCacheManagementcomponent.h
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  缓存管理组件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCacheManagementcomponent : NSObject

//缓存方式，NSUserDefaults,key;数据库,表.
//数据只能存储基本数据类型，需要做处理
//缓存
+(void)cacheData:(id)data withKey:(NSString *)key;

//读取
+(id)obtainDataWithKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
