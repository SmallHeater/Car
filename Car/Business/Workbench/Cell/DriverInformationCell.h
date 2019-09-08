//
//  DriverInformationCell.h
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  驾驶员信息cell,高194

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(NSString * result);

@class DrivingLicenseModel;
@interface DriverInformationCell : UITableViewCell

//联系人回调
@property (nonatomic,copy) CallBack contactsCallBack;
//手机号回调
@property (nonatomic,copy) CallBack phoneNumberCallBack;
//保险期回调
@property (nonatomic,copy) CallBack dataCallBack;


//数据展示
-(void)showDataWithModel:(DrivingLicenseModel *)model;
//contact,联系人;phoneNumber,手机号;InsurancePeriod,保险期;
-(void)showData:(NSDictionary *)dic;
-(void)test;

@end

NS_ASSUME_NONNULL_END
