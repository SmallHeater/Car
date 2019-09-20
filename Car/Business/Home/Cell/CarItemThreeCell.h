//
//  CarItemThreeCell.h
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  新闻，三图，cell

#import "SHBaseTableViewCell.h"
#import "CarItemNewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarItemThreeCell : SHBaseTableViewCell

-(void)show:(CarItemNewModel *)model;

@end

NS_ASSUME_NONNULL_END
