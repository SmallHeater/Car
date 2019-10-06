//
//  PostJobInputCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobInputCell.h"

@interface PostJobInputCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField * inputTF;
@property (nonatomic,strong) NSString * name;

@end

@implementation PostJobInputCell

#pragma mark  ----  懒加载

-(UITextField *)inputTF{
    
    if (!_inputTF) {
        
        _inputTF = [[UITextField alloc] init];
        _inputTF.delegate = self;
        _inputTF.font = FONT16;
    }
    return _inputTF;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andShowBottomLine:(BOOL)isShow{
    
    self = [super initWithReuseIdentifier:reuseIdentifier andTitle:title andShowBottomLine:isShow];
    if (self) {
        
        [self drawUI];
        self.inputTF.placeholder = [NSString repleaseNilOrNull:placeholder];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.inputTF];
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(104);
        make.top.offset(0);
        make.bottom.offset(-1);
        make.right.offset(-15);
    }];
}

//修改输入框键盘
-(void)refrshTFKeyboard:(UIKeyboardType)keyboardType{
    
    self.inputTF.keyboardType = keyboardType;
}

@end
