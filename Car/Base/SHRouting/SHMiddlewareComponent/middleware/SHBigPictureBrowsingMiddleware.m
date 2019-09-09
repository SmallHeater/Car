//
//  JHBigPictureBrowsingMiddleware.m
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/17.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHBigPictureBrowsingMiddleware.h"
#import "SHBigPictureBrowsing.h"


@implementation SHBigPictureBrowsingMiddleware


#pragma mark  ----  自定义函数
+(void)bigPictureBrowsing:(NSDictionary *)initDic{
    
    if ([self checkInitDic:initDic]) {
     
        NSMutableArray * dataArray = [[NSMutableArray alloc] initWithArray:initDic[@"dataArray"]];
        NSUInteger selectedIndex = 0;
        if ([initDic.allKeys containsObject:@"selectedIndex"]) {
            
            NSNumber * selectedIndexNumber = initDic[@"selectedIndex"];
            selectedIndex = selectedIndexNumber.integerValue;
        }
        [SHBigPictureBrowsing showViewWithArray:dataArray andSelectedIndex:selectedIndex];
    }
}

+(BOOL)checkInitDic:(NSDictionary *)initDic{
    
    if ([initDic.allKeys containsObject:@"dataArray"]) {
        
        NSArray * dataArray = initDic[@"dataArray"];
        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
            
            return YES;
        }
        else{
            
            //异常
            [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"去大图浏览传参图片数组参数有问题"}];
            return NO;
        }
    }
    else{
        
        //异常
        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":@"去大图浏览传参没有图片数组参数"}];
        return NO;
    }
}

@end
