//
//  SearchViewController.m
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBarTwoCell.h"
#import "SearchConfigurationModel.h"
#import "MaintenanceRecordsOneDayModel.h"
#import "MaintenanceRecordsModel.h"
#import "MaintenanceRecordsCell.h"
#import "MaintenanceRecordsDetailViewController.h"
#import "RevenueCell.h"
#import "UnpaidModel.h"
#import "RepaidModel.h"
#import "UnpaidCell.h"
#import "RepaidCell.h"
#import "UserInforController.h"


@interface SearchViewController ()

@property (nonatomic,strong) SearchConfigurationModel * configurationModel;
@property (nonatomic,strong) NSString * searchText;

@end

@implementation SearchViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSearchConfigurationModel:(SearchConfigurationModel *)configurationModel{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style andIsShowHead:NO andIsShowFoot:NO];
    if (self) {
        
        self.configurationModel = configurationModel;
    }
    return self;
}

- (void)viewDidLoad {
    
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.section == 0) {
        
        cellHeight = 82;
    }
    else{
        
        if (self.searchType == SearchType_MaintenanceRecords) {
            
            MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section - 1];
            MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
            cellHeight = [MaintenanceRecordsCell cellHeightWithContent:recordModel.content];
        }
        else if (self.searchType == SearchType_RevenueList){
            
            cellHeight = 232;
        }
        else if (self.searchType == SearchType_Unpaid){
            
            cellHeight = [UnpaidCell cellHeight];
        }
        else if (self.searchType == SearchType_Repaid){
            
            RepaidModel * model = self.dataArray[indexPath.row];
            cellHeight = [RepaidCell cellHeightWithContent:@"" andRepaidListCount:model.repaylist.count];
        }
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight = 0;
    if (section == 0) {
    
    }
    else{
        
        if (self.searchType == SearchType_MaintenanceRecords) {
            
            headerHeight = 44;
        }
    }
    return headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView;
    if (section == 0) {
        
    }
    else{
        
        if (self.searchType == SearchType_MaintenanceRecords) {
            
            MaintenanceRecordsOneDayModel * model = self.dataArray[section - 1];
            headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 44)];
            headerView.backgroundColor = [UIColor whiteColor];
            UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, MAINWIDTH,32)];
            headerLabel.backgroundColor = [UIColor whiteColor];
            headerLabel.font = BOLDFONT16;
            headerLabel.textColor = Color_333333;
            headerLabel.text = [[NSString alloc] initWithFormat:@"      %@",model.day];
            [headerView addSubview:headerLabel];
        }
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.searchType == SearchType_MaintenanceRecords) {
        
     
        MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section - 1];
        MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
        MaintenanceRecordsDetailViewController * vc = [[MaintenanceRecordsDetailViewController alloc] initWithTitle:@"维修记录详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
        vc.maintenanceRecordsModel = recordModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark  ----  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSUInteger sections = 1;
    if (self.searchType == SearchType_MaintenanceRecords) {
    
        sections = self.dataArray.count + 1;
    }
    else{
        
        sections = self.dataArray.count > 0?2:1;
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if (section == 0) {
        
        rows = 1;
    }
    else{
        
        if (self.searchType == SearchType_MaintenanceRecords) {
            
            MaintenanceRecordsOneDayModel * model = self.dataArray[section - 1];
            rows = model.list.count;
        }
        else{
            
            rows = self.dataArray.count;
        }
    }
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString * firstCellId = @"SearchBarTwoCell";
        SearchBarTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {

            __weak typeof(self) weakSelf = self;
            cell = [[SearchBarTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            [[cell rac_valuesForKeyPath:@"searchBar.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                if ([NSString strIsEmpty:x]) {
                    
                    weakSelf.searchText = x;
                    [weakSelf requestListDataWithContent:x];
                }
            }];
        }
        
        return cell;
    }
    else{
        
        if (self.searchType == SearchType_MaintenanceRecords) {
            
            static NSString * MaintenanceRecordsCellID = @"MaintenanceRecordsCell";
            
            MaintenanceRecordsCell * cell = [tableView dequeueReusableCellWithIdentifier:MaintenanceRecordsCellID];
            if (!cell) {
                
                cell = [[MaintenanceRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MaintenanceRecordsCellID];
            }
            
            MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section - 1];
            MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
            
            [cell showDataWithDic:@{@"numberPlate":recordModel.license_number,@"name":recordModel.contacts,@"carModel":recordModel.type,@"phoneNumber":recordModel.phone,@"MaintenanceContent":recordModel.content}];
            
            return cell;
        }
        else if (self.searchType == SearchType_RevenueList){
            
            static NSString * RevenueCellID = @"RevenueCell";
            RevenueCell * cell = [tableView dequeueReusableCellWithIdentifier:RevenueCellID];
            if (!cell) {
                
                cell = [[RevenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RevenueCellID];
            }
            
            MaintenanceRecordsModel * model = self.dataArray[indexPath.row];
            
            NSString * receivable = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue];
            NSString * cost = [[NSString alloc] initWithFormat:@"%.2f",model.cost.floatValue];
            NSString * profit = [[NSString alloc] initWithFormat:@"%.2f",model.receivable.floatValue - model.cost.floatValue];
            [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":model.type,@"phoneNumber":model.phone,@"receivable":receivable,@"cost":cost,@"profit":profit}];
            return cell;
        }
        else if (self.searchType == SearchType_Unpaid){
            
            static NSString * UnpaidCellID = @"UnpaidCell";
            UnpaidCell * cell = [tableView dequeueReusableCellWithIdentifier:UnpaidCellID];
            if (!cell) {
                
                cell = [[UnpaidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UnpaidCellID];
            }
            
            //展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;receivable:应收款;actualHarvest:实收款;arrears:欠款;
            UnpaidModel * model = self.dataArray[indexPath.row];
            [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":model.type,@"phoneNumber":model.phone,@"content":model.content,@"receivable":model.receivable,@"actualHarvest":model.received,@"arrears":model.debt}];
            
            __weak typeof(self) weakSelf = self;
            cell.btnClickCallBack = ^{
                
                UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"回款" message:nil preferredStyle:
                                               UIAlertControllerStyleAlert];
                [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                    textField.keyboardType = UIKeyboardTypePhonePad;
                    textField.placeholder = @"请输入回款金额";
                }];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    // 通过数组拿到textTF的值
                    NSString * str = [[alertVc textFields] objectAtIndex:0].text;
                    if (str.floatValue > model.debt.floatValue) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD wj_showError:@"输入回款金额大于欠款金额，请重新输入"];
                        });
                    }
                    else{
                        
                        [weakSelf payBackWithMaintainId:model.maintain_id  andMoney:str.floatValue];
                    }
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                // 添加行为
                [alertVc addAction:action2];
                [alertVc addAction:action1];
                alertVc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:alertVc animated:YES completion:nil];
            };
            
            return cell;
        }
        else if (self.searchType == SearchType_Repaid){
            
            static NSString * RepaidCellID = @"RepaidCell";
            RepaidCell * cell = [tableView dequeueReusableCellWithIdentifier:RepaidCellID];
            if (!cell) {
                
                cell = [[RepaidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RepaidCellID];
            }
            
            RepaidModel * model = self.dataArray[indexPath.row];
            NSArray * arr = [model mj_keyValues][@"repaylist"];
            [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":model.type,@"phoneNumber":model.phone,@"content":model.content,@"repaidList":arr}];
            
            return cell;
        }
    }
    
    return nil;
}

