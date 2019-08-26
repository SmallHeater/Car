//
//  VehicleFileViewController.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleFileViewController.h"
#import "SearchBarTwoCell.h"
#import "VehicleFileCell.h"
#import "FastPickUpViewController.h"

@interface VehicleFileViewController ()<UITableViewDataSource,UITableViewDelegate>

//添加按钮
@property (nonatomic,strong) UIButton * addBtn;

@end

@implementation VehicleFileViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
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
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 82;
    }
    else{
        
        cellHeight = 104;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellId = @"SearchBarTwoCell";
        SearchBarTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[SearchBarTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
        }
        
        return cell;
    }
    else{
        
        static NSString * secondCellId = @"VehicleFileCell";
        VehicleFileCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[VehicleFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
        }
        
        [cell test];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
}

-(void)addBtnClicked{
    
    FastPickUpViewController * vc = [[FastPickUpViewController alloc] initWithTitle:@"快速接车" andIsShowBackBtn:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
