//
//  ResidualTransactionModel.m
//  Car
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionModel.h"

@implementation ResidualTransactionModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"RTId":@"id",@"RTDescription":@"description"};
}

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"createtime"]) {
        
        if (oldValue == nil){
            
            return @"";
        }
        else{
            
            //时间戳转时间
            double time = [oldValue doubleValue];
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
            return date;
        }
    }
    
    return oldValue;
}

@end
