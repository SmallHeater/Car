//
//  DriverInformationCell.h
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  驾驶员信息cell,高194

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DrivingLicenseModel;
@interface DriverInformationCell : UITableViewCell

//数据展示
-(void)showDataWithModel:(DrivingLicenseModel *)model;
-(void)test;

@end

NS_ASSUME_NONNULL_END
