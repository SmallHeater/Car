//
//  SHHighOrderPositioningController.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  高德定位控制器(因为一一旦销毁就无法定位，所以需要使用单例模式)

#import <Foundation/Foundation.h>
#import "SHPositioningResultModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PositioningCallBack)(SHPositioningResultModel * result);

@interface SHHighOrderPositioningController : NSObject

//结果回调
@property (nonatomic,copy) PositioningCallBack callBack;


+(SHHighOrderPositioningController *)sharedManager;

//定位
-(void)startPositioning;

@end

NS_ASSUME_NONNULL_END
