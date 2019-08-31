//
//  UserInforController.h
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  用户信息控制器

#import <Foundation/Foundation.h>
#import "UserInforModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserInforController : NSObject

//用户信息模型指针，若本地无缓存，初始时为nil
@property (nonatomic,strong) UserInforModel * userInforModel;

+(UserInforController *)sharedManager;


@end

NS_ASSUME_NONNULL_END
