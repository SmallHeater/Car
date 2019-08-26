//
//  NSString+SHTool.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 IP. All rights reserved.
//

#import "NSString+SHTool.h"

@implementation NSString (SHTool)

#pragma mark  ----  自定义函数
/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty {
    
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

-(NSString *)repleaseNilOrNull{
    
    if (!self) {
        
        return @"";
    }
    else{
        
        return self;
    }
}

//获取字符串宽度
-(float)widthWithFont:(UIFont *)font andHeight:(float)height{
    
    //字体属性，设置字体的font
    NSDictionary *attributes = @{NSFontAttributeName:font};
    //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize maxSize = CGSizeMake(MAXFLOAT,height);
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size; return ceil(size.width);
    return size.width;
}

@end