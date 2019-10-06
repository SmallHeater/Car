//
//  PostJobBaseCell.h
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布招聘信息basecell,标题，分割线

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostJobBaseCell : SHBaseTableViewCell

@property (nonatomic,strong) UILabel * titleLabel;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andShowBottomLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
