//
//  ResidualTransactionViewController.m
//  Car
//
//  Created by mac on 2019/9/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionViewController.h"
#import "CommodityCell.h"
#import "UserInforController.h"
#import "ResidualTransactionDetailViewController.h"
#import "ResidualTransactionModel.h"

static NSString * CommodityCellID = @"CommodityCell";

@interface ResidualTransactionViewController ()

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;

@end

@implementation ResidualTransactionViewController

#pragma mark  ----  懒加载

-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"sousuohei"] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [[_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
//            SearchConfigurationModel * configurationModel = [[SearchConfigurationModel alloc] init];
//            configurationModel.baseBodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
//            configurationModel.requestUrlStr = Maintainlist;
//            configurationModel.modelName = @"RevenueCell";
//
//            SearchViewController * searchVC = [[SearchViewController alloc] initWithTitle:@"搜索" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSearchConfigurationModel:configurationModel];
//            searchVC.searchType = SearchType_RevenueList;
//            [weakSelf.navigationController pushViewController:searchVC animated:YES];
            
            x.userInteractionEnabled = YES;
        }];
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
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 96;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResidualTransactionModel * model = self.dataArray[indexPath.row];
    ResidualTransactionDetailViewController * vc = [[ResidualTransactionDetailViewController alloc] initWithTitle:@"详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommodityCell * cell = [tableView dequeueReusableCellWithIdentifier:CommodityCellID];
    if (!cell) {
        
        cell = [[CommodityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommodityCellID];
    }
    
    ResidualTransactionModel * model = self.dataArray[indexPath.row];
    [cell show:model];
    
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

-(void)requestListData
{
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":HandedGoodList,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    NSDictionary * dataDic = dic[@"data"];
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                        
                        NSArray * list = dataDic[@"list"];
                        for (NSDictionary * dic in list) {
                            
                            ResidualTransactionModel * model = [ResidualTransactionModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                    
                    [weakSelf refreshViewType:BTVCType_RefreshTableView];
                }
                else{
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
