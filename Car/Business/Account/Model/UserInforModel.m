//
//  UserInforModel.m
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UserInforModel.h"

@implementation UserInforModel

//改变映射关系(原先返回id，是关键字)
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"userID":@"id"};
}

@end
