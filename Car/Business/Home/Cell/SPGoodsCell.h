//
//  GoodsCell.h
//  Car
//
//  Created by xianjun wang on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  购物车机油商品cell,高114

#import "SHBaseTableViewCell.h"
#import "OilGoodModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPGoodsCell : SHBaseTableViewCell

-(void)show:(OilGoodModel *)model;

@end

NS_ASSUME_NONNULL_END
