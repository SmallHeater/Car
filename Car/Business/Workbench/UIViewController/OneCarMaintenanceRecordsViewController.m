//
//  OneCarMaintenanceRecordsViewController.m
//  Car
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "OneCarMaintenanceRecordsViewController.h"
#import "MaintenanceRecordsCell.h"
#import "UserInforController.h"
#import "MaintenanceRecordsOneDayModel.h"
#import "MaintenanceRecordsDetailViewController.h"
#import "VehicleFileModel.h"

static NSString * cellId = @"MaintenanceRecordsCell";

@interface OneCarMaintenanceRecordsViewController ()

//添加按钮
@property (nonatomic,strong) UIButton * addBtn;
@property (nonatomic,assign) NSUInteger page;

@end

@implementation OneCarMaintenanceRecordsViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
            MaintenanceRecordsDetailViewController * vc = [[MaintenanceRecordsDetailViewController alloc] initWithTitle:@"维修记录详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
            vc.vehicleFileModel = weakSelf.vehicleFileModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            x.userInteractionEnabled = YES;
        }];
    }
    return _addBtn;
}

-(void)setVehicleFileModel:(VehicleFileModel *)vehicleFileModel{
    
    if (vehicleFileModel) {
        
        _vehicleFileModel = vehicleFileModel;
    }
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self drawUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section];
    MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
    float cellHeight = [MaintenanceRecordsCell cellHeightWithContent:recordModel.content];
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[section];
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, MAINWIDTH,32)];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.font = BOLDFONT16;
    headerLabel.textColor = Color_333333;
    headerLabel.text = [[NSString alloc] initWithFormat:@"      %@",model.day];
    [headerView addSubview:headerLabel];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section];
    MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
    MaintenanceRecordsDetailViewController * vc = [[MaintenanceRecordsDetailViewController alloc] initWithTitle:@"维修记录详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
    vc.maintenanceRecordsModel = recordModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger count = 0;
    if (self.dataArray && self.dataArray.count > 0) {
        
        MaintenanceRecordsOneDayModel * model = self.dataArray[section];
        count = model.list.count;
    }
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceRecordsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[MaintenanceRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section];
    MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
    
    [cell showDataWithDic:@{@"numberPlate":recordModel.license_number,@"name":recordModel.contacts,@"carModel":[NSString repleaseNilOrNull:recordModel.type],@"phoneNumber":recordModel.phone,@"MaintenanceContent":recordModel.content}];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
}


-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"car_id":self.vehicleFileModel.car_id,@"page":[NSString stringWithFormat:@"%ld",self.page]};
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
                            
                            MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
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
