//
//  PaymentManagementViewController.m
//  Car
//
//  Created by mac on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PaymentManagementViewController.h"
#import "SHMultipleSwitchingItemsView.h"
#import "UnpaidCell.h"

static NSString * cellId = @"UnpaidCell";

@interface PaymentManagementViewController ()

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
//头部切换view
@property (nonatomic,strong) SHMultipleSwitchingItemsView * itemsView;

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

-(SHMultipleSwitchingItemsView *)itemsView{
    
    if (!_itemsView) {
        
        _itemsView = [[SHMultipleSwitchingItemsView alloc] initWithItemsArray:@[@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"未回款",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1400],@"target":self,@"actionStr":@"switchBtnClicked:"},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"已回款",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1401],@"target":self,@"actionStr":@"switchBtnClicked:"}]];
        _itemsView.backgroundColor = [UIColor whiteColor];
    }
    return _itemsView;
}

#pragma mark  ----  生命周期函数
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshViewType:BTVCType_AddTableView];
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UnpaidCell cellHeight];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UnpaidCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[UnpaidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell test];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
    
    [self.view addSubview:self.itemsView];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0.5);
        make.height.offset(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.itemsView.mas_bottom).offset(0);
    }];
}

-(void)searchBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = YES;
}

//切换按钮的响应
-(void)switchBtnClicked:(UIButton *)btn{
    
    if (btn.tag == 1400) {
        
        //未回款按钮的响应
    }
    else if (btn.tag == 1401){
        
        //已回款按钮的响应
    }
}

@end
