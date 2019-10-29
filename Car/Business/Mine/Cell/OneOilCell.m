//
//  OneOilCell.m
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "OneOilCell.h"

@interface OneOilCell ()

//商品名
@property (nonatomic,strong) UILabel * productNameLabel;
//规格
@property (nonatomic,strong) UILabel * specificationLabel;
//数量
@property (nonatomic,strong) UILabel * countsLabel;
//合计
@property (nonatomic,strong) UILabel * totalLabel;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation OneOilCell

#pragma mark  ----  懒加载

-(UILabel *)productNameLabel{
    
    if (!_productNameLabel) {
        
        _productNameLabel = [[UILabel alloc] init];
        _productNameLabel.font = FONT16;
        _productNameLabel.textColor = Color_333333;
    }
    return _productNameLabel;
}

-(UILabel *)specificationLabel{
    
    if (!_specificationLabel) {
        
        _specificationLabel = [[UILabel alloc] init];
        _specificationLabel.font = FONT13;
        _specificationLabel.textColor = Color_333333;
    }
    return _specificationLabel;
}

-(UILabel *)countsLabel{
    
    if (!_countsLabel) {
        
        _countsLabel = [[UILabel alloc] init];
        _countsLabel.font = FONT13;
        _countsLabel.textColor = Color_999999;
    }
    return _countsLabel;
}

-(UILabel *)totalLabel{
    
    if (!_totalLabel) {
        
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.font = FONT13;
        _totalLabel.textColor = Color_333333;
        _totalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_D8D8D8;
    }
    return _lineLabel;
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
    
    [self addSubview:self.productNameLabel];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.offset(12);
        make.right.offset(0);
        make.height.offset(21);
    }];
    
    [self addSubview:self.specificationLabel];
    [self addSubview:self.countsLabel];
    [self addSubview:self.totalLabel];
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(GoodsItem *)model{
    
    if (model) {
     
        self.productNameLabel.text = [NSString repleaseNilOrNull:model.goods_name];
        //价格
        NSString * priceStr = [[NSString alloc] initWithFormat:@"￥%.2f/箱",model.goods_price.floatValue];
        NSUInteger priceHeight = 16;
        float priceWidth = [priceStr widthWithFont:FONT13 andHeight:priceHeight];
        self.specificationLabel.text = priceStr;
        [self.specificationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(0);
            make.bottom.offset(-16);
            make.width.offset(priceWidth);
            make.height.offset(priceHeight);
        }];
        
        //数量
        NSString * countStr = [[NSString alloc] initWithFormat:@"数量：%ld",model.total_num];
        float countWidth = [countStr widthWithFont:FONT13 andHeight:priceHeight];
        self.countsLabel.text = countStr;
        [self.countsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.specificationLabel.mas_right).offset(30);
            make.bottom.equalTo(self.specificationLabel.mas_bottom);
            make.width.offset(countWidth);
            make.height.offset(priceHeight);
        }];
        
        //合计
        NSString * totalStr = [[NSString alloc] initWithFormat:@"合计：￥%.2f",model.total_price.floatValue];
        float totalWidth = [totalStr widthWithFont:FONT13 andHeight:priceHeight];
        self.totalLabel.text = totalStr;
        [self.totalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(0);
            make.bottom.equalTo(self.specificationLabel.mas_bottom);
            make.width.offset(totalWidth);
            make.height.offset(priceHeight);
        }];
    }
}

@end
