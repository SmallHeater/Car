//
//  MotorOilMonopolyGoodsViewController.m
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyGoodsViewController.h"
#import "GoodsCategoryCell.h"
#import "UserInforController.h"
#import "OilBrandModel.h"
#import "GoodsCell.h"

static NSString * GoodsCategoryCellId = @"GoodsCategoryCell";
static NSString * GoodsCellId = @"GoodsCell";

@interface MotorOilMonopolyGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHBaseTableView * leftTableView;
@property (nonatomic,strong) SHBaseTableView * rightTableView;
@property (nonatomic,strong) NSMutableArray<OilBrandModel *> * dataArray;


@end

@implementation MotorOilMonopolyGoodsViewController

#pragma mark  ----  懒加载

-(SHBaseTableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}

-(SHBaseTableView *)rightTableView{
    
    if (!_rightTableView) {
        
        _rightTableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}

-(NSMutableArray<OilBrandModel *> *)dataArray{
    
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
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if ([tableView isEqual:self.leftTableView]) {
        
        cellHeight = 75;
    }
    else if ([tableView isEqual:self.rightTableView]){
        
        cellHeight = 100;
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight = 0;
    if ([tableView isEqual:self.rightTableView]) {
        
        headerHeight = 35;
    }
    return headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.rightTableView]) {
        
        OilBrandModel * model = self.dataArray[section];
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 35)];
        titleLabel.font = FONT12;
        titleLabel.textColor = Color_333333;
        titleLabel.text = model.name;
        [headerView addSubview:titleLabel];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if ([tableView isEqual:self.leftTableView]) {
        
        rows = self.dataArray.count;
    }
    else if ([tableView isEqual:self.rightTableView]){
        
        OilBrandModel * model = self.dataArray[section];
        rows = model.goods.count;
    }
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSUInteger sections = 0;
    if ([tableView isEqual:self.leftTableView]) {
        
        sections = 1;
    }
    else if ([tableView isEqual:self.rightTableView]){
        
        sections = self.dataArray.count;
    }
    return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.leftTableView]) {
        
        GoodsCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsCategoryCellId];
        if (!cell) {
            
            cell = [[GoodsCategoryCell alloc] initWithReuseIdentifier:GoodsCategoryCellId];
        }
        
        OilBrandModel * model = self.dataArray[indexPath.row];
        [cell show:model.name count:model.goods.count];
        if (indexPath.row == 0) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [cell setSelected:YES animated:YES];
            });
        }
        return cell;
    }
    else if ([tableView isEqual:self.rightTableView]){
        
        GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsCellId];
        if (!cell) {
            
            cell = [[GoodsCell alloc] initWithReuseIdentifier:GoodsCellId];
        }
        
        OilBrandModel * model = self.dataArray[indexPath.section];
        OilGoodModel * goodModel = model.goods[indexPath.row];
        [cell show:goodModel];
        return cell;
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.width.offset(75);
    }];
    
    [self.view addSubview:self.rightTableView];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.bottom.right.offset(0);
    }];
}

//获取门店数据
-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetTypeGoodsList,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                NSNumber * code = dic[@"code"];
                
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                        
                        NSArray * list = dataDic[@"list"];
                        if (list && [list isKindOfClass:[NSArray class]]) {
                            
                            for (NSDictionary * dic in list) {
                                
                                OilBrandModel * model = [OilBrandModel mj_objectWithKeyValues:dic];
                                [weakSelf.dataArray addObject:model];
                            }
                        }
                        
                        [weakSelf.leftTableView reloadData];
                        [weakSelf.rightTableView reloadData];
                    }
                }
                else{
                    
                    //异常
                }
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

@end
