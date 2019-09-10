//
//  UnpaidViewController.m
//  Car
//
//  Created by mac on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RepaidViewController.h"
#import "RepaidCell.h"
#import "UserInforController.h"
#import "RepaidModel.h"

static NSString * cellId = @"RepaidCell";
@interface RepaidViewController ()

@end

@implementation RepaidViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshViewType:BTVCType_AddTableView];
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [RepaidCell cellHeight];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RepaidCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[RepaidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell test];
    
    return cell;
}

#pragma mark  ----  自定义函数
-(void)drawUI{
    
    self.tableView.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [UIScreenControl navigationBarHeight] - 44 - [UIScreenControl bottomSafeHeight]);
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"type":[NSNumber numberWithInt:1]};
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
                
                if (code.integerValue == 1) {
                    
                    //成功
                    NSArray * arr = dataDic[@"list"];
                    for (NSDictionary * dic in arr) {
                        
                        RepaidModel * model = [RepaidModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                    [weakSelf refreshViewType:BTVCType_RefreshTableView];
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

@end
