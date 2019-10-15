//
//  OilBrandModel.h
//  Car
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油品牌模型

#import <Foundation/Foundation.h>
#import "OilGoodModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface OilBrandModel : NSObject

@property (nonatomic,assign) NSUInteger createtime;
@property (nonatomic,strong) NSArray<OilGoodModel *> * goods;
@property (nonatomic,assign) NSUInteger id;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) NSUInteger pid;
@property (nonatomic,assign) NSUInteger updatetime;
@property (nonatomic,assign) NSUInteger weigh;


@end

NS_ASSUME_NONNULL_END
