//
//  AnnouncementModel.h
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  公告数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementModel : NSObject

@property (nonatomic,strong) NSString * AnnouncementId;
//显示的内容
@property (nonatomic,strong) NSString * content;
//跳转链接，有则跳转，无则不跳转
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * position_id;

@end

NS_ASSUME_NONNULL_END
