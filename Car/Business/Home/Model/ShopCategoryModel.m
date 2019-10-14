//
//  ShopCategoryModel.m
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ShopCategoryModel.h"

@implementation ShopCategoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"CategoryId":@"id"};
}

@end
