//
//  MaintenanceRecordsDetailViewController.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录详情页

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class VehicleFileModel,MaintenanceRecordsModel;

@interface MaintenanceRecordsDetailViewController : SHBaseTableViewController

//车辆档案模型(添加维修记录时需要传)
@property (nonatomic,strong) VehicleFileModel * vehicleFileModel;
//维修记录模型(显示维修记录时传)
@property (nonatomic,strong) MaintenanceRecordsModel * maintenanceRecordsModel;

@end

NS_ASSUME_NONNULL_END
