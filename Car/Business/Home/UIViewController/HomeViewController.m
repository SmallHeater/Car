//
//  HomeViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavgationBar.h"
#import "CarouselCell.h"
#import "BaseWKWebViewController.h"
#import "ItemsCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HomeNavgationBar * homeNavgationBar;
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation HomeViewController

#pragma mark  ----  懒加载

-(HomeNavgationBar *)homeNavgationBar{
    
    if (!_homeNavgationBar) {
        
        _homeNavgationBar = [[HomeNavgationBar alloc] init];
//        _homeNavgationBar.backgroundColor = [UIColor greenColor];
    }
    return _homeNavgationBar;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    switch (indexPath.row) {
        case 0:
            
            cellHeight = (MAINWIDTH - 15 * 2) / 345.0 * 150.0;
            break;
        case 1:
            
            cellHeight = 180;
            break;
        default:
            break;
    }
    
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if (section == 0) {
        
        rows = 2;
    }
    else if (section == 1){
        
        rows = 0;
    }
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
     
        if (indexPath.row == 0){
            
            static NSString * carouselCellId = @"CarouselCell";
            CarouselCell * cell = [tableView dequeueReusableCellWithIdentifier:carouselCellId];
            if (!cell) {
                
                cell = [[CarouselCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carouselCellId];
                
                __weak typeof(self) weakSelf = self;
                cell.clickCallBack = ^(NSString * _Nonnull urlStr) {
                    
                    if (![NSString strIsEmpty:urlStr]) {
                        
                        BaseWKWebViewController * webViewController = [[BaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
                        webViewController.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:webViewController animated:YES];
                    }
                };
                cell.backgroundColor = [UIColor greenColor];
            }
            
            //        if (self.workbenchModel.banner && self.workbenchModel.banner.count > 0) {
            //
            //            [cell showData:self.workbenchModel.banner];
            //        }
            return cell;
        }
        else if (indexPath.row == 1){
            
            static NSString * ItemsCellID = @"ItemsCell";
            ItemsCell * cell = [tableView dequeueReusableCellWithIdentifier:ItemsCellID];
            if (!cell) {
                
                cell = [[ItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItemsCellID];
            }
            
            return cell;
        }
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.homeNavgationBar];
    [self.homeNavgationBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(31 + [UIScreenControl liuHaiHeight]);
        make.height.offset(40);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.homeNavgationBar.mas_bottom);
    }];
}

@end
