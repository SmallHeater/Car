//
//  MaintenanceDetailModel.h
//  Car
//
//  Created by mac on 2019/9/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录详情模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceDetailModel : NSObject

//维修记录ID
@property (nonatomic,strong) NSString * maintain_id;
//用户ID
@property (nonatomic,strong) NSString * user_id;
//车辆ID
@property (nonatomic,strong) NSString * car_id;
//维修日期（2018-08-28）
@property (nonatomic,strong) NSString * maintain_day;
//行驶里程
@property (nonatomic,strong) NSNumber * mileage;
//关联项目:0=保养,1=维修,2=美容洗车
@property (nonatomic,strong) NSNumber * related_service;
//应收
@property (nonatomic,strong) NSNumber * receivable;
//实收
@property (nonatomic,strong) NSNumber * received;
//成本
@property (nonatomic,strong) NSNumber * cost;
//维修内容
@property (nonatomic,strong) NSString * content;
//图片(多张逗号隔开
@property (nonatomic,strong) NSString * images;


@end

NS_ASSUME_NONNULL_END
