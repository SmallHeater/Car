//
//  CarProfitStatisticsCell.m
//  Car
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarProfitStatisticsCell.h"
#import "SHLabelAndLabelView.h"

@interface CarProfitStatisticsCell ()

//车牌
@property (nonatomic,strong) SHLabelAndLabelView * numberLabelView;
@property (nonatomic,strong) UILabel * lineLabel;
//利润
@property (nonatomic,strong) SHLabelAndLabelView * profitLabelView;
//欠款
@property (nonatomic,strong) SHLabelAndLabelView * arrearsLabelView;
//应收
@property (nonatomic,strong) SHLabelAndLabelView * acceptableLabelView;
//维修量
@property (nonatomic,strong) SHLabelAndLabelView * maintenanceLabelView;

@end

@implementation CarProfitStatisticsCell

#pragma mark  ----  懒加载

-(SHLabelAndLabelView *)numberLabelView{
    
    if (!_numberLabelView) {
        
        _numberLabelView = [[SHLabelAndLabelView alloc] initWithTopStr:@"" andTopLabelHeight:20 andBottomStr:@"" andBottomHeight:20];
        [_numberLabelView setTopLabelFont:FONT14 bottomLabelFont:FONT14];
        [_numberLabelView setTopLabelTextColor:Color_999999 bottomLabelTextColor:Color_E1534A];
        [_numberLabelView setTopLabelTextAlignment:NSTextAlignmentRight bottomLabelTextAlignment:NSTextAlignmentRight];
    }
    return _numberLabelView;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DDDDDD;
    }
    return _lineLabel;
}

-(SHLabelAndLabelView *)profitLabelView{
    
    if (!_profitLabelView) {
        
        _profitLabelView = [[SHLabelAndLabelView alloc] initWithTopStr:@"利润" andTopLabelHeight:20 andBottomStr:@"0.00" andBottomHeight:20];
        [_profitLabelView setTopLabelFont:FONT14 bottomLabelFont:FONT14];
        [_profitLabelView setTopLabelTextColor:Color_999999 bottomLabelTextColor:Color_E1534A];
        [_profitLabelView setTopLabelTextAlignment:NSTextAlignmentCenter bottomLabelTextAlignment:NSTextAlignmentCenter];
    }
    return _profitLabelView;
}

-(SHLabelAndLabelView *)arrearsLabelView{
    
    if (!_arrearsLabelView) {
        
        _arrearsLabelView = [[SHLabelAndLabelView alloc] initWithTopStr:@"欠款" andTopLabelHeight:20 andBottomStr:@"0.00" andBottomHeight:20];
        [_arrearsLabelView setTopLabelFont:FONT14 bottomLabelFont:FONT14];
        [_arrearsLabelView setTopLabelTextColor:Color_999999 bottomLabelTextColor:Color_333333];
        [_arrearsLabelView setTopLabelTextAlignment:NSTextAlignmentCenter bottomLabelTextAlignment:NSTextAlignmentCenter];
    }
    return _arrearsLabelView;
}

-(SHLabelAndLabelView *)acceptableLabelView{
    
    if (!_acceptableLabelView) {
        
        _acceptableLabelView = [[SHLabelAndLabelView alloc] initWithTopStr:@"应收" andTopLabelHeight:20 andBottomStr:@"0.00" andBottomHeight:20];
        [_acceptableLabelView setTopLabelFont:FONT14 bottomLabelFont:FONT14];
        [_acceptableLabelView setTopLabelTextColor:Color_999999 bottomLabelTextColor:Color_333333];
        [_acceptableLabelView setTopLabelTextAlignment:NSTextAlignmentCenter bottomLabelTextAlignment:NSTextAlignmentCenter];
    }
    return _acceptableLabelView;
}

-(SHLabelAndLabelView *)maintenanceLabelView{
    
    if (!_maintenanceLabelView) {
        
        _maintenanceLabelView = [[SHLabelAndLabelView alloc] initWithTopStr:@"维修量" andTopLabelHeight:20 andBottomStr:@"0.00" andBottomHeight:20];
        [_maintenanceLabelView setTopLabelFont:FONT14 bottomLabelFont:FONT14];
        [_maintenanceLabelView setTopLabelTextColor:Color_999999 bottomLabelTextColor:Color_333333];
        [_maintenanceLabelView setTopLabelTextAlignment:NSTextAlignmentLeft bottomLabelTextAlignment:NSTextAlignmentLeft];
    }
    return _maintenanceLabelView;
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
    
    float viewHeight = 45;
    [self addSubview:self.numberLabelView];
    [self.numberLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.offset(0);
        make.width.offset(85);
        make.height.offset(viewHeight);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.numberLabelView.mas_right).offset(10);
        make.top.offset(17);
        make.width.offset(1);
        make.height.offset(34);
    }];
    
    
    float averageWidth = (MAINWIDTH - 91) / 4;
    [self addSubview:self.profitLabelView];
    [self.profitLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.lineLabel.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(averageWidth);
        make.height.offset(viewHeight);
    }];
    
    [self addSubview:self.arrearsLabelView];
    [self.arrearsLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.profitLabelView.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(averageWidth);
        make.height.offset(viewHeight);
    }];
    
    [self addSubview:self.acceptableLabelView];
    [self.acceptableLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.arrearsLabelView.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(averageWidth);
        make.height.offset(viewHeight);
    }];
    
    [self addSubview:self.maintenanceLabelView];
    [self.maintenanceLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.acceptableLabelView.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(averageWidth);
        make.height.offset(viewHeight);
    }];
}

//linceNumber,车牌;contacts,联系人;profit,利润;arrears,欠款;acceptable,应收;maintenance,维修量
-(void)showWithDic:(NSDictionary *)dic{
    
    [self.numberLabelView refreshTopLabelText:dic[@"linceNumber"] bottomLabelText:dic[@"contacts"]];
    NSNumber * profitNumber = dic[@"profit"];
    NSString * profitStr = [[NSString alloc] initWithFormat:@"%.2f",profitNumber.floatValue];
    [self.profitLabelView refreshTopLabelText:nil bottomLabelText:profitStr];
    
    NSNumber * arrearsNumber = dic[@"arrears"];
    NSString * arrearsStr = [[NSString alloc] initWithFormat:@"%.2f",arrearsNumber.floatValue];
    [self.arrearsLabelView refreshTopLabelText:nil bottomLabelText:arrearsStr];
    
    NSNumber * acceptableNumber = dic[@"acceptable"];
    NSString * acceptableStr = [[NSString alloc] initWithFormat:@"%.2f",acceptableNumber.floatValue];
    [self.acceptableLabelView refreshTopLabelText:nil bottomLabelText:acceptableStr];
    
    NSNumber * maintenanceNumber = dic[@"maintenance"];
    NSString * maintenanceStr = [[NSString alloc] initWithFormat:@"%.2f",maintenanceNumber.floatValue];
    [self.maintenanceLabelView refreshTopLabelText:nil bottomLabelText:maintenanceStr];
}

@end
