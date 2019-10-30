//
//  AddNewVehicleCell.m
//  Car
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AddNewVehicleCell.h"
#import "iOS-Echarts.h"

@interface AddNewVehicleCell ()

@property (nonatomic, strong) PYEchartsView * echartView;

//本周新增
@property (nonatomic,strong) UILabel * thisWeekAddLabel;
//本月新增
@property (nonatomic,strong) UILabel * thisMonthLabel;
//上月新增
@property (nonatomic,strong) UILabel * lastMonthLabel;

@end

@implementation AddNewVehicleCell

#pragma mark  ----  懒加载

-(PYEchartsView *)echartView{
    
    if (!_echartView) {
        
        _echartView = [[PYEchartsView alloc] init];
        _echartView.backgroundColor = [UIColor whiteColor];
        PYOption *option = [self draw];
        [self.echartView setOption:option];
        [self.echartView loadEcharts];
    }
    return _echartView;
}

-(UILabel *)thisWeekAddLabel{
    
    if (!_thisWeekAddLabel) {
        
        _thisWeekAddLabel = [[UILabel alloc] init];
        _thisWeekAddLabel.font = FONT12;
        _thisWeekAddLabel.textColor = Color_666666;
        _thisWeekAddLabel.textAlignment = NSTextAlignmentCenter;
        _thisWeekAddLabel.text = @"本周新增";
    }
    return _thisWeekAddLabel;
}

-(UILabel *)thisMonthLabel{
    
    if (!_thisMonthLabel) {
        
        _thisMonthLabel = [[UILabel alloc] init];
        _thisMonthLabel.font = FONT12;
        _thisMonthLabel.textColor = Color_666666;
        _thisMonthLabel.textAlignment = NSTextAlignmentCenter;
        _thisMonthLabel.text = @"本月新增";
    }
    return _thisMonthLabel;
}

-(UILabel *)lastMonthLabel{
    
    if (!_lastMonthLabel) {
        
        _lastMonthLabel = [[UILabel alloc] init];
        _lastMonthLabel.font = FONT12;
        _lastMonthLabel.textColor = Color_666666;
        _lastMonthLabel.textAlignment = NSTextAlignmentCenter;
        _lastMonthLabel.text = @"上月新增";
    }
    return _lastMonthLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.echartView];
    [self.echartView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.offset(0);
        make.bottom.offset(-80);
    }];
    
    float width = 50;
    
    [self addSubview:self.thisWeekAddLabel];
    [self.thisWeekAddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.offset(width);
        make.height.offset(12);
        make.bottom.offset(-50);
        make.left.offset(MAINWIDTH * 0.15);
    }];
    
    [self addSubview:self.thisMonthLabel];
    [self.thisMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(width);
        make.height.offset(12);
        make.bottom.offset(-50);
        make.left.offset(MAINWIDTH * 0.45);
    }];
    
    [self addSubview:self.lastMonthLabel];
    [self.lastMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(width);
        make.height.offset(12);
        make.bottom.offset(-50);
        make.left.offset(MAINWIDTH * 0.75);
    }];
}

-(PYOption *)draw{
    
    NSArray *radius = @[@30, @40];
    return [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"20%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .addData(@{@"name":@"15", @"value":@15, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"", @"value":@22, @"itemStyle":[self createLabelTop]});
        }])
        .addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"50%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .addData(@{@"name":@"28", @"value":@28, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"", @"value":@17, @"itemStyle":[self createLabelTop]});
        }])
        .addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"80%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .addData(@{@"name":@"0",@"value":@0, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"",@"value":@50, @"itemStyle":[self createLabelTop]});
        }]);
    }];

}

- (PYItemStyle *)createLabelTop {
    return [PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
        itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
            normal.colorEqual([PYColor colorWithHexString:@"F7F7F7"])
            .labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                label.showEqual(YES)
                .positionEqual(PYPositionCenter)
                .formatterEqual(@"{b}")
                .textStyleEqual([PYTextStyle initPYTextStyleWithBlock:^(PYTextStyle *textStyle) {
                    textStyle.baseLineEqual(PYPositionBottom)
                    .fontSizeEqual(@10);
                }]);
            }])
            .labelLineEqual([PYLabelLine initPYLabelLineWithBlock:^(PYLabelLine *labelLine) {
                labelLine.showEqual(NO);
            }]);
        }]);
    }];
}

- (PYItemStyle *)createLabelBottom {
    return [PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
        itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
            normal.colorEqual([PYColor colorWithHexString:@"A45BEC"])
            .labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                label.showEqual(YES)
                .positionEqual(PYPositionCenter)
                .textStyleEqual([PYTextStyle initPYTextStyleWithBlock:^(PYTextStyle *textStyle) {
                    textStyle.baseLineEqual(PYPositionBottom)
                    .fontSizeEqual(@20);
                }]);
            }])
            .labelLineEqual([PYLabelLine initPYLabelLineWithBlock:^(PYLabelLine *labelLine) {
                labelLine.showEqual(NO);
            }]);
        }])
        .emphasisEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *emphasis) {
            emphasis.colorEqual(PYRGBA(0, 0, 0, 0));
        }]);
    }];
}

@end
