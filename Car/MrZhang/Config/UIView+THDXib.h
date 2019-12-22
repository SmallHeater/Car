//
//  UIView+THDXib.h
//  THDTableDataSourceDemo
//
//  Created by HanXiaoTeng on 2017/12/26.
//  Copyright © 2017年 brefChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (THDXib)
@property (nonatomic, assign) IBInspectable BOOL     masksToBounds;
@property (nonatomic, assign) IBInspectable CGFloat  cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat  borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat  defineValue;
+ (instancetype)viewFromXib;


@end
