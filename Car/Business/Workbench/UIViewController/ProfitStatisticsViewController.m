//
//  ProfitStatisticsViewController.m
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ProfitStatisticsViewController.h"
#import "ProfitStatisticsCell.h"
#import "CarProfitStatisticsCell.h"
#import "UserInforController.h"
#import "ProfitstatisticsModel.h"
#import "ProfitrankingModel.h"


static NSString * CarProfitStatisticsCellId = @"CarProfitStatisticsCell";

@interface ProfitStatisticsViewController ()

//说明按钮
@property (nonatomic,strong) UIButton * explanationBtn;
@property (nonatomic,strong) ProfitstatisticsModel * profitstatisticsModel;

@end

@implementation ProfitStatisticsViewController

#pragma mark  ----  懒加载

-(UIButton *)explanationBtn{
    
    if (!_explanationBtn) {
        
        _explanationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_explanationBtn setImage:[UIImage imageNamed:@"shuoming"] forState:UIControlStateNormal];
        [_explanationBtn addTarget:self action:@selector(explanationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _explanationBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self profitstatistics:@"today"];
    [self profitranking];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0){
        
        cellHeight = 235;
    }
    else{
        
        cellHeight = 57;
    }
    
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        
        static NSString * firstCellId = @"ProfitStatisticsCell";
        ProfitStatisticsCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[ProfitStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            __weak typeof(self) weakSelf = self;
            cell.dateCallBack = ^(NSString * _Nonnull date) {
                
                [weakSelf profitstatistics:date];
            };
        }
        
        if (self.profitstatisticsModel) {

            [cell showData:self.profitstatisticsModel];
        }
        else{
            
            ProfitstatisticsModel * model = [[ProfitstatisticsModel alloc] init];
            model.profit = [NSNumber numberWithInt:0];
            model.receivable = [NSNumber numberWithInt:0];
            model.cost = [NSNumber numberWithInt:0];
            model.debt = [NSNumber numberWithInt:0];
            model.count = [NSNumber numberWithInt:0];
            [cell showData:model];
        }
        return cell;
    }
    else{
        
        CarProfitStatisticsCell * cell = [tableView dequeueReusableCellWithIdentifier:CarProfitStatisticsCellId];
        if (!cell) {
            
            cell = [[CarProfitStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarProfitStatisticsCellId];
        }
        
        ProfitrankingModel * model = self.dataArray[indexPath.row - 1];
        [cell showData:model];
        return cell;
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.explanationBtn];
    [self.explanationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.offset(22);
        make.right.offset(-13);
        make.bottom.offset(-12);
    }];
}

//说明按钮的响应
-(void)explanationBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
   
    
    btn.userInteractionEnabled = YES;
}

//利润统计接口
-(void)profitstatistics:(NSString *)str{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"day":str};
    NSDictionary * configurationDic = @{@"requestUrlStr":Profitstatistics,@"bodyParameters":bodyParameters};
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
                    NSDictionary * modelDic = dataDic[@"sum"];
                    ProfitstatisticsModel * profitstatisticsModel = [ProfitstatisticsModel mj_objectWithKeyValues:modelDic];
                    weakSelf.profitstatisticsModel = profitstatisticsModel;
                }
                else{
                    //异常
                }
                [weakSelf.tableView reloadData];
            }
            else{
            }
        }
        else{
            //失败的
        }
    }];
}

//利润排名接口
-(void)profitranking{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Profitranking,@"bodyParameters":bodyParameters};
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
                    NSArray * listArray = dataDic[@"list"];
                    if (listArray && [listArray isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary * dic in listArray) {
                            
                            ProfitrankingModel * profitrankingModel = [ProfitrankingModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:profitrankingModel];
                        }
                    }
                    [weakSelf.tableView reloadData];
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
