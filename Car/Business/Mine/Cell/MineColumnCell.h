//
//  MineColumnCell.h
//  Car
//
//  Created by xianjun wang on 2019/10/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  我的页面，栏目cell,我的消息，我的帖子，机油返现，采购记录，关于平台

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineColumnCell : SHBaseTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andCount:(NSUInteger)count;

-(void)show:(NSString *)iconName andTitle:(NSString *)title;
-(void)showCount:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
