//
//  UnpaidViewController.m
//  Car
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "BusinessVisitController.h"
#import "BusinessVisitCell.h"
#import "UserInforController.h"
#import "UnpaidModel.h"
#import "BusinessSummaryHeaderModel.h"


static NSString * cellId = @"BusinessVisitCell";
@interface BusinessVisitController ()

@end

@implementation BusinessVisitController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshViewType:BTVCType_AddTableView];
    [self drawUI];
//    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [BusinessVisitCell cellHeight];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessVisitCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[BusinessVisitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

   /* //展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;receivable:应收款;actualHarvest:实收款;arrears:欠款;
    UnpaidModel * model = self.dataArray[indexPath.row];
    [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":[NSString repleaseNilOrNull:model.type],@"phoneNumber":model.phone,@"content":model.content,@"receivable":model.receivable,@"actualHarvest":model.received,@"arrears":model.debt}];
    
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
        [self presentViewController:alertVc animated:YES completion:nil];
    };
    */
    [cell test];
    return cell;
}

-(void)drawUI{

    self.tableView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"type":[NSNumber numberWithInt:0]};
    NSDictionary * configurationDic = @{@"requestUrlStr":Payment,@"bodyParameters":bodyParameters};
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
                
                [weakSelf.dataArray removeAllObjects];
                if (code.integerValue == 1) {
                    
                    //成功
                    NSArray * arr = dataDic[@"list"];
                    for (NSDictionary * dic in arr) {
                        
                        UnpaidModel * model = [UnpaidModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                }
                else{
                }
                [weakSelf refreshViewType:BTVCType_RefreshTableView];
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
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
                    [weakSelf requestListData];
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
