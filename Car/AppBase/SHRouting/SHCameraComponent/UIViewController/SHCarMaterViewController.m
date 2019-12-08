//
//  SHCarMaterViewController.m
//  Car
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCarMaterViewController.h"

@interface SHCarMaterViewController ()

@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UILabel * titleLabel;
//相框view
@property (nonatomic,strong) UIImageView * circleImageView;
//提示label
@property (nonatomic,strong) UILabel * promptLabel;
//去相册按钮
//@property (nonatomic,strong) UIButton * 

@end

@implementation SHCarMaterViewController

#pragma mark  ----  懒加载

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (weakSelf.navigationController) {
                
                if (weakSelf.navigationController.viewControllers.count == 1) {
                    
                    [weakSelf.navigationController dismissViewControllerAnimated:NO completion:nil];
                }else{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
    return _backBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT18;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"行驶证识别";
    }
    return _titleLabel;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.view.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(31 + [SHUIScreenControl liuHaiHeight]);
        make.width.height.offset(22);
    }];
    
    float titleWidth = 150;
    float leftInterval = (MAINWIDTH - titleWidth) / 2;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(leftInterval);
        make.top.offset(31 + [SHUIScreenControl liuHaiHeight]);
        make.width.offset(titleWidth);
        make.height.offset(25);
    }];
}

@end
