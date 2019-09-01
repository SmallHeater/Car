//
//  SHMultipleSwitchingItemModel.m
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHMultipleSwitchingItemModel.h"

@implementation SHMultipleSwitchingItemModel


//字典转模型时修改传入数据
-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"normalFont"]) {
        
        if (oldValue) {
            
            NSNumber * fontNumber = (NSNumber *)oldValue;
            return [UIFont systemFontOfSize:fontNumber.floatValue];
        }
        else{
            
            return @"字号异常";
        }
    }
    else if ([property.name isEqualToString:@"selectedfont"]) {
        
        if (oldValue) {
            
            NSNumber * fontNumber = (NSNumber *)oldValue;
            return [UIFont systemFontOfSize:fontNumber.floatValue];
        }
        else{
            
            return @"字号异常";
        }
    }
    else if ([property.name isEqualToString:@"normalTitleColor"]) {
        
        if (oldValue) {
            
            NSString * colorStr = (NSString *)oldValue;
            return [UIColor colorFromHexRGB:colorStr];
        }
        else{
            
            return @"颜色异常";
        }
    }
    else if ([property.name isEqualToString:@"selectedTitleColor"]) {
        
        if (oldValue) {
            
            NSString * colorStr = (NSString *)oldValue;
            return [UIColor colorFromHexRGB:colorStr];
        }
        else{
            
            return @"颜色异常";
        }
    }
    return oldValue;
}

@end
