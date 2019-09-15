//
//  FastPickUpViewController.h
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  快速接车页面

#import "BaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class DrivingLicenseModel;

@interface FastPickUpViewController : BaseUIViewController

//行驶证模型
@property (nonatomic,strong) DrivingLicenseModel * drivingLicenseModel;

@end

NS_ASSUME_NONNULL_END
