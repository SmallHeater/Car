//
//  OneCarMaintenanceRecordsViewController.m
//  Car
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "OneCarMaintenanceRecordsViewController.h"
#import "MaintenanceRecordsCell.h"

static NSString * cellId = @"MaintenanceRecordsCell";

@interface OneCarMaintenanceRecordsViewController ()

//添加按钮
@property (nonatomic,strong) UIButton * addBtn;

@end

@implementation OneCarMaintenanceRecordsViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    float cellHeight = 138;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 48;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 48)];
    headerLabel.font = BOLDFONT16;
    headerLabel.textColor = Color_333333;
    headerLabel.text = @"  2019-05-12";
    return headerLabel;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceRecordsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[MaintenanceRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell test];
    
    return cell;
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

-(void)addBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = YES;
}


@end
