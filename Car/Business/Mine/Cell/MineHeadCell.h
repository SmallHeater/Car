//
//  MineHeadCell.h
//  Car
//
//  Created by mac on 2019/10/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  我的页面头部cell

#import "SHBaseTableViewCell.h"
#import "UserInforModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineHeadCell : SHBaseTableViewCell

-(void)show:(UserInforModel *)userInforModel;

@end

NS_ASSUME_NONNULL_END
