//
//  RevenueListViewController.m
//  Car
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RevenueListViewController.h"
#import "RevenueCell.h"
#import "MaintenanceRecordsOneDayModel.h"
#import "UserInforController.h"
#import "SearchConfigurationModel.h"
#import "SearchViewController.h"

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
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 232;
    return cellHeight;
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RevenueCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[RevenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    MaintenanceRecordsModel * model = self.dataArray[indexPath.row];
    
    NSString * receivable = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue];
    NSString * cost = [[NSString alloc] initWithFormat:@"%.2f",model.cost.floatValue];
    NSString * profit = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue - model.cost.floatValue];
    [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":model.type,@"phoneNumber":model.phone,@"receivable":receivable,@"cost":cost,@"profit":profit}];
    
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
    
    SearchConfigurationModel * configurationModel = [[SearchConfigurationModel alloc] init];
    configurationModel.baseBodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    configurationModel.requestUrlStr = Maintainlist;
    configurationModel.modelName = @"RevenueCell";
    
    SearchViewController * searchVC = [[SearchViewController alloc] initWithTitle:@"搜索" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSearchConfigurationModel:configurationModel];
    searchVC.searchType = SearchType_RevenueList;
    [self.navigationController pushViewController:searchVC animated:YES];
    
    btn.userInteractionEnabled = YES;
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Maintainlist,@"bodyParameters":bodyParameters};
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
                            
                            MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
                            for (MaintenanceRecordsModel * recordModel in model.list) {
                             
                                [weakSelf.dataArray addObject:recordModel];
                            }
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
