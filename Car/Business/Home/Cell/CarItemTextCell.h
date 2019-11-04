//
//  CarItemSingleCell.h
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  新闻,纯文本，cell

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CarItemTextCell : SHBaseTableViewCell

+(float)cellHeight:(ForumArticleModel *)model;

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
