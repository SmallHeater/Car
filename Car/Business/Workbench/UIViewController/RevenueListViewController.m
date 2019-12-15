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
#import "RevenueModel.h"


static NSString * cellId = @"RevenueCell";

@interface RevenueListViewController ()

//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
@property (nonatomic,assign) NSUInteger page;

@end

@implementation RevenueListViewController

#pragma mark  ----  懒加载

-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"sousuohei"] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [[_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.userInteractionEnabled = NO;
            
            SearchConfigurationModel * configurationModel = [[SearchConfigurationModel alloc] init];
            configurationModel.baseBodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
            configurationModel.requestUrlStr = Maintainlist;
            configurationModel.modelName = @"RevenueCell";
            
            SearchViewController * searchVC = [[SearchViewController alloc] initWithTitle:@"搜索" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSearchConfigurationModel:configurationModel];
            searchVC.searchType = SearchType_RevenueList;
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
            
            x.userInteractionEnabled = YES;
        }];
//        [_searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    self.page = 1;
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 232 + 66;
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
    
    RevenueModel * model = self.dataArray[indexPath.row];
    
    NSString * receivable = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue];
    NSString * cost = [[NSString alloc] initWithFormat:@"%.2f",model.cost.floatValue];
    NSString * profit = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue - model.cost.floatValue];
    NSString * payment = [[NSString alloc] initWithFormat:@"%.2f",model.received.floatValue];
    NSString * arrears = [[NSString alloc] initWithFormat:@"%.2f",model.debt.floatValue];
    [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":[NSString repleaseNilOrNull:model.type],@"phoneNumber":model.phone,@"receivable":receivable,@"cost":cost,@"profit":profit,@"payment":payment,@"arrears":arrears}];
    
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

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"page":[NSString stringWithFormat:@"%ld",self.page]};
    NSDictionary * configurationDic = @{@"requestUrlStr":Revenuelist,@"bodyParameters":bodyParameters};
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
                        
                        if (weakSelf.page == 1) {
                            
                            [weakSelf.dataArray removeAllObjects];
                        }
                        NSArray * list = dataDic[@"list"];
                        if (list.count == MAXCOUNT) {
                            
                            weakSelf.page++;
                        }
                        else if (list.count == 0){
                            
                            [MBProgressHUD wj_showError:@"没有更多数据啦"];
                            weakSelf.tableView.mj_footer = nil;
                        }
                        else{
                            
                            weakSelf.tableView.mj_footer = nil;
                        }
                        for (NSDictionary * dic in list) {
                            
                            RevenueModel * model = [RevenueModel mj_objectWithKeyValues:dic];
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

//下拉刷新(回调函数)
-(void)loadNewData{
    
    self.page = 1;
    [self requestListData];
    [super loadNewData];
}
//上拉加载(回调函数)
-(void)loadMoreData{
    
    [self requestListData];
    [super loadMoreData];
}

@end
