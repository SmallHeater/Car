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
        
        NSString * str;
        if (![NSString strIsEmpty:self.shopModel.declaration_production]) {
            
            str = self.shopModel.declaration_production;
        }else if (![NSString strIsEmpty:self.shopModel.declaration_law]){
            
            str = self.shopModel.declaration_law;
        }
        
        cellHeight = 40 + [str heightWithFont:FONT12 andWidth:MAINWIDTH - 16 * 2] + 18;
    }
    else if (indexPath.row == 2){
        
        NSString * str = [NSString repleaseNilOrNull:self.shopModel.declaration_law];
        cellHeight = 40 + [str heightWithFont:FONT12 andWidth:MAINWIDTH - 16 * 2] + 18;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 1;
    if (![NSString strIsEmpty:self.shopModel.declaration_production]) {
        
        //产品声明
        rows++;
    }
    
    if (![NSString strIsEmpty:self.shopModel.declaration_law]) {
        
        //法律声明
        rows++;
    }
    
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
        
        NSString * title;
        NSString * content;
        if (![NSString strIsEmpty:self.shopModel.declaration_production]) {
            
            title = @"产品声明";
            content = self.shopModel.declaration_production;
        }
        else if (![NSString strIsEmpty:self.shopModel.declaration_law]){
            
            title = @"法律声明";
            content = self.shopModel.declaration_law;
        }
        
        [cell show:title content:content];
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        ProductStatementCell * cell = [tableView dequeueReusableCellWithIdentifier:ProductStatementCellId];
        if (!cell) {
            
            cell = [[ProductStatementCell alloc] initWithReuseIdentifier:ProductStatementCellId andShowBottomLine:NO];
        }
        
        NSString * title = @"法律声明";
        NSString * content = [NSString repleaseNilOrNull:self.shopModel.declaration_law];
        [cell show:title content:content];
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
