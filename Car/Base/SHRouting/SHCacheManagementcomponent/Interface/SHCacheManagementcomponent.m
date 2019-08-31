//
//  SHCacheManagementcomponent.m
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCacheManagementcomponent.h"
#import "SHCacheControl.h"

@implementation SHCacheManagementcomponent

//缓存
+(void)cacheData:(id)data withKey:(NSString *)key{
    
    [SHCacheControl cacheData:data withKey:key];
}

//读取
+(id)obtainDataWithKey:(NSString *)key{
    
    id dataId = [SHCacheControl obtainDataWithKey:key];
    return dataId;
}

@end
