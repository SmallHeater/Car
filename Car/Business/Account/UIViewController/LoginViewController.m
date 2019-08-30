//
//  LoginViewController.m
//  Car
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "LoginViewController.h"
#import "ImageViewAndTextFieldAndBottomLineView.h"
#import "GetVerificationCodeBtn.h"
#import "HighOrderPositioningController.h"
#import "LogInRegisterModel.h"

@interface LoginViewController ()

//图标
@property (nonatomic,strong) UIImageView * appIconImageView;
//图标标题
@property (nonatomic,strong) UILabel * appIconLabel;
//请输入手机号view
@property (nonatomic,strong) ImageViewAndTextFieldAndBottomLineView * phoneView;
//请输入验证码view
@property (nonatomic,strong) ImageViewAndTextFieldAndBottomLineView * verificationCodeView;
//请输入验证码按钮
@property (nonatomic,strong) GetVerificationCodeBtn * verificationCodeBtn;
//补的分割线
@property (nonatomic,strong) UILabel * lineLabel;
//请输入修理厂名称view
@property (nonatomic,strong) ImageViewAndTextFieldAndBottomLineView * repairShopNameView;
//登录按钮
@property (nonatomic,strong) UIButton * loginBtn;
//登录注册模型
@property (nonatomic,strong) LogInRegisterModel * logInRegisterModel;
//发送的验证码
@property (nonatomic,strong) NSString * verificationCode;

@end

@implementation LoginViewController

#pragma mark  ----  懒加载

-(UIImageView *)appIconImageView{
    
    if (!_appIconImageView) {
        
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.backgroundColor = Color_B4B4B4;
        _appIconImageView.layer.cornerRadius = 8;
        _appIconImageView.layer.masksToBounds = YES;
    }
    return _appIconImageView;
}

-(UILabel *)appIconLabel{

    if (!_appIconLabel) {

        _appIconLabel = [[UILabel alloc] init];
        _appIconLabel.textAlignment = NSTextAlignmentCenter;
        _appIconLabel.font = BOLDFONT18;
        _appIconLabel.textColor = Color_333333;
        _appIconLabel.text = @"APP图标";
    }
    return _appIconLabel;
}

-(ImageViewAndTextFieldAndBottomLineView *)phoneView{
    
    if (!_phoneView) {
        
        _phoneView = [[ImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"phone",@"placeholder":@"请输入手机号"}];
        [_phoneView setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _phoneView;
}

-(ImageViewAndTextFieldAndBottomLineView *)verificationCodeView{
    
    if (!_verificationCodeView) {
        
        _verificationCodeView = [[ImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"verificationCode",@"placeholder":@"请输入验证码"}];
        [_verificationCodeView setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _verificationCodeView;
}

-(GetVerificationCodeBtn *)verificationCodeBtn{
    
    if (!_verificationCodeBtn) {
        
        _verificationCodeBtn = [[GetVerificationCodeBtn alloc] initWithConfigurationDic:@{@"normalTitle":@"获取验证码",@"time":[NSNumber numberWithInteger:60]}];
        [_verificationCodeBtn addTarget:self action:@selector(requestVerificationCode) forControlEvents:UIControlEventTouchUpInside];
//        _verificationCodeBtn.backgroundColor = [UIColor greenColor];
    }
    return _verificationCodeBtn;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
     
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
}

-(ImageViewAndTextFieldAndBottomLineView *)repairShopNameView{
    
    if (!_repairShopNameView) {
        
        _repairShopNameView = [[ImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"repairShop",@"placeholder":@"请输入修理厂名称"}];
    }
    return _repairShopNameView;
}

-(UIButton *)loginBtn{
    
    if (!_loginBtn) {
     
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = FONT18;
        [_loginBtn setBackgroundColor:Color_0272FF];
        _loginBtn.layer.cornerRadius = 2;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(LogInRegisterModel *)logInRegisterModel{
    
    if (!_logInRegisterModel) {
        
        _logInRegisterModel = [[LogInRegisterModel alloc] init];
    }
    return _logInRegisterModel;
}

#pragma mark  ----  生命周期函数

-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self addReceivingKeyboard];
    [self drawUI];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self startPositioning];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.appIconImageView];
    [self.appIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(65);
        make.top.offset([UIScreenControl navigationBarHeight] + 51);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.appIconLabel];
    [self.appIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.appIconImageView.mas_bottom).offset(12);
        make.height.offset(25);
    }];
    
    [self.view addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.appIconLabel.mas_bottom).offset(13);
        make.height.offset(53);
    }];
    
    [self.view addSubview:self.verificationCodeView];
    //考虑到倒计时状态下按钮文字显示完全，所以要给按钮留的空间大一点
    [self.verificationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-110);
        make.top.equalTo(self.phoneView.mas_bottom).offset(0);
        make.height.offset(53);
    }];
    
    [self.view addSubview:self.verificationCodeBtn];
    [self.verificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.verificationCodeView.mas_right);
        make.top.equalTo(self.verificationCodeView.mas_top);
        make.right.offset(-16);
        make.bottom.equalTo(self.verificationCodeView.mas_bottom).offset(-1);
    }];
    
    [self.view addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.verificationCodeView.mas_right);
        make.right.offset(-16);
        make.bottom.equalTo(self.verificationCodeView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self.view addSubview:self.repairShopNameView];
    [self.repairShopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.verificationCodeView.mas_bottom).offset(0);
        make.height.offset(53);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.repairShopNameView.mas_bottom).offset(26);
        make.height.offset(47);
    }];
}

