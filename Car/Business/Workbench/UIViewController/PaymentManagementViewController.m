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


@interface PaymentManagementViewController ()<UIScrollViewDelegate>

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
//头部切换view
@property (nonatomic,strong) SHMultipleSwitchingItemsView * itemsView;
@property (nonatomic,strong) UIScrollView * bgScrollView;

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

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake(MAINWIDTH * 2, MAINHEIGHT - CGRectGetMaxY(self.itemsView.frame));
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        //未回款
        UnpaidViewController * unpaidVC = [[UnpaidViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * unpaidView = unpaidVC.view;
        unpaidView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.itemsView.frame));
        [_bgScrollView addSubview:unpaidView];
        [self addChildViewController:unpaidVC];
        //已回款
        RepaidViewController * repaidVC = [[RepaidViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        UIView * repaidView = repaidVC.view;
        repaidView.frame = CGRectMake(MAINWIDTH, 0, MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.itemsView.frame));
        [_bgScrollView addSubview:repaidView];
        [self addChildViewController:repaidVC];
    }
    return _bgScrollView;
}

#pragma mark  ----  生命周期函数
    
- (void)viewDidLoad {
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        
        [self.itemsView setBtnSelectedWithIndex:0];
    }
    else{
        
        [self.itemsView setBtnSelectedWithIndex:1];
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
    
    [self.view addSubview:self.itemsView];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0.5);
        make.height.offset(44);
    }];
    
    [self.view layoutIfNeeded];
    
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.bottom.offset(0);
        make.top.equalTo(self.itemsView.mas_bottom);
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
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (btn.tag == 1401){
        
        //已回款按钮的响应
        self.bgScrollView.contentOffset = CGPointMake(MAINWIDTH, 0);
    }
}

@end
