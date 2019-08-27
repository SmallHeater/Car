//
//  DriverInformationCell.m
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "DriverInformationCell.h"

@interface DriverInformationCell ()

//标题
@property (nonatomic,strong) UILabel * titleLabel;
//联系人
@property (nonatomic,strong) UILabel * contactLabel;
@property (nonatomic,strong) UILabel * firstLineLabel;
//手机号
@property (nonatomic,strong) UILabel * phoneNumberLabel;
@property (nonatomic,strong) UILabel * secondLineLabel;
//保险期
@property (nonatomic,strong) UILabel * InsurancePeriodLabel;

@end

@implementation DriverInformationCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = Color_F3F3F3;
        _titleLabel.text = @"  驾驶员信息";
        _titleLabel.font = FONT14;
        _titleLabel.textColor = Color_999999;
    }
    return _titleLabel;
}

-(UILabel *)contactLabel{
    
    if (!_contactLabel) {
        
        _contactLabel = [[UILabel alloc] init];
        _contactLabel.font = FONT16;
    }
    return _contactLabel;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)phoneNumberLabel{
    
    if (!_phoneNumberLabel) {
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = FONT16;
    }
    return _phoneNumberLabel;
}

-(UILabel *)secondLineLabel{
    
    if (!_secondLineLabel) {
        
        _secondLineLabel = [[UILabel alloc] init];
        _secondLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _secondLineLabel;
}

-(UILabel *)InsurancePeriodLabel{
    
    if (!_InsurancePeriodLabel) {
        
        _InsurancePeriodLabel = [[UILabel alloc] init];
        _InsurancePeriodLabel.font = FONT16;
    }
    return _InsurancePeriodLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.offset(0);
        make.height.offset(42);
    }];
    
    [self addSubview:self.contactLabel];
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.right.offset(0);
        make.height.offset(50);
    }];
    
    [self addSubview:self.firstLineLabel];
    [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.contactLabel.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.phoneNumberLabel];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.firstLineLabel.mas_bottom).offset(0);
        make.right.offset(0);
        make.height.offset(50);
    }];
    
    [self addSubview:self.secondLineLabel];
    [self.secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.phoneNumberLabel.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.InsurancePeriodLabel];
    [self.InsurancePeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.secondLineLabel.mas_bottom).offset(0);
        make.right.offset(0);
        make.height.offset(50);
    }];
}

-(void)showData:(NSDictionary *)dic{
    
    NSString * contact = dic[@"contact"];
    NSString * showContact = [[NSString alloc] initWithFormat:@"联系人   %@",contact];
    NSMutableAttributedString * showContactAttStr = [[NSMutableAttributedString alloc] initWithString:showContact];
    [showContactAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showContactAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, contact.length)];
    self.contactLabel.attributedText = showContactAttStr;
    
    NSString * phoneNumber = dic[@"phoneNumber"];
    NSString * showPhoneNumber = [[NSString alloc] initWithFormat:@"手机号   %@",phoneNumber];
    NSMutableAttributedString * showPhoneNumberAttStr = [[NSMutableAttributedString alloc] initWithString:showPhoneNumber];
    [showPhoneNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showPhoneNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, phoneNumber.length)];
    self.phoneNumberLabel.attributedText = showPhoneNumberAttStr;
    
    NSString * InsurancePeriod = dic[@"InsurancePeriod"];
    NSString * showInsurancePeriod = [[NSString alloc] initWithFormat:@"保险期   %@",InsurancePeriod];
    NSMutableAttributedString * showInsurancePeriodAttStr = [[NSMutableAttributedString alloc] initWithString:showInsurancePeriod];
    [showInsurancePeriodAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showInsurancePeriodAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, InsurancePeriod.length)];
    self.InsurancePeriodLabel.attributedText = showInsurancePeriodAttStr;
}

-(void)test{
    
    [self showData:@{@"contact":@"黄豆豆",@"phoneNumber":@"13214568756",@"InsurancePeriod":@"8月份"}];
}

@end
