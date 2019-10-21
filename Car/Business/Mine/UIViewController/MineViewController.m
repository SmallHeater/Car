//
//  MineViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadCell.h"
#import "MineColumnCell.h"


static NSString * MineHeadCellID = @"MineHeadCell";

@interface MineViewController ()

@end

@implementation MineViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 318;
    }
    else{
        
        cellHeight = 61;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        MineHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:MineHeadCellID];
        if (!cell) {
            
            cell = [[MineHeadCell alloc] initWithReuseIdentifier:MineHeadCellID];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.offset(-20);
    }];
}

//创造数据
-(void)createData{
    
    NSDictionary * firstDic = @{@"iconImage":@"xiaoxi",@"title":@"我的消息"};
    NSDictionary * secondDic = @{@"iconImage":@"tiezi",@"title":@"我的帖子"};
    NSDictionary * thirdDic = @{@"iconImage":@"xiaoxi",@"title":@"机油返现"};
    NSDictionary * forthDic = @{@"iconImage":@"xiaoxi",@"title":@"采购记录"};
    NSDictionary * fifthDic = @{@"iconImage":@"xiaoxi",@"title":@"关于平台"};
    [self.dataArray addObject:firstDic];
    [self.dataArray addObject:secondDic];
    [self.dataArray addObject:thirdDic];
    [self.dataArray addObject:forthDic];
    [self.dataArray addObject:fifthDic];
}

-(void)requestListData{
    
}

@end
