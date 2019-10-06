//
//  ForumBaseCell.h
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛基类cell，有头像，昵称，时间，浏览量，来源，赞，评论，分享按钮

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ForumBaseCell : SHBaseTableViewCell

+(float)cellHeightWithTitle:(NSString *)title;

-(void)drawUI;

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
