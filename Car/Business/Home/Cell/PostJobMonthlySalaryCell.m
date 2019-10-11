//
//  PostJobMonthlySalaryCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobMonthlySalaryCell.h"
#import "SHImageAndTitleBtn.h"


@interface PostJobMonthlySalaryCell ()<UITextFieldDelegate>

//最低工资输入框
@property (nonatomic,strong) UITextField * minimumWageTF;
@property (nonatomic,strong) UILabel * lineLabel;
//最高工资输入框
@property (nonatomic,strong) UITextField * maximumWageTF;
//元
@property (nonatomic,strong) UILabel * yuanLabel;
//面议 按钮
@property (nonatomic,strong) SHImageAndTitleBtn * negotiableBtn;

//最低工资
@property (nonatomic,assign) NSUInteger minimumWage;
//最高工资
@property (nonatomic,assign) NSUInteger maximumWage;
//是否面议
@property (nonatomic,assign) BOOL isNegotiable;


@end

@implementation PostJobMonthlySalaryCell

#pragma mark  ----  懒加载

-(UITextField *)minimumWageTF{
    
    if (!_minimumWageTF) {
        
        _minimumWageTF = [[UITextField alloc] init];
        _minimumWageTF.delegate = self;
        _minimumWageTF.backgroundColor = Color_F5F5F5;
        _minimumWageTF.font = FONT16;
        _minimumWageTF.layer.masksToBounds = YES;
        _minimumWageTF.layer.cornerRadius = 3;
        _minimumWageTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _minimumWageTF;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DDDDDD;
        _lineLabel.layer.masksToBounds = YES;
        _lineLabel.layer.cornerRadius = 2;
    }
    return _lineLabel;
}

-(UITextField *)maximumWageTF{
    
    if (!_maximumWageTF) {
        
        _maximumWageTF = [[UITextField alloc] init];
        _maximumWageTF.delegate = self;
        _maximumWageTF.backgroundColor = Color_F5F5F5;
        _maximumWageTF.font = FONT16;
        _maximumWageTF.layer.masksToBounds = YES;
        _maximumWageTF.layer.cornerRadius = 3;
        _maximumWageTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _maximumWageTF;
}

-(UILabel *)yuanLabel{
    
    if (!_yuanLabel) {
        
        _yuanLabel = [[UILabel alloc] init];
        _yuanLabel.font = FONT16;
        _yuanLabel.textColor = Color_333333;
        _yuanLabel.text = @"元";
    }
    return _yuanLabel;
}

-(SHImageAndTitleBtn *)negotiableBtn{
    
    if (!_negotiableBtn) {
        
        _negotiableBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 50 - 18, 18, 50, 14) andImageFrame:CGRectMake(0, 1, 12, 12) andTitleFrame:CGRectMake(19, 0, 31, 14) andImageName:@"xuanze" andSelectedImageName:@"xuanzhonglanse" andTitle:@"面议"];
        __weak typeof(self) weakSelf = self;
        [[_negotiableBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            x.selected = !x.selected;
            weakSelf.isNegotiable = x.selected;
        }];
    }
    return _negotiableBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andShowBottomLine:(BOOL)isShow{
    
    self = [super initWithReuseIdentifier:reuseIdentifier andTitle:title andShowBottomLine:isShow];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.minimumWageTF]) {
        
        self.minimumWage = textField.text.integerValue;
    }
    else if ([textField isEqual:self.maximumWageTF]){
        
        self.maximumWage = textField.text.integerValue;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.minimumWageTF];
    [self.minimumWageTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(104);
        make.top.offset(15);
        make.width.offset(42);
        make.height.offset(22);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.minimumWageTF.mas_right).offset(16);
        make.top.offset(23);
        make.width.offset(11);
        make.height.offset(3);
    }];
    
    [self addSubview:self.maximumWageTF];
    [self.maximumWageTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.lineLabel.mas_right).offset(16);
        make.top.equalTo(self.minimumWageTF.mas_top);
        make.width.equalTo(self.minimumWageTF.mas_width);
        make.height.equalTo(self.minimumWageTF.mas_height);
    }];
    
    [self addSubview:self.yuanLabel];
    [self.yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.maximumWageTF.mas_right).offset(14);
        make.top.bottom.offset(0);
        make.width.offset(16);
    }];
    
    [self addSubview:self.negotiableBtn];
}

@end
