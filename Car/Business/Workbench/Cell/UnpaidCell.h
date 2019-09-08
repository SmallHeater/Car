//
//  UnpaidCell.h
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  未回款cell

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UnpaidCell : UITableViewCell

+(float)cellHeight;

//展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;receivable:应收款;actualHarvest:实收款;arrears:欠款;
-(void)showDataWithDic:(NSDictionary *)dic;

-(void)test;

@end

NS_ASSUME_NONNULL_END
