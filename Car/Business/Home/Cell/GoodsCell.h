//
//  GoodsCell.h
//  Car
//
//  Created by xianjun wang on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油商品cell,高100,底部留白7

#import "SHBaseTableViewCell.h"
#import "OilGoodModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : SHBaseTableViewCell

-(void)show:(OilGoodModel *)model;

@end

NS_ASSUME_NONNULL_END
