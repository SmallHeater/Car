//
//  MaintenanceRecordsDetailViewController.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录详情页

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class VehicleFileModel;

@interface MaintenanceRecordsDetailViewController : BaseTableViewController

@property (nonatomic,strong) VehicleFileModel * vehicleFileModel;

@end

NS_ASSUME_NONNULL_END
