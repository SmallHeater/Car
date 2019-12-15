//
//  IdentificationDrivingLicenseCell.h
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  识别行驶证cell

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumberCallBack)(NSString * number);

@interface IdentificationDrivingLicenseCell : SHBaseTableViewCell

@property (nonatomic,copy) NumberCallBack callBack;

@end

NS_ASSUME_NONNULL_END
