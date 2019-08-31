//
//  WorkbenchModel.h
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  工作台数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CarouselModel,AnnouncementModel;

@interface WorkbenchModel : NSObject

//轮播区数据模型数组
@property (nonatomic,strong) NSArray<CarouselModel *> * banner;
//公告区数据模型数组
@property (nonatomic,strong) NSArray<AnnouncementModel *> * notice;

@end

NS_ASSUME_NONNULL_END
