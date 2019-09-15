//
//  SummaryItemCell.m
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SummaryItemCell.h"
#import "BusinessSummaryItemModel.h"


@interface SummaryItemCell ()

//月份
@property (nonatomic,strong) UILabel * monthLabel;
//应收
@property (nonatomic,strong) UILabel * acceptableLabel;
//成本
@property (nonatomic,strong) UILabel * costLabel;
//欠款
@property (nonatomic,strong) UILabel * arrearsLabel;
//利润
@property (nonatomic,strong) UILabel * profitLabel;
//新客
@property (nonatomic,strong) UILabel * myNewGuestLabel;
//维修
@property (nonatomic,strong) UILabel * serviceLabel;

@end

@implementation SummaryItemCell

#pragma mark  ----  懒加载

-(UILabel *)monthLabel{
    
    if (!_monthLabel) {
        
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = FONT12;
        _monthLabel.textColor = Color_333333;
        _monthLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _monthLabel;
}

-(UILabel *)acceptableLabel{
    
    if (!_acceptableLabel) {
        
        _acceptableLabel = [[UILabel alloc] init];
        _acceptableLabel.font = FONT12;
        _acceptableLabel.textColor = Color_333333;
        _acceptableLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _acceptableLabel;
}

-(UILabel *)costLabel{
    
    if (!_costLabel) {
        
        _costLabel = [[UILabel alloc] init];
        _costLabel.font = FONT12;
        _costLabel.textColor = Color_333333;
        _costLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _costLabel;
}

-(UILabel *)arrearsLabel{
    
    if (!_arrearsLabel) {
        
        _arrearsLabel = [[UILabel alloc] init];
        _arrearsLabel.font = FONT12;
        _arrearsLabel.textColor = Color_333333;
        _arrearsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _arrearsLabel;
}

-(UILabel *)profitLabel{
    
    if (!_profitLabel) {
        
        _profitLabel = [[UILabel alloc] init];
        _profitLabel.font = FONT12;
        _profitLabel.textColor = Color_333333;
        _profitLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _profitLabel;
}

-(UILabel *)myNewGuestLabel{
    
    if (!_myNewGuestLabel) {
        
        _myNewGuestLabel = [[UILabel alloc] init];
        _myNewGuestLabel.font = FONT12;
        _myNewGuestLabel.textColor = Color_333333;
        _myNewGuestLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _myNewGuestLabel;
}

-(UILabel *)serviceLabel{
    
    if (!_serviceLabel) {
        
        _serviceLabel = [[UILabel alloc] init];
        _serviceLabel.font = FONT12;
        _serviceLabel.textColor = Color_333333;
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _serviceLabel;
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
    
    float labelWidth = (MAINWIDTH - 16 * 2) / 7;
    [self addSubview:self.monthLabel];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.acceptableLabel];
    [self.acceptableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.monthLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.costLabel];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.acceptableLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.arrearsLabel];
    [self.arrearsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.costLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.profitLabel];
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.arrearsLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.myNewGuestLabel];
    [self.myNewGuestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.profitLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
    
    [self addSubview:self.serviceLabel];
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.myNewGuestLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(labelWidth);
    }];
}

-(void)show:(BusinessSummaryItemModel *)model{
    
    self.monthLabel.text = model.month;
    
    NSString * acceptableStr = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue];
    self.acceptableLabel.text = acceptableStr;
    
    NSString * costStr = [[NSString alloc] initWithFormat:@"%.2f",model.cost.floatValue];
    self.costLabel.text = costStr;
    
    NSString * arrearsStr = [[NSString alloc] initWithFormat:@"%.2f",model.debt.floatValue];
    self.arrearsLabel.text = arrearsStr;
    
    NSString * profitStr = [[NSString alloc] initWithFormat:@"%.2f",model.profit.floatValue];
    self.profitLabel.text = profitStr;
    
    NSString * newGuestStr = [[NSString alloc] initWithFormat:@"%.2f",model.xinke.floatValue];
    self.myNewGuestLabel.text = newGuestStr;
    
    NSString * serviceStr = [[NSString alloc] initWithFormat:@"%.2f",model.weixiu.floatValue];
    self.serviceLabel.text = serviceStr;
}

@end
