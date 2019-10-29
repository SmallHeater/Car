//
//  NSAttributedString+SHTool.h
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (SHTool)

//获取字符串宽度
-(float)widthWithHeight:(float)height;

//获取字符串高度
-(float)heightWidth:(float)width;

@end

NS_ASSUME_NONNULL_END
