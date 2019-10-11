//
//  PostResidualTransactionRequestModel.m
//  Car
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostResidualTransactionRequestModel.h"

@implementation PostResidualTransactionRequestModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"RTdescription":@"description"};
}

@end
