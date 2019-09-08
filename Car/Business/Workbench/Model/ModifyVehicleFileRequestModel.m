//
//  ModifyVehicleFileRequestModel.m
//  Car
//
//  Created by mac on 2019/9/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ModifyVehicleFileRequestModel.h"

@implementation ModifyVehicleFileRequestModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"car_id":@"id"};
}

@end
