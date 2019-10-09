//
//  LocatingManager.h
//  Car
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  定位控制器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//isSuccess,NSNumber，定位结果;location,NSString*,位置;longitude,NSNumber,经度;latitude,NSNumber,维度;
typedef void(^CallBack)(NSDictionary * resultDic);

@interface LocatingManager : NSObject

+(LocatingManager *)sharedManager;

-(void)startLocating:(CallBack)callBack;

@end

NS_ASSUME_NONNULL_END
