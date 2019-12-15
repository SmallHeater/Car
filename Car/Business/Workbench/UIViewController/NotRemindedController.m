//
//  UnpaidViewController.m
//  Car
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "NotRemindedController.h"
#import "NotRemindedCell.h"
#import "UserInforController.h"
#import "UnpaidModel.h"
#import "BusinessSummaryHeaderModel.h"


static NSString * cellId = @"NotRemindedCell";
@interface NotRemindedController ()

@property (nonatomic,assign) NSUInteger page;

@end

@implementation NotRemindedController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshViewType:BTVCType_AddTableView];
    [self drawUI];
    self.page = 1;
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [NotRemindedCell cellHeight];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotRemindedCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[NotRemindedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;receivable:应收款;actualHarvest:实收款;arrears:欠款;
    UnpaidModel * model = self.dataArray[indexPath.row];
    [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":[NSString repleaseNilOrNull:model.type],@"phoneNumber":model.phone,@"lastMaintenanceContent":model.content,@"lastMaintenanceTime":model.createtime}];
    __weak typeof(self) weakSelf = self;
    cell.btnClickCallBack = ^{
        
        [weakSelf payBackWithMaintainId:model.car_id];
    };

//    [cell test];
    return cell;
}

-(void)drawUI{

    self.tableView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"recommended":[NSNumber numberWithInt:0],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    NSDictionary * configurationDic = @{@"requestUrlStr":MaintainRecommend,@"bodyParameters":bodyParameters};
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
                
                if (weakSelf.page == 1) {
                    
                    [weakSelf.dataArray removeAllObjects];
                }
                
                if (code.integerValue == 1) {
                    
                    //成功
                    NSArray * arr = dataDic[@"list"];
                    if (arr.count == MAXCOUNT) {
                        
                        weakSelf.page++;
                    }
                    else{
                        
                        weakSelf.tableView.mj_footer = nil;
                    }
                    
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

//发送保养推荐短信
-(void)payBackWithMaintainId:(NSString *)maintain_id{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"maintain_id":maintain_id};
    NSDictionary * configurationDic = @{@"requestUrlStr":SendRecommendSms,@"bodyParameters":bodyParameters};
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
                    
                    //成功
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    weakSelf.page = 1;
                    [weakSelf requestListData];
                }
                else{
                    
                    //异常
//                    [MBProgressHUD wj_showError:dic[@"msg"]];
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
