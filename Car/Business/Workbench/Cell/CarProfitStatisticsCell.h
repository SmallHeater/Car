//
//  CarProfitStatisticsCell.h
//  Car
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆利润cell

NS_ASSUME_NONNULL_BEGIN

@class ProfitrankingModel;

@interface CarProfitStatisticsCell : SHBaseTableViewCell

-(void)showData:(ProfitrankingModel *)model;

@end

NS_ASSUME_NONNULL_END
