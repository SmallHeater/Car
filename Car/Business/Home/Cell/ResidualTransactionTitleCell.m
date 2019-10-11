//
//  ResidualTransactionTitleCell.m
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionTitleCell.h"

@interface ResidualTransactionTitleCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UIImageView * callImageView;
//商家
@property (nonatomic,strong) UIImageView * MerchantImageView;

@end

@implementation ResidualTransactionTitleCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT14;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = FONT16;
        _priceLabel.textColor = Color_FF4C4B;
    }
    return _priceLabel;
}

-(UIImageView *)callImageView{
    
    if (!_callImageView) {
        
        _callImageView = [[UIImageView alloc] init];
        _callImageView.image = [UIImage imageNamed:@"lijiboda"];
        _callImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callImageViewTaped)];
        [_callImageView addGestureRecognizer:tap];
    }
    return _callImageView;
}

-(UIImageView *)MerchantImageView{
    
    if (!_MerchantImageView) {
        
        _MerchantImageView = [[UIImageView alloc] init];
        _MerchantImageView.image = [UIImage imageNamed:@"shangjia"];
    }
    return _MerchantImageView;
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
 
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(15);
        make.right.offset(-16);
        make.height.offset(20);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.offset(50);
        make.height.offset(23);
    }];
    
    [self addSubview:self.callImageView];
    [self.callImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.priceLabel.mas_right).offset(15);
        make.top.equalTo(self.priceLabel.mas_top);
        make.width.offset(53);
        make.height.offset(21);
    }];
    
    [self addSubview:self.MerchantImageView];
    [self.MerchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(-12);
        make.width.offset(30);
        make.height.offset(20);
    }];
}

-(void)showTitle:(NSString *)title price:(NSString *)price{
    
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
    NSString * money;
    if ([price isEqualToString:@"面议"]) {
        
        money = price;
    }
    else{
        
        money = [[NSString alloc] initWithFormat:@"￥%@",price];
    }
    self.priceLabel.text = [NSString repleaseNilOrNull:money];
}

-(void)callImageViewTaped{
    
}

@end
