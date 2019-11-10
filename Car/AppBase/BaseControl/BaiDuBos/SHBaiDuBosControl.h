//
//  SHBaiDuBosControl.h
//  Car
//
//  Created by mac on 2019/9/7.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  百度BOS控制器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHBaiDuBosControl : NSObject

+(SHBaiDuBosControl *)sharedManager;

-(void)uploadImage:(UIImage *)image callBack:(void(^)(NSString * imagePath))callback;
-(void)uploadWithVideoTitle:(NSString *)videoTitle videoPath:(NSString *)path callBack:(void(^)(NSString * videoPath,NSString * imgPath))callback;

@end

NS_ASSUME_NONNULL_END
