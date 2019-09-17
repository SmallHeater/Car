//
//  VehicleFileDetailViewController.m
//  Car
//
//  Created by xianjun wang on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleFileDetailViewController.h"
#import "VehicleInformationCell.h"
#import "DriverInformationCell.h"
#import "OneCarMaintenanceRecordsViewController.h"
#import "VehicleFileModel.h"
#import "ModifyVehicleFileRequestModel.h"
#import "UserInforController.h"

typedef NS_ENUM(NSUInteger,ViewState){
    
    ViewState_show = 0,//显示状态
    ViewState_edit //编辑状态
};

@interface VehicleFileDetailViewController ()

@property (nonatomic,assign) ViewState viewState;
//编辑按钮
@property (nonatomic,strong) UIButton * editBtn;
//白条
@property (nonatomic,strong) UIView * whiteView;
//底部维修记录按钮
@property (nonatomic,strong) UIView * maintenanceRecordsView;
//维修记录label
@property (nonatomic,strong) UILabel * maintenanceRecordsLabel;
//底部删除，保存按钮view
@property (nonatomic,strong) UIView * bottomView;
//修改请求模型
@property (nonatomic,strong) ModifyVehicleFileRequestModel * requestModel;
//提交请求的MBP
@property (nonatomic,strong) MBProgressHUD * mbp;
@end

@implementation VehicleFileDetailViewController

#pragma mark  ----  懒加载

-(UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_editBtn setTitle:@"取消" forState:UIControlStateSelected];
        _editBtn.titleLabel.font = FONT14;
        [_editBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            x.selected = !x.selected;
            
            if (weakSelf.viewState == ViewState_show) {
                
                weakSelf.viewState = ViewState_edit;
                weakSelf.maintenanceRecordsView.hidden = YES;
                weakSelf.bottomView.hidden = NO;
            }
            else if (weakSelf.viewState == ViewState_edit){
                
                weakSelf.viewState = ViewState_show;
                weakSelf.maintenanceRecordsView.hidden = NO;
                weakSelf.bottomView.hidden = YES;
            }
            
            x.userInteractionEnabled = YES;
        }];
    }
    return _editBtn;
}

-(UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

-(UIView *)maintenanceRecordsView{
    
    if (!_maintenanceRecordsView) {
        
        _maintenanceRecordsView = [[UIView alloc] init];
        _maintenanceRecordsView.backgroundColor = [UIColor whiteColor];
        //阴影
        _maintenanceRecordsView.layer.shadowColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:0.23].CGColor;
        _maintenanceRecordsView.layer.shadowOffset = CGSizeMake(0,-1);
        _maintenanceRecordsView.layer.shadowOpacity = 1;
        _maintenanceRecordsView.layer.shadowRadius = 8;
        
        self.maintenanceRecordsLabel = [[UILabel alloc] init];
        self.maintenanceRecordsLabel.font = FONT16;
        self.maintenanceRecordsLabel.textColor = Color_0072FF;
        self.maintenanceRecordsLabel.textAlignment = NSTextAlignmentRight;
        
        [_maintenanceRecordsView addSubview:self.maintenanceRecordsLabel];
        [self.maintenanceRecordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(131);
            make.top.offset(17);
            make.height.offset(16);
            make.width.offset(100);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiayibu"]];
        [_maintenanceRecordsView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.maintenanceRecordsLabel.mas_right).offset(6);
            make.top.offset(14);
            make.width.height.offset(22);
        }];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        __weak typeof(self) weakSelf = self;
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
           
            OneCarMaintenanceRecordsViewController * vc = [[OneCarMaintenanceRecordsViewController alloc] initWithTitle:@"维修记录" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
            vc.vehicleFileModel = weakSelf.vehicleFileModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [_maintenanceRecordsView addGestureRecognizer:tap];
    }
    return _maintenanceRecordsView;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.hidden = YES;
        
        //删除按钮
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundColor:Color_F23E3E];
        deleteBtn.titleLabel.font = FONT16;
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [[deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"删除车辆档案警告" message:@"是否要删除车辆档案？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf deleteModifyVehicleFile];
            }];
            
            [alert addAction:cancleAction];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            x.userInteractionEnabled = YES;
        }];
        [_bottomView addSubview:deleteBtn];
        //保存按钮
        UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setBackgroundColor:Color_0072FF];
        saveBtn.titleLabel.font = FONT16;
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
            //车牌，联系人，手机号为必填项
            if ([NSString strIsEmpty:self.requestModel.license_number]) {
                
                [MBProgressHUD wj_showError:@"请输入车牌号"];
            }
            else if ([NSString strIsEmpty:self.requestModel.contacts]){
                
                [MBProgressHUD wj_showError:@"请输入联系人"];
            }
            else if ([NSString strIsEmpty:self.requestModel.phone] || self.requestModel.phone.length != 11){
                
                [MBProgressHUD wj_showError:@"请输入正确的手机号"];
            }
            else{
                
                [weakSelf modifyVehicleFile];
            }
            
            x.userInteractionEnabled = YES;
        }];
        
        [_bottomView addSubview:saveBtn];
        
        float buttonWidth = MAINWIDTH / 2;
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.bottom.offset(0);
            make.width.offset(buttonWidth);
        }];
        
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.top.bottom.offset(0);
            make.width.offset(buttonWidth);
        }];
    }
    return _bottomView;
}

