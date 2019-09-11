//
//  SHTableViewCell.m
//  Car
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHTableViewCell.h"

@implementation SHTableViewCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
