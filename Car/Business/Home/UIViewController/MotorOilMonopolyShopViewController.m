//
//  MotorOilMonopolyEvaluationViewController.m
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyShopViewController.h"
#import "AgentCell.h"
#import "ProductStatementCell.h"

static NSString * AgentCellId = @"AgentCell";
static NSString * ProductStatementCellId = @"ProductStatementCell";

@interface MotorOilMonopolyShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) ShopModel * shopModel;

@end

@implementation MotorOilMonopolyShopViewController

#pragma mark  ----  懒加载

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithShopModel:(ShopModel *)shopModel{
    
    self = [super init];
    if (self) {
        
        self.shopModel =shopModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 251;
    }
    else if (indexPath.row == 1){
        
        cellHeight = 124;
    }
    else if (indexPath.row == 2){
        
        cellHeight = 129;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 3;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        AgentCell * cell = [tableView dequeueReusableCellWithIdentifier:AgentCellId];
        if (!cell) {
            
            cell = [[AgentCell alloc] initWithReuseIdentifier:AgentCellId];
        }
        
        [cell show:self.shopModel];
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        ProductStatementCell * cell = [tableView dequeueReusableCellWithIdentifier:ProductStatementCellId];
        if (!cell) {
            
            cell = [[ProductStatementCell alloc] initWithReuseIdentifier:ProductStatementCellId andShowBottomLine:YES];
        }
        
        [cell show:@"产品声明" content:@"产品由中材集团（央企）统一销售供应，代理商负责产品配送和客户服务。产品质量由中国人寿保险公司承保，如因产品质量造成的设备故障，将享有保险公司最高1000万理赔。"];
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        ProductStatementCell * cell = [tableView dequeueReusableCellWithIdentifier:ProductStatementCellId];
        if (!cell) {
            
            cell = [[ProductStatementCell alloc] initWithReuseIdentifier:ProductStatementCellId andShowBottomLine:NO];
        }
        
        [cell show:@"法律声明" content:@"未经中材集团（央企）授权，任何组织和个人不得冒用中材集团（央企）宣传销售假冒伪劣产品。否则追究刑事责任！"];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.right.offset(0);
    }];
}

@end
