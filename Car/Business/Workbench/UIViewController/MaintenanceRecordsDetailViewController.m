//
//  MaintenanceRecordsDetailViewController.m
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MaintenanceRecordsDetailViewController.h"
#import "VehicleFileForDetailVCCell.h"
#import "MaintenanceLogCell.h"
#import "VehicleFileModel.h"
#import "MaintenanceDetailModel.h"
#import "MaintenanceRecordsModel.h"


typedef NS_ENUM(NSUInteger,ViewState){
    
    ViewState_show = 0,//显示状态
    ViewState_edit //编辑状态
};

@interface MaintenanceRecordsDetailViewController ()

@property (nonatomic,assign) ViewState viewState;
//编辑按钮
@property (nonatomic,strong) UIButton * editBtn;
//底部删除，保存按钮view
@property (nonatomic,strong) UIView * bottomView;
//提交的维修详情模型
@property (nonatomic,strong) MaintenanceDetailModel * detailModel;
//提交请求的MBP
@property (nonatomic,strong) MBProgressHUD * mbp;

@end

@implementation MaintenanceRecordsDetailViewController

#pragma mark  ----  懒加载

-(UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_editBtn setTitle:@"取消" forState:UIControlStateSelected];
        _editBtn.titleLabel.font = FONT14;
        [_editBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
//        [_editBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.userInteractionEnabled = YES;
        
        //添加时不显示删除
        float buttonWidth = MAINWIDTH;
        if (self.maintenanceRecordsModel) {
            
            //删除按钮
            UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setBackgroundColor:Color_F23E3E];
            deleteBtn.titleLabel.font = FONT16;
            [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
            [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:deleteBtn];
            
            buttonWidth = MAINWIDTH / 2;
            [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.top.bottom.offset(0);
                make.width.offset(buttonWidth);
            }];
        }
        
        //保存按钮
        UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setBackgroundColor:Color_0072FF];
        saveBtn.titleLabel.font = FONT16;
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:saveBtn];
        
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.top.bottom.offset(0);
            make.width.offset(buttonWidth);
        }];
    }
    return _bottomView;
}

-(void)setVehicleFileModel:(VehicleFileModel *)vehicleFileModel{
    
    if (vehicleFileModel) {
        
        _vehicleFileModel = vehicleFileModel;
        self.detailModel = [[MaintenanceDetailModel alloc] init];
        self.detailModel.user_id = vehicleFileModel.user_id;
        self.detailModel.car_id = vehicleFileModel.car_id;
        self.viewState = ViewState_edit;
    }
}

-(void)setMaintenanceRecordsModel:(MaintenanceRecordsModel *)maintenanceRecordsModel{
    
    if (maintenanceRecordsModel) {
     
        _maintenanceRecordsModel = maintenanceRecordsModel;
        NSDictionary * dic = [maintenanceRecordsModel mj_keyValues];
        self.detailModel = [MaintenanceDetailModel mj_objectWithKeyValues:dic];
        self.viewState = ViewState_show;
    }
}

#pragma mark  ----  生命周期函数

