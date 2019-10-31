//
//  UIColor+SHTool.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 IP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SHTool)

+(UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(float)alpha;

+(UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

NS_ASSUME_NONNULL_END
