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

@end

@implementation OneCarMaintenanceRecordsViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(void)setVehicleFileModel:(VehicleFileModel *)vehicleFileModel{
    
    if (vehicleFileModel) {
        
        _vehicleFileModel = vehicleFileModel;
        [self requestListData];
    }
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
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
    MaintenanceRecordsDetailViewController * vc = [[MaintenanceRecordsDetailViewController alloc] initWithTitle:@"维修记录详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    vc.maintenanceRecordsModel = recordModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[section];
    return model.list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceRecordsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[MaintenanceRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MaintenanceRecordsOneDayModel * model = self.dataArray[indexPath.section];
    MaintenanceRecordsModel * recordModel = model.list[indexPath.row];
    
    [cell showDataWithDic:@{@"numberPlate":recordModel.license_number,@"name":recordModel.contacts,@"carModel":recordModel.type,@"phoneNumber":recordModel.phone,@"MaintenanceContent":recordModel.content}];
    
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

-(void)addBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    MaintenanceRecordsDetailViewController * vc = [[MaintenanceRecordsDetailViewController alloc] initWithTitle:@"维修记录详情" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    vc.vehicleFileModel = self.vehicleFileModel;
    [self.navigationController pushViewController:vc animated:YES];
    
    btn.userInteractionEnabled = YES;
}

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"car_id":self.vehicleFileModel.car_id};
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
                            
                            MaintenanceRecordsOneDayModel * model = [MaintenanceRecordsOneDayModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                    [weakSelf refreshViewType:BTVCType_RefreshTableView];
                }
                else{
                    
                    [MBProgressHUD wj_showError:dic[@"msg"]];
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
