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

static NSString * CarProfitStatisticsCellId = @"CarProfitStatisticsCell";

@interface ProfitStatisticsViewController ()

//说明按钮
@property (nonatomic,strong) UIButton * explanationBtn;

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
    
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        
        static NSString * firstCellId = @"ProfitStatisticsCell";
        ProfitStatisticsCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[ProfitStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell test];
        return cell;
    }
    else{
        
        CarProfitStatisticsCell * cell = [tableView dequeueReusableCellWithIdentifier:CarProfitStatisticsCellId];
        if (!cell) {
            
            cell = [[CarProfitStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarProfitStatisticsCellId];
        }
        
        //linceNumber,车牌;contacts,联系人;profit,利润;arrears,欠款;acceptable,应收;maintenance,维修量
        [cell showWithDic:@{@"linceNumber":@"京A12345",@"contacts":@"联系人",@"profit":[NSNumber numberWithInt:1200],@"arrears":[NSNumber numberWithInt:100],@"acceptable":[NSNumber numberWithInt:200],@"maintenance":[NSNumber numberWithInt:10],}];
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



@end
