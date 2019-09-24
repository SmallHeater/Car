//
//  MotorOilMonopolyCell.m
//  Car
//
//  Created by mac on 2019/9/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyCell.h"

@interface MotorOilMonopolyCell ()

@end

@implementation MotorOilMonopolyCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
