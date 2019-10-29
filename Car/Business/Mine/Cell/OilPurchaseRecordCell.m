//
//  OilPurchaseRecordCell.m
//  Car
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "OilPurchaseRecordCell.h"
#import "SHBaseTableView.h"
#import "OneOilCell.h"

static NSString * cellId = @"OneOilCell";

@interface OilPurchaseRecordCell ()<UITableViewDelegate,UITableViewDataSource>

//编号
@property (nonatomic,strong) UILabel * numberingLabel;
//日期
@property (nonatomic,strong) UILabel * dateLabel;
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<GoodsItem *> * dataArray;
//商品件数
@property (nonatomic,strong) UILabel * goodsNumberLabel;
//总价
@property (nonatomic,strong) UILabel * totalPriceLabel;
//红包
@property (nonatomic,strong) UILabel * redEnvelopeLabel;
//实付
@property (nonatomic,strong) UILabel * actuallyPaidLabel;
//底部分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation OilPurchaseRecordCell

#pragma mark  ----  懒加载

-(UILabel *)numberingLabel{
    
    if (!_numberingLabel) {
        
        _numberingLabel = [[UILabel alloc] init];
        _numberingLabel.font = FONT14;
    }
    return _numberingLabel;
}

-(UILabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT14;
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSMutableArray<GoodsItem *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(UILabel *)goodsNumberLabel{
    
    if (!_goodsNumberLabel) {
        
        _goodsNumberLabel = [[UILabel alloc] init];
        _goodsNumberLabel.font = FONT13;
        _goodsNumberLabel.textColor = Color_333333;
    }
    return _goodsNumberLabel;
}

-(UILabel *)totalPriceLabel{
    
    if (!_totalPriceLabel) {
        
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.font = FONT13;
        _totalPriceLabel.textColor = Color_333333;
    }
    return _totalPriceLabel;
}

-(UILabel *)redEnvelopeLabel{
    
    if (!_redEnvelopeLabel) {
        
        _redEnvelopeLabel = [[UILabel alloc] init];
        _redEnvelopeLabel.backgroundColor = Color_FFEBEB;
        _redEnvelopeLabel.font = FONT10;
        _redEnvelopeLabel.textColor = Color_FF4C4B;
    }
    return _redEnvelopeLabel;
}

-(UILabel *)actuallyPaidLabel{
    
    if (!_actuallyPaidLabel) {
        
        _actuallyPaidLabel = [[UILabel alloc] init];
        _actuallyPaidLabel.textColor = Color_FF4C4B;
        _actuallyPaidLabel.font = FONT13;
    }
    return _actuallyPaidLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    cellHeight += self.dataArray.count * 81;
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneOilCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[OneOilCell alloc] initWithReuseIdentifier:cellId];
    }
    
    GoodsItem * model = self.dataArray[indexPath.row];
    [cell show:model];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    //编号，日期，一半一半
    float interval = 16;
    float numberingWidth = (MAINWIDTH - interval * 2) / 2;
    float numberingHeight = 20;
    [self addSubview:self.numberingLabel];
    [self.numberingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(interval);
        make.top.offset(15);
        make.width.offset(numberingWidth);
        make.height.offset(numberingHeight);
    }];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-interval);
        make.top.equalTo(self.numberingLabel.mas_top);
        make.width.offset(numberingWidth);
        make.height.offset(numberingHeight);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.offset(10);
    }];
    [self addSubview:self.tableView];
    [self addSubview:self.actuallyPaidLabel];
    [self addSubview:self.goodsNumberLabel];
}