#pragma mark  ----  SET

-(void)setViewState:(ViewState)viewState{
    
    _viewState = viewState;
    if (_viewState == ViewState_show) {
        
        self.tableView.userInteractionEnabled = NO;
    }
    else if (_viewState == ViewState_edit){
        
        self.tableView.userInteractionEnabled = YES;
    }
}

#pragma mark  ----  生命周期函数

-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self addGesture];
    [self drawUI];
    NSDictionary * dic = [self.vehicleFileModel mj_keyValues];
    self.requestModel = [ModifyVehicleFileRequestModel mj_objectWithKeyValues:dic];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0){
        
        cellHeight = 245;
    }
    else{
        
        cellHeight = 194;
    }
    
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        
        static NSString * secondCellId = @"VehicleInformationCell";
        VehicleInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[VehicleInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
            cell.numberCanEdit = NO;
            
            __weak typeof(self) weakSelf = self;
            //车牌号
            [[cell rac_valuesForKeyPath:@"numberPlateTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.license_number = x;
            }];
            
            //车架号
            [[cell rac_valuesForKeyPath:@"frameNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.vin = x;
            }];
            
            //车型号
            [[cell rac_valuesForKeyPath:@"carModelTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.type = x;
            }];
            
            //发动机型号
            [[cell rac_valuesForKeyPath:@"engineNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.engine_no = x;
            }];
        }
        
        if (self.vehicleFileModel) {
            
            [cell showDataWithDic:@{@"numberPlateNumber":self.vehicleFileModel.license_number,@"vehicleIdentificationNumber":[NSString repleaseNilOrNull:self.vehicleFileModel.vin],@"brandModelNumber":[NSString repleaseNilOrNull:self.vehicleFileModel.type],@"engineNumber":[NSString repleaseNilOrNull:self.vehicleFileModel.engine_no]}];
        }
        
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * thirdCellId = @"DriverInformationCell";
        DriverInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            
            cell = [[DriverInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
            
            __weak typeof(self) weakSelf = self;
            
            [[cell rac_valuesForKeyPath:@"contactTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.contacts  = x;
            }];
            
            [[cell rac_valuesForKeyPath:@"phoneNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.phone = x;
            }];
            
            [[cell rac_valuesForKeyPath:@"InsurancePeriodContentLabel.text" observer:self] subscribeNext:^(id  _Nullable x) {
                
                if ([x rangeOfString:@"月份"].location != NSNotFound) {
                    
                    NSMutableString * str = [[NSMutableString alloc] initWithString:x];
                    [str replaceCharactersInRange:[str rangeOfString:@"月份"] withString:@""];
                    weakSelf.requestModel.insurance_period = str;
                }
            }];
        }
        
        if (self.vehicleFileModel) {
            
            //contact,联系人;phoneNumber,手机号;InsurancePeriod,保险期;
            NSString * InsurancePeriod = [[NSString alloc] initWithFormat:@"%@月份",[NSString repleaseNilOrNull:self.vehicleFileModel.insurance_period]];
            [cell showData:@{@"contact":self.vehicleFileModel.contacts,@"phoneNumber":self.vehicleFileModel.phone,@"InsurancePeriod":InsurancePeriod}];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{

    self.view.backgroundColor = Color_F3F3F3;
    self.viewState = ViewState_show;
    [self.navigationbar addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.offset(44);
        make.right.offset(-13);
        make.bottom.offset(0);
    }];
    
    [self.view addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.height.offset(21);
    }];
    
    [self.view bringSubviewToFront:self.navigationbar];
    
    [self refreshViewType:BTVCType_AddTableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.whiteView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(444);
    }];
    self.tableView.scrollEnabled = NO;
    
    [self.view addSubview:self.maintenanceRecordsView];
    [self.maintenanceRecordsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(47);
    }];
    
    self.maintenanceRecordsLabel.text = [[NSString alloc] initWithFormat:@"维修记录(%ld)",self.vehicleFileModel.maintain_count.integerValue];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.offset(44);
    }];
}

//添加手势
-(void)addGesture{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    __weak typeof(self) weakSelf = self;
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        [weakSelf.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
}

//修改车辆档案
-(void)modifyVehicleFile{

    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
    });
    
    NSDictionary * tempBodyParameters = [self.requestModel mj_keyValues];
    NSMutableDictionary * bodyParameters = [[NSMutableDictionary alloc] initWithDictionary:tempBodyParameters];
    [bodyParameters setObject:bodyParameters[@"id"] forKey:@"car_id"];
    [bodyParameters removeObjectForKey:@"id"];
    
    
    NSDictionary * configurationDic = @{@"requestUrlStr":Caredit,@"bodyParameters":bodyParameters};

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

//删除车辆档案
-(void)deleteModifyVehicleFile{
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
    });
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"car_id":self.requestModel.car_id};
    NSDictionary * configurationDic = @{@"requestUrlStr":Deletecar,@"bodyParameters":bodyParameters};
    
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
