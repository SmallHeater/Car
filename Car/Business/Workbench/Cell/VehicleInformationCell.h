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

//车牌号回调
@property (nonatomic,copy) CallBack npnCallBack;
//车架号回调
@property (nonatomic,copy) CallBack vinCallBack;
//车型号回调
@property (nonatomic,copy) CallBack bmnCallBack;
//发动机号回调
@property (nonatomic,copy) CallBack enCallBack;

//数据展示:numberPlateNumber,号牌号码;vehicleIdentificationNumber,车辆识别代号;brandModelNumber,品牌型号;engineNumber,发动机号码;
-(void)showDataWithDic:(NSDictionary *)dic;
-(void)test;

@end

NS_ASSUME_NONNULL_END
