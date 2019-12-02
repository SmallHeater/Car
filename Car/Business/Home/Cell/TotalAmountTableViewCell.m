//
//  TotalAmountTableViewCell.m
//  Car
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "TotalAmountTableViewCell.h"

@interface TotalAmountTableViewCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation TotalAmountTableViewCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT12;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT12;
        _contentLabel.textColor = Color_333333;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
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

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.width.offset(80);
        make.top.bottom.offset(0);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.bottom.offset(0);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)showTitle:(NSString *)title andContent:(NSString *)content{
    
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
    self.contentLabel.text = [NSString repleaseNilOrNull:content];
}

-(void)refreshTitleFont:(UIFont *)font{

    self.titleLabel.font = font;
}

-(void)refreshContentFont:(UIFont *)font{
    
    self.contentLabel.font = font;
}

-(void)refreshContentColor:(UIColor *)color{
    
    self.contentLabel.textColor = color;
}

@end
