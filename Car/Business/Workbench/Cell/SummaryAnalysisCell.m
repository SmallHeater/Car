//
//  SummaryAnalysisCell.m
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SummaryAnalysisCell.h"
#import "BusinessSummaryHeaderModel.h"
#import "BusinessSummaryItemModel.h"
#import "iOS-Echarts.h"


@interface SummaryAnalysisCell ()<UIScrollViewDelegate>

//汇总分析图
@property (nonatomic,strong) UILabel * summaryTitleLabel;
//总客户
@property (nonatomic,strong) UILabel * totalCustomerLabel;
//利润率
@property (nonatomic,strong) UILabel * profitMarginLabel;
@property (nonatomic, strong) PYEchartsView * echartView;
//底部灰条
@property (nonatomic,strong) UILabel * bottomLabel;

//月份数组
@property (nonatomic,strong) NSMutableArray * monthArray;
//利润值数组
@property (nonatomic,strong) NSMutableArray * profitArray;
//应收值数组
@property (nonatomic,strong) NSMutableArray * receivableArray;
//欠款值数组
@property (nonatomic,strong) NSMutableArray * arrearsArray;

@end



@implementation SummaryAnalysisCell

#pragma mark  ----  懒加载

-(UILabel *)summaryTitleLabel{
    
    if (!_summaryTitleLabel) {
        
        _summaryTitleLabel = [[UILabel alloc] init];
        _summaryTitleLabel.font = BOLDFONT20;
        _summaryTitleLabel.textColor = Color_333333;
        _summaryTitleLabel.text = @"汇总分析图";
    }
    return _summaryTitleLabel;
}

-(UILabel *)totalCustomerLabel{
    
    if (!_totalCustomerLabel) {
        
        _totalCustomerLabel = [[UILabel alloc] init];
        _totalCustomerLabel.font = FONT10;
        _totalCustomerLabel.textColor = Color_999999;
        _totalCustomerLabel.text = @"总客户";
    }
    return _totalCustomerLabel;
}

-(UILabel *)profitMarginLabel{
    
    if (!_profitMarginLabel) {
        
        _profitMarginLabel = [[UILabel alloc] init];
        _profitMarginLabel.font = FONT10;
        _profitMarginLabel.textColor = Color_999999;
        _profitMarginLabel.text = @"利润率";
    }
    return _profitMarginLabel;
}

-(PYEchartsView *)echartView{
    
    if (!_echartView) {
        
        _echartView = [[PYEchartsView alloc] init];
        _echartView.backgroundColor = [UIColor whiteColor];
    }
    return _echartView;
}

-(UILabel *)bottomLabel{
    
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLabel;
}

-(NSMutableArray *)monthArray{
    
    if (!_monthArray) {
        
        _monthArray = [[NSMutableArray alloc] init];
    }
    return _monthArray;
}

-(NSMutableArray *)profitArray{
    
    if (!_profitArray) {
        
        _profitArray = [[NSMutableArray alloc] init];
    }
    return _profitArray;
}

-(NSMutableArray *)receivableArray{
    
    if (!_receivableArray) {
        
        _receivableArray = [[NSMutableArray alloc] init];
    }
    return _receivableArray;
}

-(NSMutableArray *)arrearsArray{
    
    if (!_arrearsArray) {
        
        _arrearsArray = [[NSMutableArray alloc] init];
    }
    return _arrearsArray;
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
    
    [self addSubview:self.summaryTitleLabel];
    [self.summaryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(17);
        make.top.offset(20);
        make.width.offset(120);
        make.height.offset(28);
    }];
    
    [self addSubview:self.totalCustomerLabel];
    [self.totalCustomerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(20);
        make.right.offset(0);
        make.width.offset(120);
        make.height.offset(28);
    }];
    
    [self addSubview:self.profitMarginLabel];
    [self.profitMarginLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.totalCustomerLabel.mas_bottom);
        make.right.offset(0);
        make.width.equalTo(self.totalCustomerLabel.mas_width);
        make.height.offset(28);
    }];
    
    [self addSubview:self.echartView];
    [self.echartView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(78);
        make.bottom.offset(10);
    }];
    
    [self addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(10);
    }];
}

-(void)show:(BusinessSummaryHeaderModel *)summaryModel arr:(NSArray<BusinessSummaryItemModel *> *)array{
    
    NSString * totalCustomerStr = [[NSString alloc] initWithFormat:@"%@  %ld",@"总客户",summaryModel.consumer.integerValue];
    NSMutableAttributedString * attributedTotalCustomerStr = [[NSMutableAttributedString alloc] initWithString:totalCustomerStr];
    [attributedTotalCustomerStr setAttributes:@{NSFontAttributeName:FONT10,NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(0, 3)];
    [attributedTotalCustomerStr setAttributes:@{NSFontAttributeName:BOLDFONT20,NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, totalCustomerStr.length - 3)];
    self.totalCustomerLabel.attributedText = attributedTotalCustomerStr;
    
    NSString * profitMarginStr = [[NSString alloc] initWithFormat:@"%@  %.2f%@",@"利润率",summaryModel.profit_rate.floatValue,@"%"];
    NSMutableAttributedString * attributedProfitMarginStr = [[NSMutableAttributedString alloc] initWithString:profitMarginStr];
    [attributedProfitMarginStr setAttributes:@{NSFontAttributeName:FONT10,NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(0, 3)];
    [attributedProfitMarginStr setAttributes:@{NSFontAttributeName:BOLDFONT20,NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, profitMarginStr.length - 3)];
    self.profitMarginLabel.attributedText = attributedProfitMarginStr;
    
    if (array && array.count > 0) {
        
        for (BusinessSummaryItemModel * model in array) {
            
            [self.monthArray addObject:model.month];
            [self.profitArray addObject:model.profit];
            [self.receivableArray addObject:model.receivable];
            [self.arrearsArray addObject:model.debt];
        }
        
        [self showLineDemo];
    }
}

-(void)showLineDemo{
    
    __weak typeof(self) weakSelf = self;
    PYOption * option = [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.gridEqual([PYGrid initPYGridWithBlock:^(PYGrid *grid) {
            grid.xEqual(@40).x2Equal(@10);
        }])
        .tooltipEqual([PYTooltip initPYTooltipWithBlock:^(PYTooltip *tooltip) {
            tooltip.triggerEqual(PYTooltipTriggerAxis);
        }])
        .legendEqual([PYLegend initPYLegendWithBlock:^(PYLegend *legend) {
            legend.dataEqual(@[@"利润",@"应收",@"欠款"]);
        }])
        .calculableEqual(YES)
        .addXAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeCategory)
            .addDataArr(weakSelf.monthArray);
        }])
        .addYAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeValue);
        }])
        .addSeries([PYCartesianSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"利润")
            .typeEqual(PYSeriesTypeBar)
            .addDataArr(weakSelf.profitArray)   ;
        }])
        .addSeries([PYCartesianSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"应收")
            .typeEqual(PYSeriesTypeBar)
            .addDataArr(weakSelf.receivableArray);
        }])
        .addSeries([PYCartesianSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"欠款")
            .typeEqual(PYSeriesTypeBar)
            .addDataArr(weakSelf.arrearsArray)   ;
        }]);
    }];

    // 图表选项添加到图表上
    [self.echartView setOption:option];
    [self.echartView loadEcharts];
}

@end
