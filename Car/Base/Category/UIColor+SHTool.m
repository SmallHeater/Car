//
//  UIColor+SHTool.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 IP. All rights reserved.
//

#import "UIColor+SHTool.h"

@implementation UIColor (SHTool)

+(UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(float)alpha{
    
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString{
    
    return [self colorFromHexRGB:inColorString alpha:1.0];
}

@end
