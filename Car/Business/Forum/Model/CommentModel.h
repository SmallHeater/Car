//
//  CommentModel.h
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  评论模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic,assign) NSUInteger commentable_id;
@property (nonatomic,strong) NSString * commentable_type;
//评论内容
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * createtime;
//前端删除显示，是否删除
@property (nonatomic,assign) BOOL disabledswitch;
@property (nonatomic,assign) NSUInteger from_uid;
//"shop_name",当前评论人姓名;avatar，头像;
@property (nonatomic,strong) NSDictionary * from_user;
@property (nonatomic,assign) NSUInteger CommentId;
@property (nonatomic,assign) NSUInteger pid;
@property (nonatomic,strong) NSString * remark;
@property (nonatomic,assign) NSUInteger tab_ids;
@property (nonatomic,assign) NSUInteger thumbs;
@property (nonatomic,assign) NSUInteger to_uid;
//当前评论的上一级评论信息
@property (nonatomic,strong) NSDictionary * to_user;

@end

NS_ASSUME_NONNULL_END
