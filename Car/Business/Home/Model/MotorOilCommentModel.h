//
//  MotorOilCommentModel.h
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油评价模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MotorOilCommentModel : NSObject

//评论内容
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * createtime;
//前端删除显示，1表示删除
@property (nonatomic,assign) BOOL disabledswitch;
@property (nonatomic,assign) NSUInteger from_uid;
//avatar,id,shop_name,当前评论人姓名;
@property (nonatomic,strong) NSDictionary * from_user;
@property (nonatomic,assign) NSUInteger commentId;
@property (nonatomic,strong) NSString * images;
@property (nonatomic,assign) NSUInteger pid;
@property (nonatomic,strong) NSString * remark;
@property (nonatomic,assign) NSUInteger score;
@property (nonatomic,assign) NSUInteger shop_id;
@property (nonatomic,strong) NSString * tab_ids;
@property (nonatomic,assign) NSUInteger thumbs;
@property (nonatomic,assign) NSUInteger to_uid;

@end

NS_ASSUME_NONNULL_END
