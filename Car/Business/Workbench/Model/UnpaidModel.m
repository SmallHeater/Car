//
//  UnpaidModel.m
//  Car
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UnpaidModel.h"

@implementation UnpaidModel

-(NSString *)createtime{
    
    //时间戳转时间
    double time = [_createtime doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [formatter stringFromDate:date];
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"maintain_id":@"id"};
}

@end
