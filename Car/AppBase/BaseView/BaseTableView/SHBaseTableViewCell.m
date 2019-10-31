//
//  SHBaseTableViewCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaseTableViewCell.h"

@implementation SHBaseTableViewCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//默认样式
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end
