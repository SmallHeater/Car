//
//  ItemNewsCell.h
//  Car
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  菜单项的新闻列表的cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemNewsCell : SHBaseTableViewCell

+(float)cellHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTabIDsArray:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
