//
//  VehicleFileModel.m
//  Car
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleFileModel.h"

@implementation VehicleFileModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"carId":@"id"};
}

@end
