//
//  VideoModel.m
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"videoId":@"id"};
}

@end
