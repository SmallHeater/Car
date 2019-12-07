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

typedef void(^RefreshList)();

@interface MotorOilController : NSObject

//门店机油数据模型
@property (nonatomic,strong) NSMutableArray<OilBrandModel *> * dataArray;

//刷新
@property (nonatomic,copy) RefreshList refreshBlock;

+(MotorOilController *)sharedManager;
//支付完成，设置所有机油初始
-(void)initializationAllOil;

@end

NS_ASSUME_NONNULL_END
