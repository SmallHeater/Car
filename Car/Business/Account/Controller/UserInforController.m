//
//  UserInforController.m
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UserInforController.h"

@interface UserInforController ()

@end

@implementation UserInforController

#pragma mark  ----  懒加载

-(UserInforModel *)userInforModel{
    
    if (!_userInforModel) {
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block NSDictionary * cacheDic;
        [SHRoutingComponent openURL:OBTAINCACHEDATA withParameter:@{@"CacheKey":USERINFORMODELKEY} callBack:^(NSDictionary *resultDic) {

            if ([resultDic.allKeys containsObject:@"CacheData"]) {
                
                cacheDic = resultDic[@"CacheData"];
            }
            else{
                
                cacheDic = nil;
            }
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        if (cacheDic) {
            
            _userInforModel = [UserInforModel mj_objectWithKeyValues:cacheDic];
        }
        else{
            
            _userInforModel = nil;
        }
    }
    return _userInforModel;
}

#pragma mark  ----  生命周期函数

+(UserInforController *)sharedManager{
    
    static UserInforController * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
    });
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"UserInforController"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    
    return manager;
}

//重写创建对象空间的方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHNetworkControl"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    return [self sharedManager];
}

//重写copy
-(id)copy{
    
    return [self.class sharedManager];
}

//重写mutableCopy
-(id)mutableCopy{
    
    return [self.class sharedManager];
}

#pragma mark  ----  自定义函数

@end
