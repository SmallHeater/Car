//
//  ReturnRecordCell.m
//  Car
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ReturnRecordCell.h"

@interface ReturnRecordCell ()

//时间
@property (nonatomic,strong) UILabel * timeLabel;
//金额
@property (nonatomic,strong) UILabel * amountLabel;

@end

@implementation ReturnRecordCell

#pragma mark  ----  懒加载

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT16;
        _timeLabel.textColor = Color_484848;
    }
    return _timeLabel;
}

-(UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = FONT16;
        _amountLabel.textColor = Color_E1534A;
    }
    return _amountLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.offset(0);
        make.height.offset(23);
        make.width.offset(150);
    }];
    
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.offset(0);
        make.height.offset(23);
        make.width.offset(150);
    }];
}

@end
