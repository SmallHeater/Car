//
//  TotalAmountTableViewCell.h
//  Car
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  总金额cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TotalAmountTableViewCell : SHBaseTableViewCell

-(void)showTitle:(NSString *)title andContent:(NSString *)content;

-(void)refreshTitleFont:(UIFont *)font;
-(void)refreshContentFont:(UIFont *)font;
-(void)refreshContentColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
