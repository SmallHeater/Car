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

-(NSString *)createtime{
    
    //时间戳转时间
    double time = [_createtime doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [formatter stringFromDate:date];
}

@end
