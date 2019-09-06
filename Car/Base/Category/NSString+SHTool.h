//
//  NSString+SHTool.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 IP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SHTool)

/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
+(BOOL)strIsEmpty:(NSString *)str;
+(NSString *)repleaseNilOrNull:(NSString *)str;

//获取字符串宽度
-(float)widthWithFont:(UIFont *)font andHeight:(float)height;
//获取字符串高度
-(float)heightWithFont:(UIFont *)font andWidth:(float)width;

@end

NS_ASSUME_NONNULL_END
