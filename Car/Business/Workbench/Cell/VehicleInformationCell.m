//
//  VehicleInformationCell.m
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleInformationCell.h"


@interface VehicleInformationCell ()<UITextFieldDelegate>

//标题
@property (nonatomic,strong) UILabel * titleLabel;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
@property (nonatomic,strong) UITextField * numberPlateTF;
@property (nonatomic,strong) UILabel * firstLineLabel;
//车架号
@property (nonatomic,strong) UILabel * frameNumberLabel;
@property (nonatomic,strong) UITextField * frameNumberTF;
@property (nonatomic,strong) UILabel * secondLineLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
@property (nonatomic,strong) UITextField * carModelTF;
@property (nonatomic,strong) UILabel * thirdLineLabel;
//发动机号
@property (nonatomic,strong) UILabel * engineNumberLabel;
@property (nonatomic,strong) UITextField * engineNumberTF;

@end

@implementation VehicleInformationCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = Color_F3F3F3;
        _titleLabel.text = @"  车辆信息";
        _titleLabel.font = FONT14;
        _titleLabel.textColor = Color_999999;
    }
    return _titleLabel;
}

-(UILabel *)numberPlateLabel{
    
    if (!_numberPlateLabel) {
        
        _numberPlateLabel = [[UILabel alloc] init];
        _numberPlateLabel.font = FONT16;
        _numberPlateLabel.textColor = Color_666666;
        _numberPlateLabel.text = @"车牌号";
//        _numberPlateLabel.backgroundColor = [UIColor yellowColor];
    }
    return _numberPlateLabel;
}

-(UITextField *)numberPlateTF{
    
    if (!_numberPlateTF) {
        
        _numberPlateTF = [[UITextField alloc] init];
        _numberPlateTF.font = FONT16;
        _numberPlateTF.textColor = Color_333333;
        _numberPlateTF.placeholder = @"请输入车牌号";
        _numberPlateTF.delegate = self;
    }
    return _numberPlateTF;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)frameNumberLabel{
    
    if (!_frameNumberLabel) {
        
        _frameNumberLabel = [[UILabel alloc] init];
        _frameNumberLabel.font = FONT16;
        _frameNumberLabel.textColor = Color_666666;
        _frameNumberLabel.text = @"车架号";
//        _frameNumberLabel.backgroundColor = [UIColor yellowColor];
    }
    return _frameNumberLabel;
}

-(UITextField *)frameNumberTF{
    
    if (!_frameNumberTF) {
        
        _frameNumberTF = [[UITextField alloc] init];
        _frameNumberTF.delegate = self;
        _frameNumberTF.font = FONT16;
        _frameNumberTF.textColor = Color_333333;
        _frameNumberTF.placeholder = @"请输入车架号";
    }
    return _frameNumberTF;
}

-(UILabel *)secondLineLabel{
    
    if (!_secondLineLabel) {
        
        _secondLineLabel = [[UILabel alloc] init];
        _secondLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _secondLineLabel;
}

-(UILabel *)carModelLabel{
    
    if (!_carModelLabel) {
        
        _carModelLabel = [[UILabel alloc] init];
        _carModelLabel.font = FONT16;
        _carModelLabel.textColor = Color_666666;
        _carModelLabel.text = @"车型号";
//        _carModelLabel.backgroundColor = [UIColor yellowColor];
    }
    return _carModelLabel;
}

-(UITextField *)carModelTF{
    
    if (!_carModelTF) {
        
        _carModelTF = [[UITextField alloc] init];
        _carModelTF.delegate = self;
        _carModelTF.font = FONT16;
        _carModelTF.textColor = Color_333333;
        _carModelTF.placeholder = @"请输入车型号";
    }
    return _carModelTF;
}

-(UILabel *)thirdLineLabel{
    
    if (!_thirdLineLabel) {
        
        _thirdLineLabel = [[UILabel alloc] init];
        _thirdLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _thirdLineLabel;
}

-(UILabel *)engineNumberLabel{
    
    if (!_engineNumberLabel) {
        
        _engineNumberLabel = [[UILabel alloc] init];
        _engineNumberLabel.font = FONT16;
        _engineNumberLabel.textColor = Color_666666;
        _engineNumberLabel.text = @"发动机号";
//        _engineNumberLabel.backgroundColor = [UIColor yellowColor];
    }
    return _engineNumberLabel;
}

-(UITextField *)engineNumberTF{
    
    if (!_engineNumberTF) {
        
        _engineNumberTF = [[UITextField alloc] init];
        _engineNumberTF.delegate = self;
        _engineNumberTF.font = FONT16;
        _engineNumberTF.textColor = Color_333333;
        _engineNumberTF.placeholder = @"请输入发动机号";
    }
    return _engineNumberTF;
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
    
    if ([textField isEqual:self.numberPlateTF]) {
        
        //车牌号
        
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
    
    [self addSubview:self.numberPlateLabel];
    [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.numberPlateTF];
    [self.numberPlateTF mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.numberPlateLabel.mas_right).offset(25);
        make.right.offset(0);
        make.top.equalTo(self.numberPlateLabel.mas_top);
        make.height.offset(50);
    }];
    
    [self addSubview:self.firstLineLabel];
    [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.frameNumberLabel];
    [self.frameNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(33);
        make.top.equalTo(self.firstLineLabel.mas_bottom).offset(0);
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.frameNumberTF];
    [self.frameNumberTF mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.frameNumberLabel.mas_right).offset(25);
        make.right.offset(0);
        make.top.equalTo(self.frameNumberLabel.mas_top);
        make.height.offset(50);
    }];
    
    [self addSubview:self.secondLineLabel];
    [self.secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.frameNumberLabel.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.carModelLabel];
    [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.secondLineLabel.mas_bottom).offset(0);
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    [self addSubview:self.carModelTF];
    [self.carModelTF mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.carModelLabel.mas_right).offset(25);
        make.right.offset(0);
        make.top.equalTo(self.carModelLabel.mas_top);
        make.height.offset(50);
    }];
    
    [self addSubview:self.thirdLineLabel];
    [self.thirdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.carModelLabel.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.engineNumberLabel];
    [self.engineNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.equalTo(self.thirdLineLabel.mas_bottom).offset(0);
        make.width.offset(68);
        make.height.offset(50);
    }];
    
    [self addSubview:self.engineNumberTF];
    [self.engineNumberTF mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.engineNumberLabel.mas_right).offset(25);
        make.right.offset(0);
        make.top.equalTo(self.engineNumberLabel.mas_top);
        make.height.offset(50);
    }];
}

//数据展示:numberPlateNumber,号牌号码;vehicleIdentificationNumber,车辆识别代号;brandModelNumber,品牌型号;engineNumber,发动机号码;
-(void)showDataWithDic:(NSDictionary *)dic{
    
    self.numberPlateTF.text = dic[@"numberPlateNumber"];
    self.frameNumberTF.text = dic[@"vehicleIdentificationNumber"];
    self.carModelTF.text = dic[@"brandModelNumber"];
    self.engineNumberTF.text = dic[@"engineNumber"];
}

-(void)test{
    
   
}

@end
