//
//  ForumDetailContentCell.h
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情页内容cell

#import "SHBaseTableViewCell.h"
#import "ForumArticleModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^RefreshBlock)();

@interface ForumDetailContentCell : SHBaseTableViewCell

@property (nonatomic,copy) RefreshBlock refreshBlock;

+(float)cellHeightWithModel:(ForumArticleModel *)model;

-(void)show:(ForumArticleModel *)model;

@end

NS_ASSUME_NONNULL_END
