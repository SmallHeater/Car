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

@end

@implementation GoodsCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
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
       
        make.left.top.offset(10);
        make.width.offset(70);
        make.height.offset(93);
    }];
    
    [self addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(0);
        make.top.offset(0);
        make.right.offset(-16);
        make.height.offset(18);
    }];
    
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(0);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.addBtn.mas_left);
        make.bottom.offset(0);
        make.height.offset(20);
        make.width.offset(30);
    }];
    
    
    
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_left);
        make.bottom.offset(0);
        make.height.offset(20);
    }];
}

@end
