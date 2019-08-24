//
//  FilletBtn.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 IP. All rights reserved.
//  有圆角的按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilletBtn : UIButton

+(float)getBtnWidthWithTitle:(NSString *)btnTitle andBtnFont:(UIFont *)font andBtnHeight:(float)height;


@end

NS_ASSUME_NONNULL_END
