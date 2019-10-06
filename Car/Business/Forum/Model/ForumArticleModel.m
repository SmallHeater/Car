//
//  ForumArticleModel.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumArticleModel.h"

@implementation ForumArticleModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ArticleId":@"id"};
}

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"createtime"]) {
        
        if (oldValue == nil){
            
            return @"";
        }
        else{
            
            double time = [oldValue doubleValue];
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
            return date;
        }
    }
    
    return oldValue;
}

@end
