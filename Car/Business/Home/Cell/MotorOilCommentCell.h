//
//  MotorOilCommentCell.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油评价cell

#import "SHBaseTableViewCell.h"
#import "MotorOilCommentModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MotorOilCommentCell : SHBaseTableViewCell

-(void)show:(MotorOilCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
