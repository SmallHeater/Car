//
//  MotorOilController.m
//  Car
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilController.h"

@implementation MotorOilController

#pragma mark  ----  懒加载

-(NSMutableArray<OilBrandModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

+(MotorOilController *)sharedManager{
    
    static MotorOilController * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[MotorOilController alloc] init];
    });
    
    return manager;
}

#pragma mark  ----  自定义函数

//支付完成，设置所有机油初始
-(void)initializationAllOil{
    
    for (OilBrandModel * model in self.dataArray) {
        
        for (OilGoodModel * goodModel in model.goods) {
            
            if (goodModel.count > 0) {
                
                goodModel.count = 0;
                goodModel.countStr = @"";
            }
        }
    }
    
    if (self.refreshBlock) {
        
        self.refreshBlock();
    }
}

@end
