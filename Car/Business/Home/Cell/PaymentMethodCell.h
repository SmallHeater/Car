//
//  PaymentMethodCell.h
//  Car
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  支付方式cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentMethodCell : SHBaseTableViewCell

-(void)show:(NSString *)imageName titleStr:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
