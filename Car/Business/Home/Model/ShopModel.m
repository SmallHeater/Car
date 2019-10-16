//
//  ShopModel.m
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

-(NSString *)shopIdStr{
    
    return [[NSString alloc] initWithFormat:@"%ld",self.shopId];
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"shopId":@"id",@"shopDescription":@"description"};
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"tabs":@"ShopTabModel",@"categorys":@"ShopCategoryModel"};
}

@end