#pragma mark  ----  自定义函数


-(void)requestListDataWithContent:(NSString *)content{
    
    if (![NSString strIsEmpty:content]) {
        
        NSMutableDictionary * bodyParameters = [[NSMutableDictionary alloc] initWithDictionary:self.configurationModel.baseBodyParameters];
        [bodyParameters setObject:content forKey:@"content"];
        
        NSDictionary * configurationDic = @{@"requestUrlStr":self.configurationModel.requestUrlStr,@"bodyParameters":bodyParameters};
        __weak typeof(self) weakSelf = self;
        [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
            
            if (![resultDic.allKeys containsObject:@"error"]) {
                
                //成功的
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                    
                    id dataId = resultDic[@"dataId"];
                    NSDictionary * dic = (NSDictionary *)dataId;
                    NSNumber * code = dic[@"code"];
                    NSDictionary * dataDic = dic[@"data"];
                    [weakSelf.dataArray removeAllObjects];
                    if (code.integerValue == 1) {
                        
                        if (weakSelf.searchType == SearchType_MaintenanceRecords) {
                        
                            if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                                
                                NSArray * list = dataDic[@"list"];
                                for (NSDictionary * dic in list) {
                                    
                                    MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
                                    [weakSelf.dataArray addObject:model];
                                }
                            }
                        }
                        else if (weakSelf.searchType == SearchType_RevenueList){
                            
                            if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                                
                                NSArray * list = dataDic[@"list"];
                                for (NSDictionary * dic in list) {
                                    
                                    MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
                                    for (MaintenanceRecordsModel * recordModel in model.list) {
                                        
                                        [weakSelf.dataArray addObject:recordModel];
                                    }
                                }
                            }
                        }
                        else if (weakSelf.searchType == SearchType_Unpaid){
                            
                            NSArray * arr = dataDic[@"list"];
                            [weakSelf.dataArray removeAllObjects];
                            for (NSDictionary * dic in arr) {
                                
                                UnpaidModel * model = [UnpaidModel mj_objectWithKeyValues:dic];
                                [weakSelf.dataArray addObject:model];
                            }
                        }
                        else if (weakSelf.searchType == SearchType_Repaid){
                            
                            NSArray * arr = dataDic[@"list"];
                            for (NSDictionary * dic in arr) {
                                
                                RepaidModel * model = [RepaidModel mj_objectWithKeyValues:dic];
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
    
    else{
        
        [self.dataArray removeAllObjects];
        [self refreshViewType:BTVCType_RefreshTableView];
    }
}

//回款
-(void)payBackWithMaintainId:(NSString *)maintain_id andMoney:(float)money{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"maintain_id":maintain_id,@"money":[NSNumber numberWithFloat:money]};
    NSDictionary * configurationDic = @{@"requestUrlStr":Nowrepay,@"bodyParameters":bodyParameters};
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
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    [weakSelf requestListDataWithContent:weakSelf.searchText];;
                }
                else{
                    
                    //异常
                    [MBProgressHUD wj_showError:dic[@"msg"]];
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
