//
//  MotorOilMonopolyHeaderView.h
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油购买页面头部view

#import <UIKit/UIKit.h>
#import "ShopModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MotorOilMonopolyHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

-(void)show:(ShopModel *)model;

@end

NS_ASSUME_NONNULL_END