+(float)cellHeightWithModel:(OilPurchaseRecord *)model{
    
    float cellHeight = 110;
    if (model.goods && [model.goods isKindOfClass:[NSArray class]]) {
     
        cellHeight += model.goods.count * 81;
    }
    return cellHeight;
}
-(void)show:(OilPurchaseRecord *)model{
    
    if (model) {
        
        //编号
        NSString * numberingStr = @"";
        if (![NSString strIsEmpty:model.order_no]) {
            
            numberingStr = [[NSString alloc] initWithFormat:@"编号：%@",model.order_no];
        }
        
        NSMutableAttributedString * numberingAttStr = [[NSMutableAttributedString alloc] initWithString:numberingStr];
        [numberingAttStr addAttributes:@{NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(0, 3)];
        [numberingAttStr addAttributes:@{NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(3, numberingAttStr.length - 3)];
        self.numberingLabel.attributedText = numberingAttStr;
        //日期
        NSString * dateStr = @"";
        if (![NSString strIsEmpty:model.createtime]) {
            
            dateStr = [[NSString alloc] initWithFormat:@"日期：%@",model.createtime];
        }
        
        NSMutableAttributedString * dateAttStr = [[NSMutableAttributedString alloc] initWithString:dateStr];
        [dateAttStr addAttributes:@{NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(0, 3)];
        [dateAttStr addAttributes:@{NSForegroundColorAttributeName:Color_999999} range:NSMakeRange(3, dateAttStr.length - 3)];
        self.dateLabel.attributedText = dateAttStr;
        
        
        float payPrice = 0.0;
        if (![NSString strIsEmpty:model.pay_price]) {
            
            payPrice = model.pay_price.floatValue;
        }
        float actuallyPaidHeight = 24;
        NSString * actuallyPaidStr = [[NSString alloc] initWithFormat:@"实付:￥%.2f",payPrice];
        NSMutableAttributedString * actuallyPaidAttStr = [[NSMutableAttributedString alloc] initWithString:actuallyPaidStr];
        [actuallyPaidAttStr addAttributes:@{NSFontAttributeName:FONT13,NSForegroundColorAttributeName:Color_FF4C4B} range:NSMakeRange(0, 3)];
        [actuallyPaidAttStr addAttributes:@{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:Color_FF4C4B} range:NSMakeRange(3, 1)];
        [actuallyPaidAttStr addAttributes:@{NSFontAttributeName:FONT17,NSForegroundColorAttributeName:Color_FF4C4B} range:NSMakeRange(4, actuallyPaidAttStr.length - 4)];
        self.actuallyPaidLabel.attributedText = actuallyPaidAttStr;
        float actuallyPaidWidth = [actuallyPaidAttStr widthWithHeight:actuallyPaidHeight];
        [self.actuallyPaidLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-16);
            make.bottom.equalTo(self.bottomLineLabel.mas_top).offset(-15);
            make.width.offset(actuallyPaidWidth);
            make.height.offset(actuallyPaidHeight);
        }];
        
        
        NSUInteger count = 0;
        if (model.goods && [model.goods isKindOfClass:[NSArray class]]) {
            
            count = model.goods.count;
        }
        
        NSString * goodsNumberStr = [[NSString alloc] initWithFormat:@"共%ld件",count];
        self.goodsNumberLabel.text = goodsNumberStr;
        float goodsNumberHeight = 20;
        float goodsNumberWidth = [goodsNumberStr widthWithFont:FONT14 andHeight:goodsNumberHeight];
        [self.goodsNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.actuallyPaidLabel.mas_left).offset(-24);
            make.bottom.equalTo(self.actuallyPaidLabel.mas_bottom);
            make.width.offset(goodsNumberWidth);
            make.height.offset(goodsNumberHeight);
        }];
        
        if (model.goods && [model.goods isKindOfClass:[NSArray class]]) {
            
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:model.goods];
            float tableViewHeight = model.goods.count * 81;
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
               
                make.left.offset(16);
                make.right.offset(-16);
                make.top.equalTo(self.numberingLabel.mas_bottom).offset(20);
                make.height.offset(tableViewHeight);
            }];
            [self.tableView reloadData];
        }
        
    }
}

@end
