//
//  MiddlewareReflectionControl.m
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/17.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "MiddlewareReflectionControl.h"
#import "SHRoutingComponent.h"


@interface MiddlewareReflectionControl ()

//业务名和中间件类名对应关系字典
@property (nonatomic,strong) NSMutableDictionary * reflectionDic;

@end

@implementation MiddlewareReflectionControl

#pragma mark  ----  自定义函数
+(NSString *)getClassNameWithBusinessName:(NSString *)businessName{

    MiddlewareReflectionControl * control = [[MiddlewareReflectionControl alloc] init];
    if ([control.reflectionDic.allKeys containsObject:businessName]) {
        
        return control.reflectionDic[businessName];
    }
    else{
     
        //异常
        NSString * error = [[NSString alloc] initWithFormat:@"操作名:%@无对应的中间件",businessName];
        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
        NSLog(@"%@",error);
        return @"";
    }
}

#pragma mark  ----  懒加载
-(NSMutableDictionary *)reflectionDic{
    
    if (!_reflectionDic) {
        
        _reflectionDic = [[NSMutableDictionary alloc] init];
        //网络相关业务
        [_reflectionDic setObject:@"SHNetworkRequestMiddleware" forKey:@"Network"];
        
    }
    return _reflectionDic;
}

@end
