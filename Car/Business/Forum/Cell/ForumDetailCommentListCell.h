//
//  ForumDetailCommentListCell.h
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情页评论列表cell

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ForumDetailCommentListCell : SHBaseTableViewCell

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
