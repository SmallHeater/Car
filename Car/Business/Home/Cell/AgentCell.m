//
//  AgentCell.m
//  Car
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AgentCell.h"

@interface AgentCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * nameImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView * phoneImageView;
@property (nonatomic,strong) UILabel * phoneLabel;
@property (nonatomic,strong) UIImageView * addressImageView;
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * lineLabel;
@property (nonatomic,strong) UILabel * twoLineLabel;
@property (nonatomic,strong) UIImageView * productFileImageView;
@property (nonatomic,strong) UILabel * productFileLabel;
//箭头
@property (nonatomic,strong) UIImageView * arrowImageView;
@property (nonatomic,strong) UILabel * bottomLine;

@end

@implementation AgentCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT14;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"代理商";
    }
    return _titleLabel;
}

-(UIImageView *)nameImageView{
    
    if (!_nameImageView) {
        
        _nameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dailishangming"]];
    }
    return _nameImageView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT12;
        _nameLabel.textColor = Color_333333;
    }
    return _nameLabel;
}

-(UIImageView *)phoneImageView{
    
    if (!_phoneImageView) {
        
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dianhuahui"]];
    }
    return _phoneImageView;
}

-(UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = FONT12;
        _phoneLabel.textColor = Color_333333;
    }
    return _phoneLabel;
}

-(UIImageView *)addressImageView{
    
    if (!_addressImageView) {
        
        _addressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dizhi"]];
    }
    return _addressImageView;
}

-(UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT12;
        _addressLabel.textColor = Color_333333;
    }
    return _addressLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
}

-(UILabel *)twoLineLabel{
    
    if (!_twoLineLabel) {
        
        _twoLineLabel = [[UILabel alloc] init];
        _twoLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _twoLineLabel;
}

-(UIImageView *)productFileImageView{
    
    if (!_productFileImageView) {
        
        _productFileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dangan"]];
    }
    return _productFileImageView;
}

-(UILabel *)productFileLabel{
    
    if (!_productFileLabel) {
        
        _productFileLabel = [[UILabel alloc] init];
        _productFileLabel.font = FONT12;
        _productFileLabel.textColor = Color_333333;
        _productFileLabel.text = @"查看产品档案";
    }
    return _productFileLabel;
}

-(UIImageView *)arrowImageView{
    
    if (!_arrowImageView) {
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youjiantou"]];
    }
    return _arrowImageView;
}

-(UILabel *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = Color_F5F5F5;
    }
    return _bottomLine;
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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(10);
        make.height.offset(20);
        make.right.offset(-16);
    }];
    
    [self addSubview:self.nameImageView];
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameImageView.mas_right).offset(10);
        make.top.equalTo(self.nameImageView.mas_top);
        make.right.offset(-16);
        make.height.equalTo(self.nameImageView.mas_height);
    }];
    
    [self addSubview:self.phoneImageView];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.nameImageView.mas_bottom).offset(10);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.phoneImageView.mas_right).offset(10);
        make.top.equalTo(self.phoneImageView.mas_top);
        make.right.offset(-16);
        make.height.equalTo(self.phoneImageView.mas_height);
    }];
    
    [self addSubview:self.addressImageView];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.phoneImageView.mas_bottom).offset(10);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.addressImageView.mas_right).offset(10);
        make.top.equalTo(self.addressImageView.mas_top);
        make.right.offset(-16);
        make.height.equalTo(self.addressImageView.mas_height);
    }];
 
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.offset(0);
        make.top.equalTo(self.addressImageView.mas_bottom).offset(10);
        make.height.offset(1);
    }];
    
    [self addSubview:self.twoLineLabel];
    [self.twoLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.offset(0);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(86);
        make.height.offset(1);
    }];
    
    [self addSubview:self.productFileImageView];
    [self.productFileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.twoLineLabel.mas_bottom).offset(10);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.productFileLabel];
    [self.productFileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productFileImageView.mas_right).offset(10);
        make.top.equalTo(self.productFileImageView.mas_top);
        make.right.offset(-40);
        make.height.equalTo(self.productFileImageView.mas_height);
    }];
    
    [self addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.twoLineLabel.mas_bottom).offset(10);
        make.right.offset(-16);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(8);
    }];
}

-(void)show:(ShopModel *)model{
    
    self.nameLabel.text = [NSString repleaseNilOrNull:model.name];
    self.phoneLabel.text = [NSString repleaseNilOrNull:model.phone];
    self.addressLabel.text = [NSString repleaseNilOrNull:model.address];
    
}

@end
