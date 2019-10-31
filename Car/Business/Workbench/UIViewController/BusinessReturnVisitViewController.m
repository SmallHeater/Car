//
//  PaymentManagementViewController.m
//  Car
//
//  Created by mac on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "BusinessReturnVisitViewController.h"
#import "SHMultipleSwitchingItemsView.h"
#import "BusinessVisitController.h"
#import "VisitedViewController.h"
#import "SearchConfigurationModel.h"
#import "SearchViewController.h"
#import "UserInforController.h"


typedef NS_ENUM(NSUInteger,ViewType){
    
    ViewType_UnVisit,//未回款
    ViewType_Visited//已回款
};

@interface BusinessReturnVisitViewController ()<UIScrollViewDelegate,SHMultipleSwitchingItemsViewDelegate>

//头部切换view
@property (nonatomic,strong) SHMultipleSwitchingItemsView * switchItemsView;
@property (nonatomic,strong) UIScrollView * bgScrollView;
@property (nonatomic,assign) ViewType viewType;
@property (nonatomic,strong) BusinessVisitController * businessVisitVC;
@property (nonatomic,strong) VisitedViewController * visitedVC;

@end

@implementation BusinessReturnVisitViewController

#pragma mark  ----  懒加载

-(SHMultipleSwitchingItemsView *)switchItemsView{
    
    if (!_switchItemsView) {
        
        _switchItemsView = [[SHMultipleSwitchingItemsView alloc] initWithItemsArray:@[@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"未回访",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1400]},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"已回访",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1401]}]];
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
        BusinessVisitController * businessVisitVC = [[BusinessVisitController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * businessVisitView = businessVisitVC.view;
        businessVisitView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.switchItemsView.frame));
        [_bgScrollView addSubview:businessVisitView];
        [self addChildViewController:businessVisitVC];
        self.businessVisitVC = businessVisitVC;
        //已回款
        VisitedViewController * visitedVC = [[VisitedViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * repaidView = visitedVC.view;
        repaidView.frame = CGRectMake(MAINWIDTH, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.switchItemsView.frame));
        [_bgScrollView addSubview:repaidView];
        self.visitedVC = visitedVC;
        [self addChildViewController:visitedVC];
    }
    return _bgScrollView;
}

#pragma mark  ----  生命周期函数
    
- (void)viewDidLoad {
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    self.viewType = ViewType_UnVisit;
    [self drawUI];
}

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        
        self.viewType = ViewType_UnVisit;
        [self.switchItemsView setBtnSelectedWithIndex:0];
    }
    else{
        
        self.viewType = ViewType_Visited;
        [self.switchItemsView setBtnSelectedWithIndex:1];
    }
}

#pragma mark  ----  SHMultipleSwitchingItemsViewDelegate

-(void)selectedWithBtnTag:(NSUInteger)btnTag{
    
    if (btnTag == 1400) {
        
        [self.businessVisitVC requestListData];
        //未回款按钮的响应
        self.viewType = ViewType_UnVisit;
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (btnTag == 1401){
        
        [self.visitedVC requestListData];
        //已回款按钮的响应
        self.viewType = ViewType_Visited;
        [self addChildViewController:self.visitedVC];
        self.bgScrollView.contentOffset = CGPointMake(MAINWIDTH, 0);
    }
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
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

@end
