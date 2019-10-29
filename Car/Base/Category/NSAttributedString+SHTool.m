//
//  NSAttributedString+SHTool.m
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "NSAttributedString+SHTool.h"

@implementation NSAttributedString (SHTool)

//获取字符串宽度
-(float)widthWithHeight:(float)height{
    
    //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize maxSize = CGSizeMake(MAXFLOAT,height);
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return ceil(size.width);
}

//获取字符串高度
-(float)heightWidth:(float)width{
    
    //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize maxSize = CGSizeMake(width,MAXFLOAT);
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return ceil(size.height);
}

@end
