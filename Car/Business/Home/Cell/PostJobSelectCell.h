//
//  PostJobSelectCell.h
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布招聘信息选择cell

#import "PostJobBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostJobSelectCell : PostJobBaseCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andShowBottomLine:(BOOL)isShow;

-(void)refreshLabel:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
