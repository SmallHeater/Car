//
//  PaymentMethodCell.m
//  Car
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PaymentMethodCell.h"

@interface PaymentMethodCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * selectImageView;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation PaymentMethodCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UIImageView *)selectImageView{
    
    if (!_selectImageView) {
        
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixuanzhong"]];
    }
    return _selectImageView;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
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

#pragma mark  ----  系统函数

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
        self.selectImageView.image = [UIImage imageNamed:@"xuanzhong"];
    }
    else{
        
        self.selectImageView.image = [UIImage imageNamed:@"weixuanzhong"];
    }
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(12.5);
        make.width.height.offset(24);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(16);
        make.top.offset(0);
        make.bottom.offset(-1);
        make.width.offset(100);
    }];
    
    [self addSubview:self.selectImageView];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(15.5);
        make.right.offset(-16);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(NSString *)imageName titleStr:(NSString *)title{
    
    self.iconImageView.image = [UIImage imageNamed:[NSString repleaseNilOrNull:imageName]];
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
}

@end
