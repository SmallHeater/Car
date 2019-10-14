//
//  ShopCategoryModel.h
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油门店商品类别模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCategoryModel : NSObject

@property (nonatomic,assign) NSUInteger CategoryId;
@property (nonatomic,assign) NSUInteger pid;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,assign) NSUInteger weigh;
@property (nonatomic,assign) NSUInteger createtime;
@property (nonatomic,assign) NSUInteger updatetime;

@end

NS_ASSUME_NONNULL_END
