//
//  ProfitStatisticsCell.h
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  利润统计cell

NS_ASSUME_NONNULL_BEGIN

@class ProfitstatisticsModel;

typedef void(^DateCallBack)(NSString * date);

@interface ProfitStatisticsCell : SHBaseTableViewCell

@property (nonatomic,copy) DateCallBack dateCallBack;

-(void)showData:(ProfitstatisticsModel *)model;

@end

NS_ASSUME_NONNULL_END
