//
//  CommentModel.h
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  评论模型

#import <Foundation/Foundation.h>
#import "CommentFromUserModel.h"
#import "CommentToUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic , assign) NSInteger              comId;
@property (nonatomic , assign) NSInteger              pid;
@property (nonatomic , assign) NSInteger              commentable_id;
@property (nonatomic , copy) NSString              * commentable_type;
//评论内容
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              scope;
@property (nonatomic , assign) NSInteger              from_uid;
@property (nonatomic , assign) NSInteger              to_uid;
@property (nonatomic , assign) NSInteger              thumbs;
//前端删除显示，是否删除
@property (nonatomic , assign) BOOL              disabledswitch;
//是否点赞
@property (nonatomic , assign) BOOL              thumbed;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * tab_ids;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * floor;
@property (nonatomic , strong) CommentFromUserModel  * from_user;
@property (nonatomic , strong) CommentToUserModel    * to_user;
//原文标题
@property (nonatomic,strong) NSString * commentable_title;

@end

NS_ASSUME_NONNULL_END
