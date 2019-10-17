//
//  AgentCell.h
//  Car
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖代理商cell

#import "SHBaseTableViewCell.h"
#import "ShopModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AgentCell : SHBaseTableViewCell

-(void)show:(ShopModel *)model;

@end

NS_ASSUME_NONNULL_END
