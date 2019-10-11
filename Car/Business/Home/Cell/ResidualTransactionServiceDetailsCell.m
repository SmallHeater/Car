//
//  ResidualTransactionServiceDetailsCell.m
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionServiceDetailsCell.h"

@interface ResidualTransactionServiceDetailsCell ()

@property (nonatomic,strong) UILabel * topGrayLabel;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * bottomGrayLabel;

@end

@implementation ResidualTransactionServiceDetailsCell

#pragma mark  ----  懒加载

-(UILabel *)topGrayLabel{
    
    if (!_topGrayLabel) {
        
        _topGrayLabel = [[UILabel alloc] init];
        _topGrayLabel.backgroundColor = Color_F5F5F5;
    }
    return _topGrayLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT18;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"服务详情";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = Color_333333;
        _contentLabel.font = FONT14;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)bottomGrayLabel{
    
    if (!_bottomGrayLabel) {
        
        _bottomGrayLabel = [[UILabel alloc] init];
        _bottomGrayLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomGrayLabel;
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

+(float)cellHeightWithStr:(NSString *)str{
    
    return 186;
}

-(void)drawUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topGrayLabel];
    [self.topGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(8);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.equalTo(self.topGrayLabel.mas_bottom).offset(15);
        make.width.offset(100);
        make.height.offset(25);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.bottom.offset(-23);
    }];
    
    [self addSubview:self.bottomGrayLabel];
    [self.bottomGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(8);
    }];
}

-(void)show:(NSString *)str{
    
    self.contentLabel.text = [NSString repleaseNilOrNull:str];
}

@end
