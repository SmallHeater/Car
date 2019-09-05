//
//  MaintenanceRecordsOneDayModel.h
//  Car
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  一天的维修记录模型

#import <Foundation/Foundation.h>
#import "MaintenanceRecordsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceRecordsOneDayModel : NSObject

@property (nonatomic,strong) NSString * day;
@property (nonatomic,strong) NSArray<MaintenanceRecordsModel *> * list;

@end

NS_ASSUME_NONNULL_END
