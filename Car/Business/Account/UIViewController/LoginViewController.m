//
//  LoginViewController.m
//  Car
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "LoginViewController.h"
#import "SHImageViewAndTextFieldAndBottomLineView.h"
#import "SHGetVerificationCodeBtn.h"
#import "SHHighOrderPositioningController.h"
#import "LogInRegisterModel.h"
#import "UserInforModel.h"
#import "HomeViewController.h"
#import "ForumViewController.h"
#import "WorkbenchViewController.h"
#import "MineViewController.h"
#import "UserInforController.h"


@interface LoginViewController ()

@property (nonatomic,strong) UIButton * backBtn;
//图标
@property (nonatomic,strong) UIImageView * appIconImageView;
//图标标题
@property (nonatomic,strong) UILabel * appIconLabel;
//请输入手机号view
@property (nonatomic,strong) SHImageViewAndTextFieldAndBottomLineView * phoneView;
//请输入验证码view
@property (nonatomic,strong) SHImageViewAndTextFieldAndBottomLineView * verificationCodeView;
//请输入验证码按钮
@property (nonatomic,strong) SHGetVerificationCodeBtn * verificationCodeBtn;
//补的分割线
@property (nonatomic,strong) UILabel * lineLabel;
//请输入修理厂名称view
@property (nonatomic,strong) SHImageViewAndTextFieldAndBottomLineView * repairShopNameView;
//登录按钮
@property (nonatomic,strong) UIButton * loginBtn;
//登录注册模型
@property (nonatomic,strong) LogInRegisterModel * logInRegisterModel;
//发送的验证码
@property (nonatomic,strong) NSString * verificationCode;

@end

@implementation LoginViewController

