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
#import "BusinessSummaryHeaderModel.h"
#import "ExampleModel.h"

static NSString * cellId = @"BusinessVisitCell";
@interface BusinessVisitController ()

@property (nonatomic,assign) NSUInteger page;

@end

@implementation BusinessVisitController

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
    
    return [BusinessVisitCell cellHeight];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessVisitCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[BusinessVisitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;
    ExampleModel * model = self.dataArray[indexPath.row];
    [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":[NSString repleaseNilOrNull:model.type],@"phoneNumber":model.phone,@"content":model.content}];
    
    __weak typeof(self) weakSelf = self;
    cell.btnClickCallBack = ^{
        
        [weakSelf sendVisitSmsWithExampleModel:model];
    };
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{

    self.tableView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"business_visit":[NSNumber numberWithInt:0],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    NSDictionary * configurationDic = @{@"requestUrlStr":BusinessVisit,@"bodyParameters":bodyParameters};
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
                    if (weakSelf.page == 1) {
                        
                        [weakSelf.dataArray removeAllObjects];
                    }
                    NSArray * arr = dataDic[@"list"];
                    if (arr.count == MAXCOUNT) {
                        
                        weakSelf.page++;
                    }
                    else{
                        
                        weakSelf.tableView.mj_footer = nil;
                    }
                    for (NSDictionary * dic in arr) {

                        ExampleModel * model = [ExampleModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                }
                else{
                    
                    [weakSelf.dataArray removeAllObjects];
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

//发送回访短信
-(void)sendVisitSmsWithExampleModel:(ExampleModel *)model{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"maintain_id":[NSString stringWithFormat:@"%ld",model.maintain_Id]};
    NSDictionary * configurationDic = @{@"requestUrlStr":SendVisitSms,@"bodyParameters":bodyParameters};
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
                }
                else{
                    
                    //异常
                    [MBProgressHUD wj_showError:dic[@"msg"]];
                }
                
                [weakSelf loadNewData];
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
