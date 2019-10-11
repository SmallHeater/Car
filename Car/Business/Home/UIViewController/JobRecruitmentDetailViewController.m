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
@property (nonatomic,strong) NSDictionary * jobOptionDic;
@property (nonatomic,strong) JobModel * jobModel;

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

//招聘参数字典,jobOptionDic;招聘信息模型，jobModel;
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andJobOptionDic:(NSDictionary *)JobOptionDic andJobModel:(JobModel *)jobModel{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.jobOptionDic = JobOptionDic;
        self.jobModel = jobModel;
    }
    return self;
}

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
        
        cellHeight = [JobRecruitmenDescriptionCell cellHeightWithContent:self.jobModel.jobDescription];
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
        
        if (self.jobOptionDic && self.jobModel) {
            
            //title,标题;wage,工资;workType,工作类型;tabs,标签数组;
            NSString * workType;
            NSArray * workTypeArray = self.jobOptionDic[@"job"];
            for (NSDictionary * dic in workTypeArray) {
                
                NSNumber * number = dic[@"id"];
                if (number.integerValue == self.jobModel.job_id.integerValue) {
                    
                    workType = dic[@"name"];
                    break;
                }
            }
            
            NSString * wage = [[NSString alloc] initWithFormat:@"%@/月",[NSString repleaseNilOrNull:self.jobModel.monthly_salary]];
            NSMutableArray * tabsArray = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in self.jobModel.benefits) {
                
                [tabsArray addObject:dic[@"name"]];
            }
            
            [cell showDic:@{@"title":[NSString repleaseNilOrNull:self.jobModel.name],@"wage":wage,@"workType":workType,@"tabs":tabsArray}];
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        JobRecruitmenDescriptionCell * cell = [tableView dequeueReusableCellWithIdentifier:JobRecruitmenDescriptionCellID];
        if (!cell) {
            
            cell = [[JobRecruitmenDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JobRecruitmenDescriptionCellID];
        }
        
        if (self.jobOptionDic && self.jobModel) {
            
            NSArray * educationArray = self.jobOptionDic[@"education"];
            NSString * educationStr;
            for (NSDictionary * dic in educationArray) {
                
                NSNumber * number = dic[@"id"];
                if (number.integerValue == self.jobModel.education_id.integerValue) {
                    
                    NSString * tempStr = dic[@"name"];
                    if ([tempStr isEqualToString:@"不限"]) {
                     
                        educationStr = @"学历不限";
                    }
                    else{
                        
                        educationStr = tempStr;
                    }
                    break;
                }
            }
            
            NSArray * experienceArray = self.jobOptionDic[@"experience"];
            NSString * experienceStr;
            for (NSDictionary * dic in experienceArray) {
                
                NSNumber * number = dic[@"id"];
                if (number.integerValue == self.jobModel.experience_id.integerValue) {
                    
                    NSString * tempStr = dic[@"name"];
                    if ([tempStr isEqualToString:@"不限"]) {
                        
                        experienceStr = @"经验不限";
                    }
                    else{
                        
                        experienceStr = tempStr;
                    }
                    break;
                }
            }
            
            [cell showWorkExperienceRequirements:experienceStr academicRequirements:educationStr content:self.jobModel.jobDescription];
        }
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        ResidualTransactionMerchantCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionMerchantCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionMerchantCellID];
        }
        
        if (self.jobModel) {
        
            //shop_avatar,图片;shop_name,名;shop_phone,号码;shop_credit,信用;
            [cell showDic:@{@"shop_avatar":self.jobModel.shop_avatar,@"shop_name":self.jobModel.shop_name,@"shop_phone":self.jobModel.shop_phone,@"shop_credit":self.jobModel.shop_credit}];
        }
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