-(void)viewDidLoad{
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    [self registrationNotice];
    [self addReceivingKeyboard];
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0){
        
        cellHeight = [VehicleFileForDetailVCCell cellHeight];
    }
    else{
        
        if (self.maintenanceRecordsModel) {
            
            cellHeight = [MaintenanceLogCell cellHeightWithContent:self.maintenanceRecordsModel.content];
        }
        else{
            
            //默认显示三行内容，51个字
            cellHeight = [MaintenanceLogCell cellHeightWithContent:@"维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测试"];
        }
    }
    
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        
        static NSString * firstCellId = @"VehicleFileForDetailVCCell";
        VehicleFileForDetailVCCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[VehicleFileForDetailVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
        }
    
        if (self.vehicleFileModel) {
         
            [cell showDataWithDic:@{@"numberPlate":self.vehicleFileModel.license_number,@"name":self.vehicleFileModel.contacts,@"carModel":[NSString repleaseNilOrNull:self.vehicleFileModel.type],@"phoneNumber":self.vehicleFileModel.phone}];
        }
        else if (self.maintenanceRecordsModel){
            
            [cell showDataWithDic:@{@"numberPlate":self.maintenanceRecordsModel.license_number,@"name":self.maintenanceRecordsModel.contacts,@"carModel":[NSString repleaseNilOrNull:self.maintenanceRecordsModel.type],@"phoneNumber":self.maintenanceRecordsModel.phone}];
        }
        
        cell.userInteractionEnabled = self.viewState == ViewState_show?NO:YES;
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellId = @"MaintenanceLogCell";
        MaintenanceLogCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[MaintenanceLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
            
            __weak typeof(self) weakSelf = self;
            cell.repairDateCallBack = ^(NSString * _Nonnull content) {
              
                weakSelf.detailModel.maintain_day = content;
            };
            cell.kmCallBack = ^(float value) {
              
                weakSelf.detailModel.mileage = [NSNumber numberWithFloat:value];
            };
            
            cell.projectCallBack = ^(float value) {
              
                weakSelf.detailModel.related_service = [NSNumber numberWithFloat:value];
            };
            
            cell.acceptableCallBack = ^(float value) {
                
                weakSelf.detailModel.receivable = [NSNumber numberWithFloat:value];
            };
            
            cell.receivedCallBack = ^(float value) {
              
                weakSelf.detailModel.received = [NSNumber numberWithFloat:value];
            };
            
            cell.costCallBack = ^(float value) {
              
                weakSelf.detailModel.cost = [NSNumber numberWithFloat:value];
            };
            
            cell.contentCallBack = ^(NSString * _Nonnull content) {
              
                weakSelf.detailModel.content = content;
            };
            
            cell.deleteImageUrlCallBack = ^(NSString * _Nonnull content) {
              
                NSArray * array = [weakSelf.detailModel.images componentsSeparatedByString:@","];
                NSMutableArray * imagesUrlArray = [[NSMutableArray alloc] initWithArray:array];
                [imagesUrlArray removeObject:content];
                weakSelf.detailModel.images = [imagesUrlArray componentsJoinedByString:@","];
            };
        }
        
        if (self.maintenanceRecordsModel) {
         
            //关联项目
            
            NSString * associatedProject;
            if (self.maintenanceRecordsModel.related_service.integerValue == 0) {
                
                associatedProject = @"保养";
            }
            else if (self.maintenanceRecordsModel.related_service.integerValue == 1){
                
                associatedProject = @"维修";
            }
            else if (self.maintenanceRecordsModel.related_service.integerValue == 2){
                
                associatedProject = @"美容洗车";
            }
            
            NSString * acceptable = [[NSString alloc] initWithFormat:@"%.2f",self.maintenanceRecordsModel.receivable.floatValue];
            NSString * received = [[NSString alloc] initWithFormat:@"%.2f",self.maintenanceRecordsModel.received.floatValue];
            NSString * cost = [[NSString alloc] initWithFormat:@"%.2f",self.maintenanceRecordsModel.cost.floatValue];
            [cell showData:@{@"repairDate":self.maintenanceRecordsModel.maintain_day,@"kilometers":[[NSString alloc] initWithFormat:@"%ld",self.maintenanceRecordsModel.mileage.integerValue],@"associatedProject":associatedProject,@"repairContent":self.maintenanceRecordsModel.content,@"acceptable":acceptable,@"received":received,@"cost":cost,@"images":[NSString repleaseNilOrNull:self.maintenanceRecordsModel.images]}];

        }
        cell.userInteractionEnabled = self.viewState == ViewState_show?NO:YES;
        return cell;
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    float tableViewBottom = 0;
    if (self.viewState == ViewState_edit) {
        
        self.bottomView.hidden = NO;
        tableViewBottom = 44;
    }
    else if (self.viewState == ViewState_show){
        
        [self.navigationbar addSubview:self.editBtn];
        NSUInteger editBtnWidth = 44;
        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.offset(editBtnWidth);
            make.right.offset(-13);
            make.bottom.offset(0);
        }];
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.offset(-tableViewBottom);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.bottom.offset(0);
        make.height.offset(44);
    }];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(-rect.size.height);
        }];
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        
        float bottomHeight = weakSelf.bottomView.isHidden?0:44;
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(-bottomHeight);
        }];
    }];
}

