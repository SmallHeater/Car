//
//  CarouselDataModel.h
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarouselDataModel : NSObject

@property (nonatomic,strong) NSString * CarouselId;
// 默认0：图片
@property (nonatomic,strong) NSString * type;
//显示的图片
@property (nonatomic,strong) NSString * CarouselImageUrlStr;
//是否显示：0不显示、1显示
@property (nonatomic,assign) BOOL showswitch;
//跳转链接，有则跳转，无则不跳转
@property (nonatomic,strong) NSString * urlStr;


@end

NS_ASSUME_NONNULL_END
