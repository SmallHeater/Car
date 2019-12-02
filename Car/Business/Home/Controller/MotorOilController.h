//
//  MotorOilController.h
//  Car
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油控制器

#import <Foundation/Foundation.h>
#import "OilBrandModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MotorOilController : NSObject

@property (nonatomic,strong) NSMutableArray<OilBrandModel *> * dataArray;


+(MotorOilController *)sharedManager;

@end

NS_ASSUME_NONNULL_END