//定位
-(void)startPositioning{
    
    HighOrderPositioningController * control = [HighOrderPositioningController sharedManager];
    
    __weak LoginViewController * weakSelf = self;
    control.callBack = ^(PositioningResultModel * _Nonnull result) {
      
        if (result.errorCode == 0) {
            
            //定位h成功
            weakSelf.logInRegisterModel.lat = [[NSString alloc] initWithFormat:@"%.6f",result.latitude];
            weakSelf.logInRegisterModel.lng = [[NSString alloc] initWithFormat:@"%.6f",result.longitude];
            weakSelf.logInRegisterModel.province = result.province;
            weakSelf.logInRegisterModel.city = result.city;
            weakSelf.logInRegisterModel.district = result.district;
        }
        else{
            
            //定位失败
        }
    };
    [control startPositioning];
}

//给view设置收键盘
-(void)addReceivingKeyboard{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [self.view addGestureRecognizer:tap];
}

//收键盘
-(void)tapClicked{
    
    [self.view endEditing:YES];
}

//获取验证码
-(void)requestVerificationCode{
    
    NSString * phoneNumber = [self.phoneView getInputText];
    if ([phoneNumber repleaseNilOrNull].length == 11) {
        
        __weak LoginViewController * weakSelf = self;
        [SHRoutingComponent openURL:GETNETWORKTYPE callBack:^(NSDictionary *resultDic) {
           
            NSNumber * SHNetworkStatusNumber = resultDic[@"SHNetworkStatus"];
            if (SHNetworkStatusNumber.intValue == 0) {
                
                //无网
            }
            else{
                
                //发起请求
                int num = (arc4random() % 10000);
                NSString * randomNumber = [NSString stringWithFormat:@"%.4d", num];
                NSDictionary * bodyParameters = @{@"mobile":phoneNumber,@"code":randomNumber,@"event":@"register"};
                NSDictionary * configurationDic = @{@"requestUrlStr":GetVerificationCode,@"bodyParameters":bodyParameters};
                [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
                    
                    if (![resultDic.allKeys containsObject:@"error"]) {
                        
                        //成功的
                        NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                        if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                            
                            weakSelf.verificationCode = randomNumber;
                        }
                        else{
                            
                        }
                    }
                    else{
                        
                        //失败的
                    }
                }];
            }
        }];
    }
    else{
        
        NSString * str = @"请输入正确的手机号";
    }
}

//登录按钮的响应
-(void)loginBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    if ([self.verificationCode isEqualToString:[self.verificationCodeView getInputText]]) {
        
        self.logInRegisterModel.phone = [self.phoneView getInputText];
        self.logInRegisterModel.shop_name = [self.repairShopNameView getInputText];
        
        __weak LoginViewController * weakSelf = self;
        [SHRoutingComponent openURL:GETNETWORKTYPE callBack:^(NSDictionary *resultDic) {
            
            NSNumber * SHNetworkStatusNumber = resultDic[@"SHNetworkStatus"];
            if (SHNetworkStatusNumber.intValue == 0) {
                
                //无网
            }
            else{
                
                //发起请求
                NSDictionary * bodyParameters = self.logInRegisterModel;
                NSDictionary * configurationDic = @{@"requestUrlStr":Register,@"bodyParameters":bodyParameters};
                [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
                    
                    if (![resultDic.allKeys containsObject:@"error"]) {
                        
                        //成功的
                        NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                        if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                            
                            
                        }
                        else{
                            
                        }
                    }
                    else{
                        
                        //失败的
                    }
                }];
            }
        }];

    }
    else{
        
        //验证码错误
    }
}

@end
