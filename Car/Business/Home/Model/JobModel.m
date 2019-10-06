//
//  JobModel.m
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobModel.h"

@implementation JobModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"jobModelId":@"id",@"jobDescription":@"description"};
}

@end
