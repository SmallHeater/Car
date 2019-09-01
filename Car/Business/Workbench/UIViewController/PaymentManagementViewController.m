//
//  PaymentManagementViewController.m
//  Car
//
//  Created by mac on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PaymentManagementViewController.h"

@interface PaymentManagementViewController ()

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
//切换view
@property (nonatomic,strong) UIView * switchView;
//未回款按钮
@property (nonatomic,strong) UIButton * unpaidBtn;
//已回款按钮
@property (nonatomic,strong) UIButton * repaidBtn;
//选中的蓝线
@property (nonatomic,strong) UILabel * selectedBlueLabel;

@end

@implementation PaymentManagementViewController

#pragma mark  ----  懒加载

-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"sousuohei"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

-(UILabel *)selectedBlueLabel{
    
    if (!_selectedBlueLabel) {
        
        _selectedBlueLabel = [[UILabel alloc] init];
        _selectedBlueLabel.backgroundColor = Color_0272FF;
    }
    return _selectedBlueLabel;
}
    
-(UIView *)switchView{

    if (!_switchView) {
        
        _switchView = [[UIView alloc] init];
        _switchView.backgroundColor = [UIColor whiteColor];
    
        UILabel * topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = Color_EEEEEE;
        [_switchView addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.offset(0);
            make.height.offset(1);
        }];
        
        float btnWidth = MAINWIDTH / 2.0;
        [_switchView addSubview:self.unpaidBtn];
        [self.unpaidBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.top.bottom.offset(0);
            make.width.offset(btnWidth);
        }];
        [_switchView addSubview:self.selectedBlueLabel];
        [self.selectedBlueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.offset(64);
            make.height.offset(2);
            make.left.offset(MAINWIDTH / 4.0 - 32);
            make.bottom.offset(-1);
        }];
        
        [_switchView addSubview:self.repaidBtn];
        [self.repaidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.top.bottom.offset(0);
            make.width.offset(btnWidth);
        }];
        
        UILabel * bottomLineLabel = [[UILabel alloc] init];
        bottomLineLabel.backgroundColor = Color_EEEEEE;
        [_switchView addSubview:bottomLineLabel];
        [bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.offset(0);
            make.height.offset(1);
        }];
    }
    return _switchView;
}
    
-(UIButton *)unpaidBtn{
    
    if (!_unpaidBtn) {
        
        _unpaidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _unpaidBtn.selected = YES;
        [_unpaidBtn setTitle:@"未回款" forState:UIControlStateNormal];
        _unpaidBtn.titleLabel.font = FONT16;
        [_unpaidBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        [_unpaidBtn setTitleColor:Color_0272FF forState:UIControlStateSelected];
        [_unpaidBtn addTarget:self action:@selector(unpaidBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unpaidBtn;
}
    
-(UIButton *)repaidBtn{
    
    if (!_repaidBtn) {
        
        _repaidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repaidBtn setTitle:@"已回款" forState:UIControlStateNormal];
        _repaidBtn.titleLabel.font = FONT16;
        [_repaidBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        [_repaidBtn setTitleColor:Color_0272FF forState:UIControlStateSelected];
        [_repaidBtn addTarget:self action:@selector(repaidBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repaidBtn;
}

#pragma mark  ----  生命周期函数
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
    
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.height.offset(44);
    }];
}

-(void)searchBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = YES;
}

//未回款按钮的响应
-(void)unpaidBtnClicked:(UIButton *)btn{

    btn.userInteractionEnabled = NO;
    self.repaidBtn.selected = NO;
    btn.selected = YES;
    [self.selectedBlueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(64);
        make.height.offset(2);
        make.left.offset(MAINWIDTH / 4.0 - 32);
        make.bottom.offset(-1);
    }];
    
    btn.userInteractionEnabled = YES;
}

//已回款按钮的响应
-(void)repaidBtnClicked:(UIButton *)btn{

    btn.userInteractionEnabled = NO;
    self.unpaidBtn.selected = NO;
    btn.selected = YES;
    [self.selectedBlueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(64);
        make.height.offset(2);
        make.right.offset(MAINWIDTH / 4.0 - 32);
        make.bottom.offset(-1);
    }];
    
    btn.userInteractionEnabled = YES;
}

@end
