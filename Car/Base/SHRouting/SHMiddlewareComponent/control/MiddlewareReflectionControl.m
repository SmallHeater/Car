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
        //相册浏览组件
        [_reflectionDic setObject:@"JHPictureSelectionMiddleware" forKey:@"PictureSelection"];
        //大图查看组件
        [_reflectionDic setObject:@"JHBigPictureBrowsingMiddleware" forKey:@"BigPictureBrowsing"];
        //加密组件
        [_reflectionDic setObject:@"JHEncryptionMiddleware" forKey:@"EncryptionComponent"];
        //数据采集组件
        [_reflectionDic setObject:@"JHDataStatisticsMiddleware" forKey:@"DataStatisticsComponent"];
        //账户体系组件
        [_reflectionDic setObject:@"JHAccountSystemMiddleware" forKey:@"AccountSystemComponent"];
        //上传组件
        [_reflectionDic setObject:@"JHUploadMiddleware" forKey:@"UploadComponent"];
        //直播业务
        [_reflectionDic setObject:@"JHLiveMiddleware" forKey:@"Live"];
        //播放业务
        [_reflectionDic setObject:@"JHPlayMiddleware" forKey:@"Play"];
        //网络相关业务
        [_reflectionDic setObject:@"JHNetworkRequestMiddleware" forKey:@"Network"];
        
    }
    return _reflectionDic;
}

@end
