//
//  OilGoodModel.h
//  Car
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油商品模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OilGoodModel : NSObject

@property (nonatomic,strong) NSString * avatar;
//1L
@property (nonatomic,strong) NSString * capacity;
@property (nonatomic,strong) NSString * category_id;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,assign) NSUInteger createtime;
@property (nonatomic,assign) NSUInteger deduct_stock_type;
@property (nonatomic,assign) NSUInteger delivery_id;
@property (nonatomic,assign) NSUInteger goods_id;
@property (nonatomic,strong) NSString * goods_name;
@property (nonatomic,assign) NSUInteger goods_sort;
@property (nonatomic,assign) NSUInteger goods_status;
//SE
@property (nonatomic,strong) NSString * grade;
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,assign) BOOL is_delete;
@property (nonatomic,strong) NSString * origin;
@property (nonatomic,strong) NSString * pack;
@property (nonatomic,assign) NSUInteger sales_actual;
@property (nonatomic,assign) NSUInteger sales_initial;
@property (nonatomic,assign) NSUInteger spec_type;
@property (nonatomic,strong) NSArray * specs;
@property (nonatomic,assign) NSUInteger updatetime;
//0W-20
@property (nonatomic,strong) NSString * viscosity;

//已选数量
@property (nonatomic,assign) NSUInteger count;
//已选数量的字符串
@property (nonatomic,strong) NSString * countStr;

@end

NS_ASSUME_NONNULL_END
