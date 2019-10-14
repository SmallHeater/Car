//
//  SHImageViewAndLabelView.h
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  左侧imageView,然后Label,然后分割线,高 14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHImageViewAndLabelView : UIView

-(instancetype)initWithImageUrlStr:(NSString *)imageUrlStr andText:(NSString *)text andShowLine:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
