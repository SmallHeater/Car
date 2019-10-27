//
//  FrameNumberCell.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车架号查询页面cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FrameNumberCell : SHBaseTableViewCell

-(void)showTitle:(NSString *)title andContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
