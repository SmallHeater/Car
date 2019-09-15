//
//  BusinessSummaryViewController.m
//  Car
//
//  Created by mac on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "BusinessSummaryViewController.h"
#import "UserInforController.h"
#import "BusinessSummaryHeaderModel.h"
#import "BusinessSummaryItemModel.h"
#import "SummaryAnalysisCell.h"
#import "SummaryItemCell.h"

@interface BusinessSummaryViewController ()

@property (nonatomic,strong) NSArray * headStrArray;
@property (nonatomic,strong) BusinessSummaryHeaderModel * headerModel;

@end

@implementation BusinessSummaryViewController

#pragma mark  ----  懒加载

-(NSArray *)headStrArray{
    
    if (!_headStrArray) {
        
        _headStrArray = [[NSArray alloc] initWithObjects:@"月份",@"应收",@"成本",@"欠款",@"利润",@"新客",@"维修", nil];
    }
    return _headStrArray;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.section == 0) {
        
        cellHeight = 260;
    }
    else{
        
        cellHeight = 44;
    }
    
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headHeight = 0;
    if (section == 1) {
        
        headHeight = 44;
    }
    return headHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 44)];
    
    float viewX = 16;
    float viewWidth = (MAINWIDTH - 16 * 2) / 7;
    for (NSUInteger i = 0; i < 7; i++) {
        
        UILabel * label = [[UILabel alloc] init];
        label.font =FONT14;
        label.textColor = Color_999999;
        label.text = self.headStrArray[i];
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(viewX);
            make.top.bottom.offset(0);
            make.width.offset(viewWidth);
        }];
        
        viewX += viewWidth;
    }
    return headerView;
}

#pragma mark  ----  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSUInteger section = 0;
    if (self.headerModel) {
        
        section = 2;
    }
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if (section == 0) {
        
        
        rows = self.headerModel?1:0;
    }
    else{
        
        rows = self.dataArray.count;
    }
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString * cellId = @"SummaryAnalysisCell";
        SummaryAnalysisCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            
            cell = [[SummaryAnalysisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        if (self.headerModel) {
         
            [cell show:self.headerModel arr:self.dataArray];
        }
        
        return cell;
    }
    else{
        
        static NSString * otherCellId = @"SummaryItemCell";
        SummaryItemCell * cell = [tableView dequeueReusableCellWithIdentifier:otherCellId];
        if (!cell) {
            
            cell = [[SummaryItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellId];
        }
        
        BusinessSummaryItemModel * itemModel = self.dataArray[indexPath.row];
        [cell show:itemModel];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Businesssummarytop,@"bodyParameters":bodyParameters};
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
                    NSDictionary * sumDic = dataDic[@"sum"];
                    self.headerModel = [BusinessSummaryHeaderModel mj_objectWithKeyValues:sumDic];
                    NSArray * list = dataDic[@"list"];
                    for (NSDictionary * dic in list) {
                        
                        BusinessSummaryItemModel * itemModel = [BusinessSummaryItemModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray addObject:itemModel];
                    }
                    [weakSelf refreshViewType:BTVCType_RefreshTableView];
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
