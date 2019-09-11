//
//  CarProfitStatisticsCell.h
//  Car
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆利润cell

#import "SHTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarProfitStatisticsCell : SHTableViewCell

//linceNumber,车牌;contacts,联系人;profit,利润;arrears,欠款;acceptable,应收;maintenance,维修量
-(void)showWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
