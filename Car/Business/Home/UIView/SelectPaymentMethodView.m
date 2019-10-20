//
//  SelectPaymentMethodView.m
//  Car
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SelectPaymentMethodView.h"
#import "UIViewController+SHTool.h"
#import "PaymentMethodCell.h"

static NSString * cellId = @"PaymentMethodCell";

@interface SelectPaymentMethodView ()<UITableViewDelegate,UITableViewDataSource>

//顶部灰色view
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * tableHeadView;
//中间tableView
@property (nonatomic,strong) SHBaseTableView * tableView;
//确认按钮
@property (nonatomic,strong) UIButton * sureBtn;
//支付方式
@property (nonatomic,strong) NSString * payMethod;

@end

@implementation SelectPaymentMethodView

#pragma mark  ----  懒加载

-(UIView *)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.39];
        _topView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        __weak typeof(self) weakSelf = self;
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否放弃支付" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf removeFromSuperview];
            }];
            
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertControl addAction:sureAction];
            [alertControl addAction:cancleAction];
            
            [[UIViewController topMostController] presentViewController:alertControl animated:YES completion:nil];
        }];
        [_topView addGestureRecognizer:tap];
    }
    return _topView;
}

-(UIView *)tableHeadView{
    
    if (!_tableHeadView) {
        
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 49)];
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT16;
        titleLabel.textColor = Color_333333;
        titleLabel.text = @"选择支付方式";
        [_tableHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.offset(0);
            make.width.offset(170);
            make.bottom.offset(-1);
        }];
        
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = Color_EEEEEE;
        [_tableHeadView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.offset(0);
            make.height.offset(1);
        }];
    }
    return _tableHeadView;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeadView;
    }
    return _tableView;
}

-(UIButton *)sureBtn{
    
    if (!_sureBtn) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = Color_0272FF;
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT18;
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 2;
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ---- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.payMethod = @"wechat";
    }
    else if (indexPath.row == 1){
        
        self.payMethod = @"alipay";
    }
}

#pragma mark  ---- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaymentMethodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[PaymentMethodCell alloc] initWithReuseIdentifier:cellId];
    }
    
    NSString * iconImageName = @"";
    NSString * title = @"";
    if (indexPath.row == 0) {
        
        iconImageName = @"weixin";
        title = @"微信";
    }
    else if (indexPath.row == 1){
        
        iconImageName = @"zhifubao";
        title = @"支付宝";
    }
    
    [cell show:iconImageName titleStr:title];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.offset(0);
        make.height.offset(MAINHEIGHT - 204 - [UIScreenControl bottomSafeHeight]);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.offset(204);
    }];
    
    [self addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-5 - [UIScreenControl bottomSafeHeight]);
        make.height.offset(47);
    }];
}

-(void)sureBtnClicked{
    
    if ([NSString strIsEmpty:self.payMethod]) {
        
        [MBProgressHUD wj_showError:@"请选择支付方式"];
    }
    else{
     
        [self removeFromSuperview];
    }
}

@end
