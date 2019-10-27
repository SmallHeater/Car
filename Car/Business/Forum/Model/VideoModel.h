//
//  VideoModel.h
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  小视频模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel : NSObject

@property (nonatomic,assign) NSUInteger ad_endtime;
@property (nonatomic,strong) NSString * ad_url;
//用户头像
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSString * city;
//评论数量
@property (nonatomic,assign) NSUInteger comments;
@property (nonatomic,assign) NSUInteger createtime;
//视频链接
@property (nonatomic,strong) NSString * href;
@property (nonatomic,assign) NSUInteger id;
//视频首图
@property (nonatomic,strong) NSString * image;
@property (nonatomic,strong) NSString * image_s;
@property (nonatomic,assign) NSUInteger is_ad;
@property (nonatomic,assign) NSUInteger isdel;
@property (nonatomic,strong) NSString * lat;
//点赞数量
@property (nonatomic,assign) NSUInteger likes;
@property (nonatomic,strong) NSString * lng;
@property (nonatomic,assign) NSUInteger music_id;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) NSUInteger nopass_time;
@property (nonatomic,assign) NSUInteger position_id;
//分享数量
@property (nonatomic,assign) NSUInteger shares;
//用户名称
@property (nonatomic,strong) NSString * shop_name;
@property (nonatomic,assign) NSUInteger show_val;
@property (nonatomic,assign) NSUInteger sort;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSUInteger steps;
@property (nonatomic,assign) NSUInteger user_id;
//观看数量
@property (nonatomic,assign) NSUInteger views;
@property (nonatomic,assign) NSUInteger watch_ok;
@property (nonatomic,strong) NSString * xiajia_reason;

@end

NS_ASSUME_NONNULL_END
