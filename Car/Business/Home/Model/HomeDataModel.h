//
//  HomeDataModel.h
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  首页数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CarouselModel,TabModel;

@interface HomeDataModel : NSObject

//轮播区数据模型数组
@property (nonatomic,strong) NSArray<CarouselModel *> * banner;
//公告区数据模型数组
@property (nonatomic,strong) NSArray<TabModel *> * tabs;

@end

NS_ASSUME_NONNULL_END
