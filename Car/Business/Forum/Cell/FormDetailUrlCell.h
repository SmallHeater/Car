//
//  FormDetailUrlCell.h
//  Car
//
//  Created by mac on 2019/11/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情超链接cell

#import "SHBaseTableViewCell.h"
#import "ContentListItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormDetailUrlCell : SHBaseTableViewCell

+(float)cellHeight:(ContentListItemModel *)model;
-(void)show:(ContentListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
