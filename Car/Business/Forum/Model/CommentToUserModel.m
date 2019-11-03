//
//  CommentToUserModel.m
//  Car
//
//  Created by mac on 2019/11/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentToUserModel.h"

@implementation CommentToUserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"userId":@"id"};
}

@end
