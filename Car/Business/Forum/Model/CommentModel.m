//
//  CommentModel.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"comId":@"id"};
}

@end
