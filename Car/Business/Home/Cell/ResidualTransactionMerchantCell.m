//
//  ResidualTransactionMerchantCell.m
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionMerchantCell.h"

@interface ResidualTransactionMerchantCell ()

@property (nonatomic,strong) UIImageView * photoImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * numberLabel;
//信用
@property (nonatomic,strong) UILabel * creditLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation ResidualTransactionMerchantCell

#pragma mark  ----  懒加载

-(UIImageView *)photoImageView{
    
    if (!_photoImageView) {
        
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.layer.maskedCorners = 35;
    }
    return _photoImageView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT14;
        _nameLabel.textColor = Color_333333;
    }
    return _nameLabel;
}

-(UILabel *)numberLabel{
    
    if (!_numberLabel) {
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = Color_333333;
        _numberLabel.font = FONT12;
    }
    return _numberLabel;
}

-(UILabel *)creditLabel{
    
    if (!_creditLabel) {
        
        _creditLabel = [[UILabel alloc] init];
        _creditLabel.textColor = Color_333333;
        _creditLabel.font = FONT12;
    }
    return _creditLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomLineLabel;
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
    
    [self addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(15);
        make.width.height.offset(70);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.photoImageView.mas_right).offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.photoImageView.mas_top);
        make.height.offset(23);
    }];
    
    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(1);
        make.right.offset(-15);
        make.height.offset(23);
    }];
    
    [self addSubview:self.creditLabel];
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.numberLabel.mas_bottom);
        make.right.offset(-15);
        make.height.offset(23);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(8);
    }];
}

-(void)test{
    
    self.photoImageView.backgroundColor = [UIColor grayColor];
    self.nameLabel.backgroundColor = [UIColor greenColor];
    self.numberLabel.backgroundColor = [UIColor redColor];
    self.creditLabel.backgroundColor = [UIColor greenColor];
}

@end
