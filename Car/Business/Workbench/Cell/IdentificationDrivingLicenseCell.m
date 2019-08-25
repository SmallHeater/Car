//
//  IdentificationDrivingLicenseCell.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "IdentificationDrivingLicenseCell.h"

@interface IdentificationDrivingLicenseCell ()

@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UIImageView * phoneImageView;
@property (nonatomic,strong) UILabel * titleLabel;

@end

@implementation IdentificationDrivingLicenseCell

#pragma mark  ----  懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chengsebeijing"]];
    }
    return _bgImageView;
}

-(UIImageView *)phoneImageView{
    
    if (!_phoneImageView) {
        
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiangjibaise"]];
    }
    return _phoneImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT15;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"拍行驶证自动识别";
    }
    return _titleLabel;
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
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(11);
        make.right.offset(-11);
        make.top.offset(26);
        make.height.offset(61);
    }];
    
    [self.bgImageView addSubview:self.phoneImageView];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(94);
        make.top.offset(14);
        make.width.offset(25);
        make.height.offset(22);
    }];
    
    [self.bgImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.phoneImageView.mas_right).offset(21);
        make.top.offset(18);
        make.width.offset(130);
        make.height.offset(15);
    }];
}

@end
