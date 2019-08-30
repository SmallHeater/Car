//
//  SHCacheControl.h
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  缓存管理控制器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCacheControl : NSObject

//缓存
+(void)cacheData:(id)data withKey:(NSString *)key;

//读取
+(id)getDataWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
