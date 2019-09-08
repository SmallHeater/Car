//
//  VehicleFileDetailViewController.h
//  Car
//
//  Created by xianjun wang on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆档案详情页

#import "BaseTableViewController.h"


NS_ASSUME_NONNULL_BEGIN

@class VehicleFileModel;

@interface VehicleFileDetailViewController : BaseTableViewController

//刷新展示数据
-(void)showData:(VehicleFileModel *)model;

@end

NS_ASSUME_NONNULL_END
