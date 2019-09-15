//
//  SummaryAnalysisCell.h
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营业汇总的汇总分析图cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class BusinessSummaryHeaderModel,BusinessSummaryItemModel;

@interface SummaryAnalysisCell : SHBaseTableViewCell

-(void)show:(BusinessSummaryHeaderModel *)summaryModel arr:(NSArray<BusinessSummaryItemModel *> *)array;

@end

NS_ASSUME_NONNULL_END
