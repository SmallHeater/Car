//
//  BaseTableViewController.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 IP. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

//是否展示导航条
@property (nonatomic,assign) BOOL showNavigationBar;

@property (nonatomic,assign) UITableViewStyle tableViewStyle;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation BaseTableViewController

#pragma mark  ----  懒加载

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        NSUInteger navigationBarHeight = 0;
        if (self.showNavigationBar) {
            
            navigationBarHeight = [UIScreenControl navigationBarHeight];
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,navigationBarHeight, MAINWIDTH, MAINHEIGHT - navigationBarHeight - [UIScreenControl bottomSafeHeight]) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //取消contentSize和contentOffset的改的，解决闪屏问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.backgroundColor = [UIColor redColor];
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

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style;{

    self = [super initWithTitle:title andIsShowBackBtn:isShowBackBtn];
    if (self) {
        
        self.showNavigationBar = isShowNavgationBar;
        self.tableViewStyle = style;
        if (!isShowNavgationBar) {
            
            [self.navigationbar removeFromSuperview];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate
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
