//
//  ReportViewController.m
//  Car
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ReportViewController.h"
#import "SHTextView.h"
#import "UserInforController.h"

@interface ReportViewController ()

//举报id
@property (nonatomic,strong) NSString * reportId;
@property (nonatomic,strong) SHTextView * reportTextView;
//举报
@property (nonatomic,strong) UIButton * reportBtn;

@end

@implementation ReportViewController

#pragma mark  ----  懒加载

-(SHTextView *)reportTextView{
    
    if (!_reportTextView) {
        
        _reportTextView = [[SHTextView alloc] init];
        _reportTextView.textFont = FONT16;
        _reportTextView.textColor = Color_333333;
        _reportTextView.placeholderColor = Color_CCCCCC;
        _reportTextView.placeholder = @"请输入举报原因";
        _reportTextView.layer.borderColor = Color_CCCCCC.CGColor;
        _reportTextView.layer.borderWidth = 1;
    }
    return _reportTextView;
}

-(UIButton *)reportBtn{
    
    if (!_reportBtn) {
        
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_reportBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_reportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf requestData];
        }];
    }
    return _reportBtn;
}

#pragma mark  ----  生命周期函数

//举报id
-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andId:(NSString *)reportId{
    
    self = [super initWithTitle:title andIsShowBackBtn:isShowBackBtn];
    if (self) {
        
        self.reportId = [NSString repleaseNilOrNull:reportId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.reportTextView];
    [self.reportTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(10);
        make.height.offset(100);
    }];
    
    [self.view addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.reportTextView.mas_bottom).offset(20);
        make.height.offset(40);
    }];
}

-(void)requestData{
    
    if (![NSString strIsEmpty:self.reportTextView.text]) {
        
        [self.reportTextView endEditing:YES];
        NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"commentable_type":@"article",@"commentable_id":self.reportId,@"content":self.reportTextView.text};
        NSDictionary * configurationDic = @{@"requestUrlStr":Inform,@"bodyParameters":bodyParameters};
        __weak typeof(self) weakSelf = self;
        [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
            
            if (![resultDic.allKeys containsObject:@"error"]) {
                
                //成功的
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                    
                    [weakSelf backBtnClicked:nil];
                }
                else{
                }
            }
            else{
                
                //失败的
            }
        }];
    }
    else{
        
        [MBProgressHUD wj_showError:@"请输入举报原因"];
    }
}

@end
