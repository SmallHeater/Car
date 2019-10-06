//
//  ForumDetailCell.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情页标题cell

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForumDetailTitleCell : SHBaseTableViewCell

+(float)cellHeightWithModel:(ForumArticleModel *)model;

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
