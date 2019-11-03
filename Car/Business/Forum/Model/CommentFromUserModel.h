//
//  CommentFromUserModel.h
//  Car
//
//  Created by mac on 2019/11/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  评论来源人模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentFromUserModel : NSObject

@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * avatar;

@end

NS_ASSUME_NONNULL_END
