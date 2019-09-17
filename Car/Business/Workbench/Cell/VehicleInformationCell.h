//
//  VehicleInformationCell.h
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆信息cell,高245

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(NSString * result);

@interface VehicleInformationCell : SHBaseTableViewCell

//车牌号是否可修改
@property (nonatomic,assign) BOOL numberCanEdit;

//数据展示:numberPlateNumber,号牌号码;vehicleIdentificationNumber,车辆识别代号;brandModelNumber,品牌型号;engineNumber,发动机号码;
-(void)showDataWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
