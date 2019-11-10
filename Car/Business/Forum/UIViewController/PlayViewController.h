//
//  PushAndPlayViewController.h
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  播放页面

#import "SHBaseViewController.h"
#import "VideoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlayViewController : SHBaseViewController

-(instancetype)initWithVideoModel:(VideoModel *)model;

@end

NS_ASSUME_NONNULL_END
