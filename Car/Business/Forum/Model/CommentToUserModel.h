//
//  CommentToUserModel.h
//  Car
//
//  Created by mac on 2019/11/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  当前评论的上一级评论信息模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentToUserModel : NSObject

@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , copy) NSString              * floor;
@property (nonatomic , copy) NSString              * createtime;

@end

NS_ASSUME_NONNULL_END
