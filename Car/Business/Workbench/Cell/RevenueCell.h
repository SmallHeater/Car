//
//  RevenueCell.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  营收cell

NS_ASSUME_NONNULL_BEGIN

@interface RevenueCell : SHBaseTableViewCell

//numberPlate,车牌号;name,联系人;carModel,车型号;phoneNumber,联系电话;receivable,应收;cost,成本;profit,利润；
-(void)showDataWithDic:(NSDictionary *)dic;

-(void)test;

@end

NS_ASSUME_NONNULL_END
