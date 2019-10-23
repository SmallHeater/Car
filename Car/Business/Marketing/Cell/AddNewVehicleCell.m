//
//  AddNewVehicleCell.m
//  Car
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AddNewVehicleCell.h"

@interface AddNewVehicleCell ()

@end

@implementation AddNewVehicleCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
