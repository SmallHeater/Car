//
//  RepaidModel.m
//  Car
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RepaidModel.h"

@implementation RepayModel

@end

@implementation RepaidModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"maintain_id":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"repaylist":@"RepayModel"};
}

@end
