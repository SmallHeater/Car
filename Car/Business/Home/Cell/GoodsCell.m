//
//  GoodsCell.m
//  Car
//
//  Created by xianjun wang on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell ()

//图片
@property (nonatomic,strong) UIImageView * iconImageView;
//商品名
@property (nonatomic,strong) UILabel * goodsNameLabel;
//价格label
@property (nonatomic,strong) UILabel * priceLabel;
//减按钮
@property (nonatomic,strong) UIButton * subtractBtn;
//数量
@property (nonatomic,strong) UILabel * countLabel;
//加按钮
@property (nonatomic,strong) UIButton * addBtn;
//存储标签label的数组
@property (nonatomic,strong) NSMutableArray<UILabel *> * labelArray;

@end

@implementation GoodsCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _iconImageView;
}

-(UILabel *)goodsNameLabel{
    
    if (!_goodsNameLabel) {
        
        _goodsNameLabel = [[UILabel alloc] init];
        _goodsNameLabel.font = BOLDFONT16;
        _goodsNameLabel.textColor = Color_333333;
    }
    return _goodsNameLabel;
}

-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = Color_FF4C4B;
    }
    return _priceLabel;
}

-(UIButton *)subtractBtn{
    
    if (!_subtractBtn) {
        
        _subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subtractBtn setImage:[UIImage imageNamed:@"jiyoujian"] forState:UIControlStateNormal];
    }
    return _subtractBtn;
}

-(UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = FONT14;
        _countLabel.textColor = Color_2E78FF;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"jiyoujia"] forState:UIControlStateNormal];
    }
    return _addBtn;
}

-(NSMutableArray<UILabel *> *)labelArray{
    
    if (!_labelArray) {
        
        _labelArray = [[UILabel alloc] init];
    }
    return _labelArray;
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
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(10);
        make.top.offset(0);
        make.width.offset(70);
        make.height.offset(93);
    }];
    
    [self addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.offset(-16);
        make.height.offset(18);
    }];
    
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(-7);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.addBtn.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.height.offset(20);
        make.width.offset(30);
    }];
    
    [self addSubview:self.subtractBtn];
    [self.subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.countLabel.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.height.offset(20);
        make.right.equalTo(self.subtractBtn.mas_left);
    }];
}

-(void)show:(OilGoodModel *)model{
    
    for (UILabel * label in self.labelArray) {
        
        [label removeFromSuperview];
    }
    
    if (model.images && [model.images isKindOfClass:[NSArray class]] && model.images.count > 0) {
     
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.images[0]]]];
    }
    else{
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
    self.goodsNameLabel.text = [NSString repleaseNilOrNull:model.goods_name];
    
    NSString * grade = [NSString repleaseNilOrNull:model.grade];
    NSString * viscosity = [NSString repleaseNilOrNull:model.viscosity];
    NSString * origin = [NSString repleaseNilOrNull:model.origin];
    NSString * pack = [NSString repleaseNilOrNull:model.pack];
    
    float labelX = 10;
    float labelHeight = 18;
    for (NSUInteger i = 0; i < 4; i++) {
        
        UILabel * label = [[UILabel alloc] init];
        [self.labelArray addObject:label];
        label.font = FONT9;
        label.backgroundColor = [UIColor colorWithRed:0/255.0 green:121/255.0 blue:255/255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        
        float labelWidth;
        if (i == 0) {
         
             label.text = grade;
        }
        else if (i == 1){
            
             label.text = viscosity;
        }
        else if (i == 2){
            
             label.text = origin;
        }
        else if (i == 3){
            
             label.text = pack;
        }
        labelWidth = [grade widthWithFont:FONT9 andHeight:labelHeight] + 6;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(labelX);
            make.top.offset(43);
            make.width.offset(labelWidth);
            make.height.offset(labelHeight);
        }];
        
        labelX += labelWidth + 3;
    }
}

@end
