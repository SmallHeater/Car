//
//  PostJobMonthlySalaryCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostResidualTransactionAmountCell.h"
#import "SHImageAndTitleBtn.h"


@interface PostResidualTransactionAmountCell ()<UITextFieldDelegate>

//金额输入框
@property (nonatomic,strong) UITextField * amountTF;
//元
@property (nonatomic,strong) UILabel * yuanLabel;
//面议 按钮
@property (nonatomic,strong) SHImageAndTitleBtn * negotiableBtn;
//金额
@property (nonatomic,assign) NSUInteger amount;
//是否面议
@property (nonatomic,assign) BOOL isNegotiable;

@end

@implementation PostResidualTransactionAmountCell

#pragma mark  ----  懒加载

-(UITextField *)amountTF{
    
    if (!_amountTF) {
        
        _amountTF = [[UITextField alloc] init];
        _amountTF.delegate = self;
        _amountTF.backgroundColor = Color_F5F5F5;
        _amountTF.font = FONT16;
        _amountTF.layer.masksToBounds = YES;
        _amountTF.layer.cornerRadius = 3;
        _amountTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _amountTF;
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
    
    self.amount = textField.text.integerValue;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.amountTF];
    [self.amountTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(104);
        make.top.offset(15);
        make.width.offset(90);
        make.height.offset(22);
    }];
    
    [self addSubview:self.yuanLabel];
    [self.yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.amountTF.mas_right).offset(14);
        make.top.bottom.offset(0);
        make.width.offset(16);
    }];
    
    [self addSubview:self.negotiableBtn];
}

@end
