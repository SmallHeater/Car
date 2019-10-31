//
//  SHCacheControl.m
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCacheControl.h"

@implementation SHCacheControl

//缓存
+(void)cacheData:(id)data withKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//读取
+(id)obtainDataWithKey:(NSString *)key;{
    
    id dataId = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return dataId;
}

@end
