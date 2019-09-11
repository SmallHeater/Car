//
//  SHLabelAndLabelView.h
//  Car
//
//  Created by mac on 2019/9/9.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  上下两个label的view,布局说明。使用masonry,上label，上间距左右间距都为0,高度为传入高度；下label,下间距左右间距都为0.高度为传入高度；

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLabelAndLabelView : UIView

-(instancetype)initWithTopStr:(NSString *)topStr andTopLabelHeight:(float)topHeight andBottomStr:(NSString *)bottomStr andBottomHeight:(float)bottomHeight;

//刷新上面和下面label的显示内容,若传入参数为nil,则不刷新对应的label
-(void)refreshTopLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)botomLabelText;

-(void)setTopLabelFont:(UIFont *)topLabelFont bottomLabelFont:(UIFont *)botomLabelFont;

-(void)setTopLabelTextColor:(UIColor *)topLabelTextColor bottomLabelTextColor:(UIColor *)botomLabelTextColor;

-(void)setTopLabelTextAlignment:(NSTextAlignment)topLabelTextAlignment bottomLabelTextAlignment:(NSTextAlignment)botomLabelTextAlignment;
@end

NS_ASSUME_NONNULL_END
