//
//  DriverInformationCell.h
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  驾驶员信息cell,高194

NS_ASSUME_NONNULL_BEGIN


@class DrivingLicenseModel;
@interface DriverInformationCell : SHBaseTableViewCell

//数据展示
-(void)showDataWithModel:(DrivingLicenseModel *)model;
//contact,联系人;phoneNumber,手机号;InsurancePeriod,保险期;
-(void)showData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
