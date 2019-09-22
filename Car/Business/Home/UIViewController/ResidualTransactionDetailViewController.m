//
//  ResidualTransactionDetailViewController.m
//  Car
//
//  Created by xianjun wang on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionDetailViewController.h"
#import "SHImageAndTitleBtn.h"
#import "ResidualTransactionCarouseCell.h"

static NSString * ResidualTransactionCarouseCellID = @"ResidualTransactionCarouseCell";

@interface ResidualTransactionDetailViewController ()

//底部 view
@property (nonatomic,strong) UIView * bottomView;

@end

@implementation ResidualTransactionDetailViewController

#pragma mark  ----  懒加载

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        float collectBtnWidth = MAINWIDTH * 84.0 / 375.0;
        float phoneBtnWidth = MAINWIDTH - collectBtnWidth;
        UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_bottomView addSubview:collectBtn];
        
        [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.bottom.offset(0);
            make.width.offset(collectBtnWidth);
        }];
        [[collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.userInteractionEnabled = NO;
            x.selected = !x.selected;
            
            
            x.userInteractionEnabled = YES;
        }];
     
        SHImageAndTitleBtn * phoneBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(collectBtnWidth, 0, phoneBtnWidth, 50) andImageFrame:CGRectMake(113, 14, 22, 22) andTitleFrame:CGRectMake(143, 0, 40, 50) andImageName:@"dianhua" andSelectedImageName:@"" andTitle:@"电话" andTarget:nil andAction:nil];
        [phoneBtn refreshFont:BOLDFONT18];
        phoneBtn.backgroundColor = Color_38AC68;
        [phoneBtn refreshTitle:@"电话" color:[UIColor whiteColor]];
        [_bottomView addSubview:phoneBtn];
        [[phoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
            x.userInteractionEnabled = YES;
        }];
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
        
        cellHeight = [ResidualTransactionCarouseCell cellHeight];
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ResidualTransactionCarouseCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionCarouseCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionCarouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionCarouseCellID];
        }
        
        cell.backgroundColor = [UIColor greenColor];
        
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

-(void)requestListData{
    [self refreshViewType:BTVCType_RefreshTableView];
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