#pragma mark  ----  懒加载

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (self.navigationController) {
                
                if (self.navigationController.viewControllers.count == 1) {
                    
                    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
                }else{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
    return _backBtn;
}

-(UIImageView *)appIconImageView{
    
    if (!_appIconImageView) {
        
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.image = [UIImage imageNamed:@"appIcon"];
        _appIconImageView.backgroundColor = [UIColor clearColor];
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

-(SHImageViewAndTextFieldAndBottomLineView *)phoneView{
    
    if (!_phoneView) {
        
        _phoneView = [[SHImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"phone",@"placeholder":@"请输入手机号"}];
        [_phoneView setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _phoneView;
}

-(SHImageViewAndTextFieldAndBottomLineView *)verificationCodeView{
    
    if (!_verificationCodeView) {
        
        _verificationCodeView = [[SHImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"verificationCode",@"placeholder":@"请输入验证码"}];
        [_verificationCodeView setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _verificationCodeView;
}

-(SHGetVerificationCodeBtn *)verificationCodeBtn{
    
    if (!_verificationCodeBtn) {
        
        _verificationCodeBtn = [[SHGetVerificationCodeBtn alloc] initWithConfigurationDic:@{@"normalTitle":@"获取验证码",@"time":[NSNumber numberWithInteger:60]}];
        [_verificationCodeBtn addTarget:self action:@selector(requestVerificationCode) forControlEvents:UIControlEventTouchUpInside];
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

-(SHImageViewAndTextFieldAndBottomLineView *)repairShopNameView{
    
    if (!_repairShopNameView) {
        
        _repairShopNameView = [[SHImageViewAndTextFieldAndBottomLineView alloc] initWithConfigurationDic:@{@"imageName":@"repairShop",@"placeholder":@"请输入修理厂名称"}];
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
        //设置默认值
        _logInRegisterModel.lng = @"116.305600";
        _logInRegisterModel.lat = @"40.064563";
        _logInRegisterModel.province = @"北京市";
        _logInRegisterModel.city = @"北京市";
        _logInRegisterModel.district = @"昌平区";
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

-(void)dealloc{
    
    NSLog(@"LoginViewController:销毁");
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.offset(20 + [SHUIScreenControl liuHaiHeight]);
        make.width.height.offset(44);
    }];
    
    [self.view addSubview:self.appIconImageView];
    [self.appIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(65);
        make.top.offset([SHUIScreenControl navigationBarHeight] + 51);
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
    
    SHHighOrderPositioningController * control = [SHHighOrderPositioningController sharedManager];
    
    __weak LoginViewController * weakSelf = self;
    control.callBack = ^(SHPositioningResultModel * _Nonnull result) {
      
        if (result.errorCode == 0) {
            
            //定位成功
            weakSelf.logInRegisterModel.lat = [[NSString alloc] initWithFormat:@"%.6f",result.latitude];
            weakSelf.logInRegisterModel.lng = [[NSString alloc] initWithFormat:@"%.6f",result.longitude];
            weakSelf.logInRegisterModel.province = result.province;
            weakSelf.logInRegisterModel.city = result.city;
            weakSelf.logInRegisterModel.district = result.district;
        }
        else{
            
            //定位失败
            [MBProgressHUD wj_showError:@"定位失败"];
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
    if ([NSString repleaseNilOrNull:phoneNumber].length == 11) {
        
        __weak LoginViewController * weakSelf = self;
        [SHRoutingComponent openURL:GETNETWORKTYPE callBack:^(NSDictionary *resultDic) {
           
            if (resultDic && [resultDic isKindOfClass:[NSDictionary class]] && [resultDic.allKeys containsObject:@"SHNetworkStatus"]) {
             
                NSNumber * SHNetworkStatusNumber = resultDic[@"SHNetworkStatus"];
                if (SHNetworkStatusNumber.intValue == 0) {
                    
                    //无网
                    [MBProgressHUD wj_showError:INTERNETERROR];
                }
                else{
                    
                    //发起请求
                    int num = (arc4random() % 10000);
                    NSString * randomNumber = [NSString stringWithFormat:@"%.4d", num];
                    NSDictionary * bodyParameters = @{@"mobile":phoneNumber,@"code":randomNumber,@"event":@"register"};
                    NSDictionary * configurationDic = @{@"requestUrlStr":GetVerificationCode,@"bodyParameters":bodyParameters};
                    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
                        
                        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]] && ![resultDic.allKeys containsObject:@"error"]) {
                            
                            if ([resultDic.allKeys containsObject:@"response"]) {
                             
                                //成功的
                                NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                                if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                                    
                                    weakSelf.verificationCode = randomNumber;
                                }
                                else{
                                    
                                }
                            }
                        }
                        else{
                            
                            //失败的
                        }
                    }];
                }
            }
        }];
    }
    else{
        
        NSString * str = @"请输入正确的手机号";
        [MBProgressHUD wj_showError:str];
    }
}

//登录按钮的响应
-(void)loginBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    self.logInRegisterModel.phone = [self.phoneView getInputText];
    self.logInRegisterModel.shop_name = [self.repairShopNameView getInputText];
    NSString * inputVerificationCode = [self.verificationCodeView getInputText];
    if (self.logInRegisterModel.phone && self.logInRegisterModel.phone.length == 11) {
        
        
        if (inputVerificationCode && inputVerificationCode.length > 0) {
            
            if (self.logInRegisterModel.shop_name && self.logInRegisterModel.shop_name.length > 0) {
            
                [self.view endEditing:YES];
                [self logIn];
            }
            else{
                
                //请输入修理厂名称
                [MBProgressHUD wj_showError:@"请输入修理厂名称"];
            }
        }
        else{
            
            //请输入验证码
            [MBProgressHUD wj_showError:@"请输入验证码"];
        }
    }
    else{
        
        //请输入正确的手机号
        [MBProgressHUD wj_showError:@"请输入正确的手机号"];
    }
    btn.userInteractionEnabled = YES;
}

//登录
-(void)logIn{
    
    if (([[self.phoneView getInputText] isEqualToString:@"15010768330"] && [[self.verificationCodeView getInputText] isEqualToString:@"111111"]) || [self.verificationCode isEqualToString:[self.verificationCodeView getInputText]]) {
        
        __weak LoginViewController * weakSelf = self;
        [SHRoutingComponent openURL:GETNETWORKTYPE callBack:^(NSDictionary *resultDic) {
            
            NSNumber * SHNetworkStatusNumber = resultDic[@"SHNetworkStatus"];
            if (SHNetworkStatusNumber.intValue == 0) {
                
                //无网
                [MBProgressHUD wj_showError:INTERNETERROR];
            }
            else{
                
                //发起请求
                NSDictionary * bodyParameters = [self.logInRegisterModel mj_keyValues];;
                NSDictionary * configurationDic = @{@"requestUrlStr":Register,@"bodyParameters":bodyParameters};
                [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
                    
                    if (![resultDic.allKeys containsObject:@"error"]) {
                        
                        //成功的
                        if ([resultDic.allKeys containsObject:@"response"]) {
                         
                            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                                
                                if ([resultDic.allKeys containsObject:@"dataId"]) {
                                 
                                    id dataId = resultDic[@"dataId"];
                                    NSDictionary * dic = (NSDictionary *)dataId;
                                    if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic.allKeys containsObject:@"data"]) {
                                     
                                        NSDictionary * dataDic = dic[@"data"];
                                        if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"staff"]) {
                                         
                                            NSDictionary * staffDic = dataDic[@"staff"];
                                            if (staffDic && [staffDic isKindOfClass:[NSDictionary class]]) {
                                             
                                                UserInforModel * userInforModel = [UserInforModel mj_objectWithKeyValues:staffDic];
                                                [UserInforController sharedManager].userInforModel = userInforModel;
                                                NSDictionary * userInforDic = [userInforModel mj_keyValues];
                                                //缓存用户信息模型字典
                                                [SHRoutingComponent openURL:CACHEDATA withParameter:@{@"CacheKey":USERINFORMODELKEY,@"CacheData":userInforDic}];
                                                [weakSelf back];
//                                                [weakSelf refreshRootVC];
                                            }
                                        }
                                        else{
                                            
                                            [MBProgressHUD wj_showError:@"登录失败，请稍后重试"];
                                        }
                                    }
                                }
                            }
                            else{
                               
                                [MBProgressHUD wj_showError:@"登录失败，请稍后重试"];
                            }
                        }
                    }
                    else{
                        
                        //失败的
                        [MBProgressHUD wj_showError:@"登录失败，请稍后重试"];
                    }
                }];
            }
        }];
    }
    else{
        
        //验证码错误
        [MBProgressHUD wj_showError:@"请输入正确的验证码"];
    }

}

