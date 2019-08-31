//
//  SHCacheManagementMiddleware.m
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCacheManagementMiddleware.h"
#import "SHCacheManagementcomponent.h"


@implementation SHCacheManagementMiddleware

//缓存
+(void)cacheDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
     
        [SHCacheManagementcomponent cacheData:dic[@"CacheData"] withKey:dic[@"CacheKey"]];
    }
}

//获取数据
+(void)obtainDataWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        id dataId = [SHCacheManagementcomponent obtainDataWithKey:dic[@"CacheKey"]];
        if (callBack && dataId) {
            
            callBack(@{@"CacheData":dataId});
        }
        else{
            
            callBack(@{@"error":@"无缓存"});
        }
    }
}

@end
