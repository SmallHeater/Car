//
//  OilPurchaseRecordViewController.m
//  Car
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "OilPurchaseRecordViewController.h"
#import "UserInforController.h"
#import "OilPurchaseRecord.h"
#import "OilPurchaseRecordCell.h"

static NSString * cellId = @"OilPurchaseRecordCell";

@interface OilPurchaseRecordViewController ()

@end

@implementation OilPurchaseRecordViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OilPurchaseRecord * model = self.dataArray[indexPath.row];
    float cellHeight = [OilPurchaseRecordCell cellHeightWithModel:model];
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OilPurchaseRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[OilPurchaseRecordCell alloc] initWithReuseIdentifier:cellId];
    }
    
    OilPurchaseRecord * model = self.dataArray[indexPath.row];
    [cell show:model];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)requestListData{
    
    //发起请求
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetOrders,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    
                    NSArray * list = dataDic[@"list"];
                    if (list && [list isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary * dic in list) {
                            
                            OilPurchaseRecord * model = [OilPurchaseRecord mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                }
            }
            else{
            }
            [weakSelf.tableView reloadData];
        }
        else{
            
            //失败的
        }
    }];
}

@end
