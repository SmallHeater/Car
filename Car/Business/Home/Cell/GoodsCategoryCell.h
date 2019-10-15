//
//  GoodsCategoryCell.h
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  商品分类cell，高75

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCategoryCell : SHBaseTableViewCell

-(void)show:(NSString *)title count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
