//
//  OneOilCell.h
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  一条机油商品记录,高度81

#import "SHBaseTableViewCell.h"
#import "GoodsItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface OneOilCell : SHBaseTableViewCell

-(void)show:(GoodsItem *)model;

@end

NS_ASSUME_NONNULL_END
