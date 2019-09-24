//
//  JobRecruitmentDetailViewController.m
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobRecruitmentDetailViewController.h"
#import "DetailBottomView.h"
#import "JobRecruitmentWorkTypeCell.h"
#import "JobRecruitmenDescriptionCell.h"
#import "ResidualTransactionMerchantCell.h"
#import "ResidualTransactionComplaintCell.h"


static NSString * JobRecruitmentWorkTypeCellID = @"JobRecruitmentWorkTypeCell";
static NSString * JobRecruitmenDescriptionCellID = @"JobRecruitmenDescriptionCell";
static NSString * ResidualTransactionMerchantCellID = @"ResidualTransactionMerchantCell";
static NSString * ResidualTransactionComplaintCellID = @"ResidualTransactionComplaintCell";

@interface JobRecruitmentDetailViewController ()

//底部 view
@property (nonatomic,strong) DetailBottomView * bottomView;

@end

@implementation JobRecruitmentDetailViewController

#pragma mark  ----  懒加载

-(DetailBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[DetailBottomView alloc] init];
    }
    return _bottomView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 165;
    }
    else if (indexPath.row == 1){
        
        cellHeight = 333;
    }
    else if (indexPath.row == 2){
        
        cellHeight = 108;
    }
    else if (indexPath.row == 3){
        
        cellHeight = 80;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        JobRecruitmentWorkTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:JobRecruitmentWorkTypeCellID];
        if (!cell) {
            
            cell = [[JobRecruitmentWorkTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JobRecruitmentWorkTypeCellID];
        }
        
        [cell test];
        return cell;
    }
    else if (indexPath.row == 1){
        
        JobRecruitmenDescriptionCell * cell = [tableView dequeueReusableCellWithIdentifier:JobRecruitmenDescriptionCellID];
        if (!cell) {
            
            cell = [[JobRecruitmenDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JobRecruitmenDescriptionCellID];
        }
        
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        ResidualTransactionMerchantCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionMerchantCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionMerchantCellID];
        }
        
        [cell test];
        
        return cell;
    }
    else if (indexPath.row == 3){
        
        ResidualTransactionComplaintCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionComplaintCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionComplaintCellID];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.bottom.offset(-50 - [UIScreenControl bottomSafeHeight]);
    }];
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.bottom.offset(-[UIScreenControl bottomSafeHeight]);
        make.height.offset(50);
    }];
}

@end
