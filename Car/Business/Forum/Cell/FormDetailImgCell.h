//
//  FormDetailImgCell.h
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情图片cell

#import "SHBaseTableViewCell.h"
#import "ContentListItemModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ReloadTableViewCallBack)();

@interface FormDetailImgCell : SHBaseTableViewCell

@property (nonatomic,copy) ReloadTableViewCallBack refresh;

+(float)cellHeightWithModel:(ContentListItemModel *)model;

-(void)showModel:(ContentListItemModel *)model;

@end

NS_ASSUME_NONNULL_END
