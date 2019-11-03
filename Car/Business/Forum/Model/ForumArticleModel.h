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
#import "ContentListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForumArticleModel : NSObject

@property (nonatomic , assign) NSInteger              ArticleId;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , strong) NSArray <NSString *>              * images;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              section_id;
@property (nonatomic , assign) NSInteger              position_id;
//目前有四种类型：zero：纯文本,single:单图、three:三图、video:视频
@property (nonatomic , copy) NSString              * type;
//浏览量
@property (nonatomic , assign) NSInteger              pv;
@property (nonatomic , copy) NSString              * tab_ids;
@property (nonatomic , assign) NSInteger              topswitch;
@property (nonatomic , assign) NSInteger              enableswitch;
@property (nonatomic , strong) NSDate            * createtime;
//点赞量
@property (nonatomic , assign) NSInteger              thumbs;
@property (nonatomic , assign) BOOL              thumbed;
//评论数
@property (nonatomic , assign) NSInteger              comments;
//所属板块
@property (nonatomic , copy) NSString              * section_title;
@property (nonatomic , strong) ADModel              * ad;
@property (nonatomic , strong) FromUserModel              * from_user;
@property (nonatomic , strong) NSArray <ContentListItemModel *>              * content_list;
@property (nonatomic , copy) NSString              * url;
//是否收藏
@property (nonatomic,assign) BOOL markered;
@end

NS_ASSUME_NONNULL_END
