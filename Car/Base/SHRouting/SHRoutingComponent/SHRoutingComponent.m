//
//  SHRoutingComponent.m
//  SHRoutingComponent
//
//  Created by xianjunwang on 2018/10/15.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHRoutingComponent.h"
#import "SHMiddlewareComponent.h"


@implementation SHRoutingComponent

#pragma mark  ----  自定义函数
+(void)openURL:(NSString *)url{
    
    if ([self checkUrl:url]) {
        
        NSMutableDictionary * dic = [self breakDownUrl:url];
        NSString * businessName = dic[@"businessName"];
        NSString * commandStr = dic[@"commandStr"];
        [SHMiddlewareComponent runCommandWithBusinessName:businessName andCommand:commandStr];
    }
}

+(void)openURL:(NSString *)url withParameter:(NSDictionary *)parameterDic{
    
    if ([self checkUrl:url] && [self checkParameter:parameterDic]) {
     
        NSMutableDictionary * dic = [self breakDownUrl:url];
        NSString * businessName = dic[@"businessName"];
        NSString * commandStr = dic[@"commandStr"];
        [SHMiddlewareComponent runCommandWithBusinessName:businessName andCommand:commandStr andInitDic:parameterDic];
    }
}

+(void)openURL:(NSString *)url callBack:(void(^)(NSDictionary *resultDic))returnBlock{
    
    if ([self checkUrl:url] && [self checkcallBack:returnBlock]) {
        
        NSMutableDictionary * dic = [self breakDownUrl:url];
        NSString * businessName = dic[@"businessName"];
        NSString * commandStr = dic[@"commandStr"];
        [SHMiddlewareComponent runCommandWithBusinessName:businessName andCommand:commandStr andCallBack:returnBlock];
    }
}

//命令URL，参数字典，block回调
+(void)openURL:(NSString *)url withParameter:(NSDictionary *)parameterDic callBack:(void(^)(NSDictionary *retultDic))returnBlock{
    
    if ([self checkUrl:url] && [self checkParameter:parameterDic] && [self checkcallBack:returnBlock]) {
     
        NSMutableDictionary * dic = [self breakDownUrl:url];
        NSString * businessName = dic[@"businessName"];
        NSString * commandStr = dic[@"commandStr"];
        [SHMiddlewareComponent runCommandWithBusinessName:businessName andCommand:commandStr andInitDic:parameterDic andCallBack:returnBlock];
    }
}


//URL合法性校验
+(BOOL)checkUrl:(NSString *)url{
    
    if (url && url.length > 0) {
        
        if ([url rangeOfString:@"://"].location != NSNotFound && [url rangeOfString:@":("].location != NSNotFound && [url rangeOfString:@")"].location != NSNotFound) {
            
            NSMutableDictionary * dic = [self breakDownUrl:url];
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                
                if ([dic.allKeys containsObject:@"businessName"] && [dic.allKeys containsObject:@"commandStr"]) {
                    
                    if ([dic[@"businessName"] isKindOfClass:[NSString class]] && [dic[@"commandStr"] isKindOfClass:[NSString class]]) {
                        
                        NSString * businessName = dic[@"businessName"];
                        NSString * commandStr = dic[@"commandStr"];
                        if (businessName.length > 0 && commandStr.length > 0){
                            
                            return YES;
                        }
                        else{
                            
                            //异常
                            NSString * error = [[NSString alloc] initWithFormat:@"当前命令异常，分割的字典中businessName或commandStr对应的值为空，命令为：%@",url];
                            [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
                            NSLog(@"%@",error);
                            return NO;
                        }
                        
                    }
                    else{
                        
                        //异常
                        NSString * error = [[NSString alloc] initWithFormat:@"当前命令异常，分割的字典中businessName或commandStr对应的值不是NSString类型，命令为：%@",url];
                        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
                        NSLog(@"%@",error);
                        return NO;
                    }
                }
                else{
                    
                    //异常
                    NSString * error = [[NSString alloc] initWithFormat:@"当前命令异常，分割的字典缺少businessName或commandStr字段，命令为：%@",url];
                    [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
                    NSLog(@"%@",error);
                    return NO;
                }
            }
            else{
                
                //异常
                NSString * error = [[NSString alloc] initWithFormat:@"当前命令异常，无法分割为字典，命令为：%@",url];
                [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
                NSLog(@"%@",error);
                return NO;
            }
        }
        else{
            
            //异常
            NSString * error = [[NSString alloc] initWithFormat:@"当前命令异常，格式不正确，命令为：%@",url];
            [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
            NSLog(@"%@",error);
            return NO;
        }
    }
    else{
        
        //异常
        NSString * error = @"当前命令异常，为空命令串";
        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
        NSLog(@"%@",error);
        return NO;
    }
}

+(NSMutableDictionary *)breakDownUrl:(NSString *)url{
    
    //BusinessFoundation://PictureSelection:(getImage:callBack)
    NSMutableString * urlStr = [[NSMutableString alloc] initWithString:url];
    NSRange firstRange = [urlStr rangeOfString:@"://"];
    NSRange secondRange = [urlStr rangeOfString:@":("];
    NSRange thirdRange = [urlStr rangeOfString:@")"];
    NSString * businessName = [urlStr substringWithRange:NSMakeRange(firstRange.location + firstRange.length, secondRange.location - firstRange.location - firstRange.length)];
    NSString * commandStr = [urlStr substringWithRange:NSMakeRange(secondRange.location + secondRange.length, thirdRange.location - secondRange.location - secondRange.length)];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:businessName forKey:@"businessName"];
    [dic setObject:commandStr forKey:@"commandStr"];
    return dic;
}

//传参合法性校验
+(BOOL)checkParameter:(NSDictionary *)parameterDic{
    
    if (parameterDic && [parameterDic isKindOfClass:[NSDictionary class]] && parameterDic.allKeys.count > 0) {
        
        return YES;
    }
    else{
        
        //异常
        NSString * error = [[NSString alloc] initWithFormat:@"命令传参异常，不是字典类型或无数据,传参：%@",parameterDic];
        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
        NSLog(@"%@",error);
        return NO;
    }
}

//回调合法性校验
+(BOOL)checkcallBack:(void(^)(NSDictionary *retultDic))returnBlock{
    
    if (returnBlock) {
        
        return YES;
    }
    else{
        
        //异常
        NSString * error = @"命令回调异常，block回调为nil";
        [SHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":error}];
        NSLog(@"%@",error);
        return NO;
    }
}


@end
