//
//  CommodityCell.h
//  Car
//
//  Created by mac on 2019/9/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  残值交易cell

#import "SHBaseTableViewCell.h"
#import "ResidualTransactionModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CommodityCell : SHBaseTableViewCell

-(void)show:(ResidualTransactionModel *)model;

@end

NS_ASSUME_NONNULL_END
