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

static NSString * JobRecruitmentCellID = @"JobRecruitmentCell";

@interface JobRecruitmentViewController ()

//添加求职招聘按钮
@property (nonatomic,strong) UIButton * addBtn;

@end

@implementation JobRecruitmentViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _addBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    //    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 174;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.userInteractionEnabled = NO;
    JobRecruitmentDetailViewController * vc = [[JobRecruitmentDetailViewController alloc] initWithTitle:@"招聘详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
    tableView.userInteractionEnabled = NO;
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobRecruitmentCell * cell = [tableView dequeueReusableCellWithIdentifier:JobRecruitmentCellID];
    if (!cell) {
        
        cell = [[JobRecruitmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JobRecruitmentCellID];
    }
    
    [cell test];
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.offset(0);
        make.right.offset(-4);
        make.width.height.offset(44);
    }];
}

-(void)requestListData{
    return;
    /*
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Maintainlist,@"bodyParameters":bodyParameters};
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
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                        
                        NSArray * list = dataDic[@"list"];
                        for (NSDictionary * dic in list) {
                            
                            //                            MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
                            //                            for (MaintenanceRecordsModel * recordModel in model.list) {
                            //
                            //                                [weakSelf.dataArray addObject:recordModel];
                            //                            }
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
     */
}

@end
