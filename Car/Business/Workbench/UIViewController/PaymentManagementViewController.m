//
//  PaymentManagementViewController.m
//  Car
//
//  Created by mac on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PaymentManagementViewController.h"
#import "SHMultipleSwitchingItemsView.h"
#import "UnpaidViewController.h"
#import "RepaidViewController.h"
#import "SearchConfigurationModel.h"
#import "SearchViewController.h"
#import "UserInforController.h"


typedef NS_ENUM(NSUInteger,ViewType){
    
    ViewType_Unpaid,//未回款
    ViewType_Repaid//已回款
};

@interface PaymentManagementViewController ()<UIScrollViewDelegate,SHMultipleSwitchingItemsViewDelegate>

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
//头部切换view
@property (nonatomic,strong) SHMultipleSwitchingItemsView * switchItemsView;
@property (nonatomic,strong) UIScrollView * bgScrollView;
@property (nonatomic,assign) ViewType viewType;
@property (nonatomic,strong) UnpaidViewController * unpaidVC;
@property (nonatomic,strong) RepaidViewController * repaidVC;

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

-(SHMultipleSwitchingItemsView *)switchItemsView{
    
    if (!_switchItemsView) {
        
        _switchItemsView = [[SHMultipleSwitchingItemsView alloc] initWithItemsArray:@[@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"未回款",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1400]},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"已回款",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1401]}]];
        _switchItemsView.delegate = self;
        _switchItemsView.backgroundColor = [UIColor whiteColor];
    }
    return _switchItemsView;
}

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake(MAINWIDTH * 2, MAINHEIGHT - CGRectGetMaxY(self.switchItemsView.frame));
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        //未回款
        UnpaidViewController * unpaidVC = [[UnpaidViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * unpaidView = unpaidVC.view;
        unpaidView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.switchItemsView.frame));
        [_bgScrollView addSubview:unpaidView];
        [self addChildViewController:unpaidVC];
        self.unpaidVC = unpaidVC;
        //已回款
        RepaidViewController * repaidVC = [[RepaidViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * repaidView = repaidVC.view;
        repaidView.frame = CGRectMake(MAINWIDTH, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.switchItemsView.frame));
        [_bgScrollView addSubview:repaidView];
        self.repaidVC = repaidVC;
        [self addChildViewController:repaidVC];
    }
    return _bgScrollView;
}

#pragma mark  ----  生命周期函数
    
- (void)viewDidLoad {
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    self.viewType = ViewType_Unpaid;
    [self drawUI];
}

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        
        self.viewType = ViewType_Unpaid;
        [self.switchItemsView setBtnSelectedWithIndex:0];
    }
    else{
        
        self.viewType = ViewType_Repaid;
        [self.switchItemsView setBtnSelectedWithIndex:1];
    }
}

#pragma mark  ----  SHMultipleSwitchingItemsViewDelegate

-(void)selectedWithBtnTag:(NSUInteger)btnTag{
    
    if (btnTag == 1400) {
        
        [self.unpaidVC requestListData];
        //未回款按钮的响应
        self.viewType = ViewType_Unpaid;
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (btnTag == 1401){
        
        [self.repaidVC requestListData];
        //已回款按钮的响应
        self.viewType = ViewType_Repaid;
        [self addChildViewController:self.repaidVC];
        self.bgScrollView.contentOffset = CGPointMake(MAINWIDTH, 0);
    }
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
    
    [self.view addSubview:self.switchItemsView];
    [self.switchItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0.5);
        make.height.offset(44);
    }];
    
    [self.view layoutIfNeeded];
    
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.bottom.offset(0);
        make.top.equalTo(self.switchItemsView.mas_bottom);
    }];
}

-(void)searchBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    int type;
    NSString * modelName;
    SearchType searchType;
    if (self.viewType == ViewType_Unpaid) {
        
        type = 0;
        modelName = @"UnpaidCell";
        searchType = SearchType_Unpaid;
    }
    else{
        
        type = 1;
        modelName = @"RepaidCell";
        searchType = SearchType_Repaid;
    }
    
    SearchConfigurationModel * configurationModel = [[SearchConfigurationModel alloc] init];
    configurationModel.baseBodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"type":[NSNumber numberWithInt:type]};
    configurationModel.requestUrlStr = Payment;
    configurationModel.modelName = modelName;
    
    SearchViewController * searchVC = [[SearchViewController alloc] initWithTitle:@"搜索" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSearchConfigurationModel:configurationModel];
    searchVC.searchType = searchType;
    [self.navigationController pushViewController:searchVC animated:YES];
    
    btn.userInteractionEnabled = YES;
}



@end
