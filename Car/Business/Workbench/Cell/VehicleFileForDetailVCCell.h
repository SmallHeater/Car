//
//  VehicleFileForDetailVCCell.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录详情页的车辆档案cell

NS_ASSUME_NONNULL_BEGIN

@interface VehicleFileForDetailVCCell : SHBaseTableViewCell

+(float)cellHeight;

//numberPlate,车牌;name,联系人姓名;carModel,车型号;phoneNumber,联系人电话;
-(void)showDataWithDic:(NSDictionary *)dic;

-(void)test;

@end

NS_ASSUME_NONNULL_END
