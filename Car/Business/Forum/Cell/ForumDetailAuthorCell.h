//
//  ForumDetailAuthorCell.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情页作者cell,高度40

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForumDetailAuthorCell : SHBaseTableViewCell

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
