//
//  RevenueListViewController.m
//  Car
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RevenueListViewController.h"
#import "RevenueCell.h"

static NSString * cellId = @"RevenueCell";

@interface RevenueListViewController ()

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;

@end

@implementation RevenueListViewController

#pragma mark  ----  懒加载

-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"sousuohei"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 232;
    return cellHeight;
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RevenueCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[RevenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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
}

-(void)searchBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = YES;
}

@end
