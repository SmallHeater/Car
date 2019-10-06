//
//  PostJobRequestModel.m
//  Car
//
//  Created by mac on 2019/10/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobRequestModel.h"

@implementation PostJobRequestModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"jobDescription":@"description"};
}

@end
