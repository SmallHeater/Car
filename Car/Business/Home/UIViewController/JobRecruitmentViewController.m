//
//  JobRecruitmentViewController.m
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobRecruitmentViewController.h"
#import "JobRecruitmentCell.h"
#import "JobRecruitmentDetailViewController.h"
#import "UserInforController.h"
#import "JobModel.h"
#import "PostJobViewController.h"

static NSString * JobRecruitmentCellID = @"JobRecruitmentCell";

@interface JobRecruitmentViewController ()

//添加求职招聘按钮
@property (nonatomic,strong) UIButton * addBtn;
//招聘参数字典
@property (nonatomic,strong) NSDictionary * jobOptionDic;

@property (nonatomic,assign) NSUInteger page;

@end

@implementation JobRecruitmentViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            PostJobViewController * vc = [[PostJobViewController alloc] initWithTitle:@"发布招聘信息" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _addBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    self.page = 1;
    [self requestJobOption];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 174;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.userInteractionEnabled = NO;
    JobModel * model = self.dataArray[indexPath.row];
    JobRecruitmentDetailViewController * vc = [[JobRecruitmentDetailViewController alloc] initWithTitle:@"招聘详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andJobOptionDic:self.jobOptionDic andJobModel:model];
    [self.navigationController pushViewController:vc animated:YES];
    tableView.userInteractionEnabled = YES;
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobRecruitmentCell * cell = [tableView dequeueReusableCellWithIdentifier:JobRecruitmentCellID];
    if (!cell) {
        
        cell = [[JobRecruitmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JobRecruitmentCellID];
    }
    
    if (self.jobOptionDic && self.dataArray.count > 0) {
        
        JobModel * model = self.dataArray[indexPath.row];
        //title,标题;recommend,推荐;wage,工资;workType,工作类型;company,公司;address,位置;tabs,标签数组;
        NSString * workType;
        NSArray * workTypeArray = self.jobOptionDic[@"job"];
        for (NSDictionary * dic in workTypeArray) {
            
            NSNumber * number = dic[@"id"];
            if (number.integerValue == model.job_id.integerValue) {
                
                workType = dic[@"name"];
                break;
            }
        }
        
        NSString * wage = [[NSString alloc] initWithFormat:@"%@/月",[NSString repleaseNilOrNull:model.monthly_salary]];
        
        NSString * address;
        NSArray * addressArray = self.jobOptionDic[@"workplace"];
        for (NSDictionary * dic in addressArray) {
            
            NSNumber * number = dic[@"id"];
            if (number.integerValue == model.workplace_id.integerValue) {
                
                address = dic[@"name"];
                break;
            }
        }
        
        
        NSMutableArray * tabsArray = [[NSMutableArray alloc] init];
        for (NSDictionary * dic in model.benefits) {
            
            [tabsArray addObject:dic[@"name"]];
        }
        
        [cell showDic:@{@"title":[NSString repleaseNilOrNull:model.name],@"recommend":@"推荐",@"wage":wage,@"workType":workType,@"company":[NSString repleaseNilOrNull:model.shop_name],@"address":address,@"tabs":tabsArray}];
    }
    
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
//    [self.navigationbar addSubview:self.addBtn];
//    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.bottom.offset(0);
//        make.right.offset(-4);
//        make.width.height.offset(44);
//    }];
}

-(void)requestJobOption{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":JobOption,@"bodyParameters":bodyParameters};
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
                    
                    NSDictionary * dataDic = dic[@"data"];
                    weakSelf.jobOptionDic = dataDic;
                    [weakSelf requestListData];
                }
                else{
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

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"page":[NSString stringWithFormat:@"%ld",self.page]};
    NSDictionary * configurationDic = @{@"requestUrlStr":JobList,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                [weakSelf.dataArray removeAllObjects];
                if (code.integerValue == 1) {
                    
                    NSDictionary * dataDic = dic[@"data"];
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                        
                        if (weakSelf.page == 1) {
                            
                            [weakSelf.dataArray removeAllObjects];
                        }
                        NSArray * list = dataDic[@"list"];
                        
                        if (list.count == MAXCOUNT) {
                            
                            weakSelf.page++;
                        }
                        else if (list.count == 0){
                            
                            [MBProgressHUD wj_showError:@"没有更多数据啦"];
                            weakSelf.tableView.mj_footer = nil;
                        }
                        else{
                            
                            weakSelf.tableView.mj_footer = nil;
                        }
                        for (NSDictionary * dic in list) {
                            
                            JobModel * model = [JobModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                    
                    [weakSelf refreshViewType:BTVCType_RefreshTableView];
                }
                else{
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
