//
//  SmallVideoViewController.h
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  小视频页面

#import "SHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,VCType){
    
    VCType_Forum = 0,//论坛
    VCType_Home //首页
};

@interface SmallVideoViewController : SHBaseViewController

-(instancetype)initWithType:(VCType)type;

@end

NS_ASSUME_NONNULL_END
