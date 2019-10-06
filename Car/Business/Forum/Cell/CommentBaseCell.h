//
//  CommentBaseCell.h
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  评论baseCell,有头像，昵称，点赞，点赞数，时间，回复，楼

#import "SHBaseTableViewCell.h"
#import "CommentModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CommentBaseCell : SHBaseTableViewCell

+(float)cellHeightWithModel:(CommentModel *)model;

-(void)show:(CommentModel *)commentModel;

@end

NS_ASSUME_NONNULL_END
