//
//  VehicleFileDetailViewController.h
//  Car
//
//  Created by xianjun wang on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆档案页

#import "SHBaseTableViewController.h"


NS_ASSUME_NONNULL_BEGIN

@class VehicleFileModel;

@interface VehicleFileDetailViewController : SHBaseTableViewController

@property (nonatomic,strong) VehicleFileModel * vehicleFileModel;

@end

NS_ASSUME_NONNULL_END
