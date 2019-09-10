//
//  UnpaidModel.m
//  Car
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UnpaidModel.h"

@implementation UnpaidModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"maintain_id":@"id"};
}

@end
