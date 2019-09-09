//
//  DriverInformationCell.m
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "DriverInformationCell.h"
#import "DrivingLicenseModel.h"
#import "SHDatePickView.h"

@interface DriverInformationCell ()<UITextFieldDelegate>

//标题
@property (nonatomic,strong) UILabel * titleLabel;
//联系人
@property (nonatomic,strong) UILabel * contactLabel;
@property (nonatomic,strong) UITextField * contactTF;
@property (nonatomic,strong) UILabel * firstLineLabel;
//手机号
@property (nonatomic,strong) UILabel * phoneNumberLabel;
@property (nonatomic,strong) UITextField * phoneNumberTF;
@property (nonatomic,strong) UILabel * secondLineLabel;
//保险期
@property (nonatomic,strong) UILabel * InsurancePeriodLabel;
@property (nonatomic,strong) UILabel * InsurancePeriodContentLabel;

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
        _contactLabel.textColor = Color_666666;
        _contactLabel.text = @"联系人";
    }
    return _contactLabel;
}

-(UITextField *)contactTF{
    
    if (!_contactTF) {
        
        _contactTF = [[UITextField alloc] init];
        _contactTF.delegate = self;
        _contactTF.font = FONT16;
        _contactTF.textColor = Color_333333;
        _contactTF.placeholder = @"请输入联系人";
    }
    return _contactTF;
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
        _phoneNumberLabel.textColor = Color_666666;
        _phoneNumberLabel.text = @"手机号";
    }
    return _phoneNumberLabel;
}

-(UITextField *)phoneNumberTF{
    
    if (!_phoneNumberTF) {
        
        _phoneNumberTF = [[UITextField alloc] init];
        _phoneNumberTF.delegate = self;
        _phoneNumberTF.font = FONT16;
        _phoneNumberTF.textColor = Color_333333;
        _phoneNumberTF.placeholder = @"请输入手机号";
        _phoneNumberTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneNumberTF;
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
        _InsurancePeriodLabel.textColor = Color_666666;
        _InsurancePeriodLabel.text = @"保险期";
    }
    return _InsurancePeriodLabel;
}

-(UILabel *)InsurancePeriodContentLabel{
    
    if (!_InsurancePeriodContentLabel) {
        
        _InsurancePeriodContentLabel = [[UILabel alloc] init];
        _InsurancePeriodContentLabel.font = FONT16;
        _InsurancePeriodContentLabel.textColor = Color_C7C7CD;
        _InsurancePeriodContentLabel.text = @"请选择保险到期时间";
        _InsurancePeriodContentLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(InsurancePeriodContentLabelClicked:)];
        [_InsurancePeriodContentLabel addGestureRecognizer:tap];
    }
    return _InsurancePeriodContentLabel;
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

#pragma mark  ----  UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.contactTF]) {
        
        //联系人
        if (self.contactsCallBack) {
            
            self.contactsCallBack(textField.text);
        }
    }
    else if ([textField isEqual:self.phoneNumberTF]){
        
        //手机号
        if (self.phoneNumberCallBack) {
            
            self.phoneNumberCallBack(textField.text);
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.contactTF];
    [self.contactTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contactLabel.mas_right).offset(26);
        make.top.equalTo(self.contactLabel.mas_top);
        make.right.offset(0);
        make.height.equalTo(self.contactLabel.mas_height);
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
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.phoneNumberTF];
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.phoneNumberLabel.mas_right).offset(26);
        make.top.equalTo(self.phoneNumberLabel.mas_top);
        make.right.offset(0);
        make.height.equalTo(self.phoneNumberLabel.mas_height);
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
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.InsurancePeriodContentLabel];
    [self.InsurancePeriodContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.InsurancePeriodLabel.mas_right).offset(26);
        make.top.equalTo(self.InsurancePeriodLabel.mas_top);
        make.right.offset(0);
        make.height.equalTo(self.InsurancePeriodLabel.mas_height);
    }];
}

-(void)showData:(NSDictionary *)dic{
    
    NSString * contact = dic[@"contact"];
    self.contactTF.text = contact;
    
    NSString * phoneNumber = dic[@"phoneNumber"];
    self.phoneNumberTF.text = phoneNumber;
    
    NSString * InsurancePeriod = dic[@"InsurancePeriod"];
    if (![NSString strIsEmpty:InsurancePeriod]) {
     
        self.InsurancePeriodContentLabel.text = InsurancePeriod;
        self.InsurancePeriodContentLabel.textColor = Color_333333;
    }
}

//数据展示
-(void)showDataWithModel:(DrivingLicenseModel *)model{
    
    self.contactTF.text = [NSString repleaseNilOrNull:model.owner];
}

//选择保险到期时间
-(void)InsurancePeriodContentLabelClicked:(UIGestureRecognizer *)ges{
    
    __weak typeof(self) weakSelf = self;
    [SHDatePickView showActionSheetDateWith:^(NSDate * _Nonnull date, NSString * _Nonnull dateStr) {
        
        weakSelf.InsurancePeriodContentLabel.text = dateStr;
        weakSelf.InsurancePeriodContentLabel.textColor = Color_333333;
        if (weakSelf.dataCallBack) {
            
            weakSelf.dataCallBack(dateStr);
        }
    }];
}

@end