//给view设置收键盘
-(void)addReceivingKeyboard{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapClicked{
    
    [self.view endEditing:YES];
}

//编辑按钮的响应
-(void)editBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.selected = !btn.selected;
    
    if (self.viewState == ViewState_show) {
        
        self.viewState = ViewState_edit;
        self.bottomView.hidden = NO;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.left.right.offset(0);
            make.bottom.offset(-44);
        }];
    }
    else if (self.viewState == ViewState_edit){
        
        self.viewState = ViewState_show;
        self.bottomView.hidden = YES;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.left.right.offset(0);
            make.bottom.offset(0);
        }];
    }
    [self.tableView reloadData];
    btn.userInteractionEnabled = YES;
}

//删除按钮的响应
-(void)deleteBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    if (self.maintenanceRecordsModel && self.detailModel) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"删除车辆维修记录警告" message:@"是否要删除车辆维修记录？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf deleteMaintenanceRecords];
        }];
        
        [alert addAction:cancleAction];
        [alert addAction:sureAction];
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    btn.userInteractionEnabled = YES;
}

//保存按钮的响应
-(void)saveBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    if ([NSString strIsEmpty:self.detailModel.maintain_day]) {
        
        [MBProgressHUD wj_showError:@"请选择维修日期"];
    }
    else if (!self.detailModel.mileage){
        
        [MBProgressHUD wj_showError:@"请输入公里数"];
    }
    else if (!self.detailModel.related_service){
        
        [MBProgressHUD wj_showError:@"请选择关联项目"];
    }
    else if (!self.detailModel.receivable){
        
        [MBProgressHUD wj_showError:@"请输入应收金额"];
    }
    else if (!self.detailModel.received){
        
        [MBProgressHUD wj_showError:@"请输入实收金额"];
    }else if (!self.detailModel.cost){
        
        [MBProgressHUD wj_showError:@"请输入成本"];
    }else if ([NSString strIsEmpty:self.detailModel.content]){
        
        [MBProgressHUD wj_showError:@"请输入维修内容"];
    }
    else{
    
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
        });
        
        MaintenanceLogCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.imageUrlCallBack = ^(NSString * _Nonnull content) {
            
            if (![NSString strIsEmpty:content]) {
                
                weakSelf.detailModel.images = content;
            }
            [weakSelf addMaintenanceRecords];
        };
        [cell startUploadImages];
    }
    
    btn.userInteractionEnabled = YES;
}

//添加维修记录
-(void)addMaintenanceRecords{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary * tempBodyParameters = [self.detailModel  mj_keyValues];
    NSMutableDictionary * bodyParameters = [[NSMutableDictionary alloc] initWithDictionary:tempBodyParameters];
    if ([tempBodyParameters.allKeys containsObject:@"id"]) {
     
        [bodyParameters setObject:tempBodyParameters[@"id"] forKey:@"maintain_id"];
        [bodyParameters removeObjectForKey:@"id"];
    }
    
    NSDictionary * configurationDic = @{@"requestUrlStr":Maintainadd,@"bodyParameters":bodyParameters};
    
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.mbp hide:YES];
            weakSelf.mbp = nil;
        });
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [weakSelf backBtnClicked:nil];
                    });
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

//删除维修记录
-(void)deleteMaintenanceRecords{
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
    });
    NSDictionary * bodyParameters = @{@"user_id":self.detailModel.user_id,@"maintain_id":self.detailModel.maintain_id};
    NSDictionary * configurationDic = @{@"requestUrlStr":Maintaindelete,@"bodyParameters":bodyParameters};
    
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.mbp hide:YES];
            weakSelf.mbp = nil;
        });
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [weakSelf backBtnClicked:nil];
                    });
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
