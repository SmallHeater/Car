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
        
        make.left.right.top.bottom.offset(0);
    }];
}

-(PYOption *)draw{
    
    NSArray *radius = @[@20, @35];
    return [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"20%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .itemStyleEqual([self createLabelFromatter])
            .addData(@{@"name":@"15", @"value":@15, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"Messenger", @"value":@22, @"itemStyle":[self createLabelTop]});
        }])
        .addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"50%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .itemStyleEqual([self createLabelFromatter])
            .addData(@{@"name":@"28", @"value":@83, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"Whatsapp", @"value":@17, @"itemStyle":[self createLabelTop]});
        }])
        .addSeries([PYPieSeries initPYPieSeriesWithBlock:^(PYPieSeries *series) {
            series.centerEqual(@[@"80%", @"50%"])
            .radiusEqual(radius)
            .typeEqual(PYSeriesTypePie)
            .itemStyleEqual([self createLabelFromatter])
            .addData(@{@"value":@15, @"itemStyle":[self createLabelBottom]})
            .addData(@{@"name":@"100", @"value":@50, @"itemStyle":[self createLabelTop]});
        }]);
    }];

}

- (PYItemStyle *)createLabelTop {
    return [PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
        itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
            normal.labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                label.showEqual(YES)
                .positionEqual(PYPositionCenter)
                .formatterEqual(@"{b}")
                .textStyleEqual([PYTextStyle initPYTextStyleWithBlock:^(PYTextStyle *textStyle) {
                    textStyle.baseLineEqual(PYPositionBottom)
                    .fontSizeEqual(@6);
                }]);
            }])
            .labelLineEqual([PYLabelLine initPYLabelLineWithBlock:^(PYLabelLine *labelLine) {
                labelLine.showEqual(NO);
            }]);
        }]);
    }];
}

- (PYItemStyle *)createLabelFromatter {
    return [PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
        itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
            normal.labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                label.formatterEqual(@"(function (params){return 100 - params.value + '%'})")
                .positionEqual(PYPositionCenter)
                .textStyleEqual([PYTextStyle initPYTextStyleWithBlock:^(PYTextStyle *textStyle) {
                    textStyle.baseLineEqual(PYPositionTop)
                    .fontSizeEqual(@6);
                }]);
            }]);
        }]);
    }];
}

- (PYItemStyle *)createLabelBottom {
    return [PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
        itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *normal) {
            normal.colorEqual([PYColor colorWithHexString:@"F7F7F7"])
            .labelEqual([PYLabel initPYLabelWithBlock:^(PYLabel *label) {
                label.showEqual(YES)
                .positionEqual(PYPositionCenter);
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
