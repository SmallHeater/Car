//
//  ForumArticleModel.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛文章模型

#import <Foundation/Foundation.h>
#import "ADModel.h"
#import "FromUserModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ForumArticleModel : NSObject

@property (nonatomic,assign) NSUInteger ArticleId;
@property (nonatomic,assign) NSUInteger position_id;
//浏览量
@property (nonatomic,assign) NSUInteger pv;
@property (nonatomic,assign) NSDate * createtime;
//点赞量
@property (nonatomic,assign) NSUInteger thumbs;
//评论数
@property (nonatomic,assign) NSUInteger comments;
//所属板块
@property (nonatomic,strong) NSString * section_title;
@property (nonatomic,strong) ADModel * ad;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,assign) NSUInteger user_id;
//single,单图
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * tab_ids;
@property (nonatomic,strong) FromUserModel * from_user;
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,assign) NSUInteger section_id;
@property (nonatomic,assign) BOOL topswitch;
@property (nonatomic,assign) BOOL enableswitch;
@property (nonatomic,strong) NSString * content;

@end

NS_ASSUME_NONNULL_END
