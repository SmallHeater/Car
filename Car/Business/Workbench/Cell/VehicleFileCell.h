//
//  VehicleFileCell.h
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆档案cell


NS_ASSUME_NONNULL_BEGIN

@interface VehicleFileCell : SHBaseTableViewCell

//numberPlate,车牌;name,联系人姓名;carModel,车型号;phoneNumber,联系人电话;
-(void)showDataWithDic:(NSDictionary *)dic;

-(void)test;

@end

NS_ASSUME_NONNULL_END
