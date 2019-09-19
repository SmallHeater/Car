//
//  CarItemNewModel.m
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarItemNewModel.h"

@implementation CarItemNewModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"articleID":@"id"};
}

@end