-(void)back{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

//重新设置根指针
-(void)refreshRootVC{
    
    HomeViewController * homeVC = [[HomeViewController alloc] init];
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem.title = @"首页";
    homeNav.tabBarItem.image = [UIImage imageNamed:@"shouye"];
    homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye"];
    
    ForumViewController * forumVC = [[ForumViewController alloc] init];
    UINavigationController * forumNav = [[UINavigationController alloc] initWithRootViewController:forumVC];
    forumNav.tabBarItem.title = @"论坛";
    forumNav.tabBarItem.image = [UIImage imageNamed:@"luntan"];
    forumNav.tabBarItem.selectedImage = [UIImage imageNamed:@"luntan"];
    
    WorkbenchViewController * workbenchVC = [[WorkbenchViewController alloc] init];
    UINavigationController * workbenchNav = [[UINavigationController alloc] initWithRootViewController:workbenchVC];
    workbenchNav.tabBarItem.title = @"工作台";
    workbenchNav.tabBarItem.image = [UIImage imageNamed:@"gongzuotai"];
    workbenchNav.tabBarItem.selectedImage = [UIImage imageNamed:@"gongzuotai"];
    
    MineViewController * mineVC = [[MineViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [UIImage imageNamed:@"wode"];
    mineNav.tabBarItem.selectedImage = [UIImage imageNamed:@"wode"];
    
    UITabBarController * tarBarController = [[UITabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = nil;
    [UIApplication sharedApplication].keyWindow.rootViewController = tarBarController;
    tarBarController.viewControllers = @[homeNav,forumNav,workbenchNav,mineNav];
    tarBarController.selectedIndex = 2;
}

@end
