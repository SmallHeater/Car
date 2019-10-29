//
//  GoodsItem.h
//  Car
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油商品模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsItem : NSObject

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , copy) NSString              * deduct_stock_type;
@property (nonatomic , copy) NSString              * spec_type;
@property (nonatomic , copy) NSString              * spec_sku_id;
@property (nonatomic , assign) NSInteger              goods_spec_id;
@property (nonatomic , copy) NSString              * goods_attr;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * goods_no;
@property (nonatomic , copy) NSString              * goods_price;
@property (nonatomic , copy) NSString              * line_price;
@property (nonatomic , assign) NSInteger              goods_weight;
@property (nonatomic , assign) NSInteger              total_num;
@property (nonatomic , copy) NSString              * total_price;
@property (nonatomic , assign) NSInteger              order_id;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              createtime;

@end

NS_ASSUME_NONNULL_END
