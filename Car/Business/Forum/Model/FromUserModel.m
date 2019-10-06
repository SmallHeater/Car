//
//  FromUserModel.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FromUserModel.h"

@implementation FromUserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"userId":@"id"};
}

@end
