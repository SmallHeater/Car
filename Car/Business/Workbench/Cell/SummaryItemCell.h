//
//  SummaryItemCell.h
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营业汇总页面item项cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BusinessSummaryItemModel;

@interface SummaryItemCell : SHBaseTableViewCell

-(void)show:(BusinessSummaryItemModel *)model;

@end

NS_ASSUME_NONNULL_END
