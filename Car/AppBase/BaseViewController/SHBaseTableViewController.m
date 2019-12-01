//
//  SHBaseTableViewController.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 IP. All rights reserved.
//

#import "SHBaseTableViewController.h"

@interface SHBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

//是否展示导航条
@property (nonatomic,assign) BOOL showNavigationBar;
//是否展示下拉刷新
@property (nonatomic,assign) BOOL isShowHead;
//是否展示上拉加载
@property (nonatomic,assign) BOOL isShowFoot;
@property (nonatomic,assign) UITableViewStyle tableViewStyle;

@end

@implementation SHBaseTableViewController

#pragma mark  ----  懒加载

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        NSUInteger navigationBarHeight = 0;
        if (self.showNavigationBar) {
            
            navigationBarHeight = [SHUIScreenControl navigationBarHeight];
        }
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,navigationBarHeight, MAINWIDTH, MAINHEIGHT - navigationBarHeight - [SHUIScreenControl bottomSafeHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (self.isShowHead) {
            
             _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        }
       
        if (self.isShowFoot) {
            
            _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

//isShowHead,是否显示下拉刷新;isShowFoot，是否显示上拉加载
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andIsShowHead:(BOOL)isShowHead andIsShowFoot:(BOOL)isShowFoot{

    self = [super initWithTitle:title andIsShowBackBtn:isShowBackBtn];
    if (self) {
        
        self.showNavigationBar = isShowNavgationBar;
        self.tableViewStyle = style;
        self.navigationbar.hidden = !isShowNavgationBar;
        self.isShowHead = isShowHead;
        self.isShowFoot = isShowFoot;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark  ----  自定义函数
-(void)requestListData{
    
}

//下拉刷新
-(void)loadNewData{
    
    [self.tableView.mj_header endRefreshing];
}
//上拉加载
-(void)loadMoreData{
    
    [self.tableView.mj_footer endRefreshing];
}


-(void)refreshViewType:(BTVCType)viewType{
    
    [self.navigationbar bringSubviewToFront:self.view];
    
    if (viewType != BTVCType_RefreshTableView) {
        
        [self.tableView removeFromSuperview];
    }
    
    switch (viewType) {
        case BTVCType_AddTableView:
        {
            
            [self.view addSubview:self.tableView];
            break;
        }
        case BTVCType_RefreshTableView:
        {
            
            [self.tableView reloadData];
            break;
        }
        case BTVCType_NoData:
        {
            
            //无数据
            break;
        }
            
        case BTVCType_NoInterNet:
        {
            //无网络
            break;
        }
        default:
            break;
    }
}



@end
