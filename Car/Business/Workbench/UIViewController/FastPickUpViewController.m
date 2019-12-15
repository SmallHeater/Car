//
//  FastPickUpViewController.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FastPickUpViewController.h"
#import "IdentificationDrivingLicenseCell.h"
#import "VehicleInformationCell.h"
#import "DriverInformationCell.h"
#import <AipOcrSdk/AipOcrService.h>
#import <AipOcrSdk/AipCaptureCardVC.h>
#import "FastPickUpRequestModel.h"
#import "DrivingLicenseModel.h"
#import "UserInforController.h"
#import "SHBaiDuBosControl.h"
#import "VehicleFileDetailViewController.h"


@interface FastPickUpViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

//自动识别
@property (nonatomic,strong) UIButton * rightBtn;
@property (nonatomic,strong) SHBaseTableView * tableView;
//保存按钮
@property (nonatomic,strong) UIButton * saveBtn;
//快速接车请求模型
@property (nonatomic,strong) FastPickUpRequestModel * requestModel;
//行驶证图片
@property (nonatomic,strong) UIImage * drivingLicenseImage;
//提交请求的MBP
@property (nonatomic,strong) MBProgressHUD * mbp;

@property (nonatomic,assign) NSUInteger rows;

@end

@implementation FastPickUpViewController

#pragma mark  ----  懒加载

-(UIButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.font = FONT16;
        [_rightBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        [_rightBtn setTitle:@"自动识别" forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf automaticIdentification];
        }];
    }
    return _rightBtn;
}

-(DrivingLicenseModel *)drivingLicenseModel{
    
    if (!_drivingLicenseModel) {
        
        _drivingLicenseModel = [[DrivingLicenseModel alloc] init];
    }
    return _drivingLicenseModel;
}

-(FastPickUpRequestModel *)requestModel{
    
    if (!_requestModel) {
        
        _requestModel = [[FastPickUpRequestModel alloc] init];
    }
    return _requestModel;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.userInteractionEnabled = YES;
    }
    return _tableView;
}

-(UIButton *)saveBtn{
    
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.titleLabel.font = FONT16;
        [_saveBtn setBackgroundColor:Color_0072FF];
        __weak typeof(self) weakSelf = self;
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            weakSelf.requestModel.user_id = [UserInforController  sharedManager].userInforModel.userID;
            weakSelf.requestModel.license_number = weakSelf.drivingLicenseModel.numberPlateNumber;
            weakSelf.requestModel.vin = weakSelf.drivingLicenseModel.vehicleIdentificationNumber;
            weakSelf.requestModel.type = weakSelf.drivingLicenseModel.brandModelNumber;
            weakSelf.requestModel.engine_no = weakSelf.drivingLicenseModel.engineNumber;
            weakSelf.requestModel.contacts = weakSelf.drivingLicenseModel.owner;
            weakSelf.requestModel.vehicle_license_image = @"";
            
            //车牌，联系人，手机号为必填项
            if ([NSString strIsEmpty:weakSelf.requestModel.license_number]) {
                
                [MBProgressHUD wj_showError:@"请输入车牌号"];
            }
            else if ([NSString strIsEmpty:weakSelf.requestModel.contacts]){
                
                [MBProgressHUD wj_showError:@"请输入联系人"];
            }
            else if ([NSString strIsEmpty:weakSelf.requestModel.phone] || weakSelf.requestModel.phone.length != 11){
                
                [MBProgressHUD wj_showError:@"请输入正确的手机号"];
            }
            else{
                
                //上传行驶证照片
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
                });
                [[SHBaiDuBosControl sharedManager] uploadImage:self.drivingLicenseImage callBack:^(NSString * _Nonnull imagePath) {
                    
                    if (![NSString strIsEmpty:imagePath]) {
                        
                        weakSelf.requestModel.vehicle_license_image = imagePath;
                    }
                    [weakSelf submit];
                }];
            }
        }];
    }
    return _saveBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.rows = 3;
    self.view.backgroundColor = Color_F3F3F3;
    [self addGesture];
    [self drawUI];
    [self registrationNotice];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (self.rows == 3) {
        
        if (indexPath.row == 0) {
            
            cellHeight = 103 + 20;
        }
        else if (indexPath.row == 1){
            
            cellHeight = 245;
        }
        else{
            
            cellHeight = 194;
        }
    }
    else{
        
        if (indexPath.row == 1){
            
            cellHeight = 245;
        }
        else{
            
            cellHeight = 194;
        }
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.rows == 3) {
        
        if (indexPath.row == 0) {
            
            static NSString * firstCellId = @"IdentificationDrivingLicenseCell";
            IdentificationDrivingLicenseCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
            if (!cell) {
                
                cell = [[IdentificationDrivingLicenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            }
            
            __weak typeof(self) weakSelf = self;
            cell.callBack = ^(NSString * _Nonnull number) {
            
                weakSelf.drivingLicenseModel.numberPlateNumber = number;
                weakSelf.rows = 2;
                [weakSelf.tableView reloadData];
            };
            
            return cell;
        }
        else if (indexPath.row == 1){
            
            static NSString * secondCellId = @"VehicleInformationCell";
            VehicleInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
            if (!cell) {
                
                cell = [[VehicleInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
                cell.numberCanEdit = YES;
                
                __weak typeof(self) weakSelf = self;
                //车牌号
                [[cell rac_valuesForKeyPath:@"numberPlateTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.numberPlateNumber = x;
                    if (![NSString strIsEmpty:x]) {
                     
                        [[PublicRequest sharedManager] requestIsExistedLicenseNumber:weakSelf.drivingLicenseModel.numberPlateNumber callBack:^(BOOL isExisted,VehicleFileModel * model,NSString * msg) {
                            
                            if (isExisted) {
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    //已存在，跳转到车辆档案页
                                    VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                                    vc.hidesBottomBarWhenPushed = YES;
                                    vc.vehicleFileModel = model;
                                    [weakSelf.navigationController pushViewController:vc animated:YES];
                                });
                            }
                        }];
                    }
                }];
                
                //车架号
                [[cell rac_valuesForKeyPath:@"frameNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.vehicleIdentificationNumber = x;
                }];
                
                //车型号
                [[cell rac_valuesForKeyPath:@"carModelTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.brandModelNumber = x;
                }];
                
                //发动机型号
                [[cell rac_valuesForKeyPath:@"engineNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.engineNumber = x;
                }];
            }

            if (self.drivingLicenseModel && ![NSString strIsEmpty:self.drivingLicenseModel.numberPlateNumber]) {
        
                [cell showDataWithDic:@{@"numberPlateNumber":self.drivingLicenseModel.numberPlateNumber,@"vehicleIdentificationNumber":self.drivingLicenseModel.vehicleIdentificationNumber,@"brandModelNumber":self.drivingLicenseModel.brandModelNumber,@"engineNumber":self.drivingLicenseModel.engineNumber}];
            }
            
            return cell;
        }
        else if (indexPath.row == 2){
            
            static NSString * thirdCellId = @"DriverInformationCell";
            DriverInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
            if (!cell) {
                
                cell = [[DriverInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
                
                __weak typeof(self) weakSelf = self;
                [[cell rac_valuesForKeyPath:@"contactTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.owner = x;
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
            
            if (self.drivingLicenseModel && ![NSString strIsEmpty:self.drivingLicenseModel.owner]) {
                
                [cell showDataWithModel:self.drivingLicenseModel];
            }
            
            return cell;
        }
    }
    else{
        
        if (indexPath.row == 0){
            
            static NSString * secondCellId = @"VehicleInformationCell";
            VehicleInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
            if (!cell) {
                
                cell = [[VehicleInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
                cell.numberCanEdit = YES;
                
                __weak typeof(self) weakSelf = self;
                //车牌号
                [[cell rac_valuesForKeyPath:@"numberPlateTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.numberPlateNumber = x;
                    if (![NSString strIsEmpty:x]) {
                     
                        [[PublicRequest sharedManager] requestIsExistedLicenseNumber:weakSelf.drivingLicenseModel.numberPlateNumber callBack:^(BOOL isExisted,VehicleFileModel * model,NSString * msg) {
                            
                            if (isExisted) {
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    //已存在，跳转到车辆档案页
                                    VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                                    vc.hidesBottomBarWhenPushed = YES;
                                    vc.vehicleFileModel = model;
                                    [weakSelf.navigationController pushViewController:vc animated:YES];
                                });
                            }
                        }];
                    }
                }];
                
                //车架号
                [[cell rac_valuesForKeyPath:@"frameNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.vehicleIdentificationNumber = x;
                }];
                
                //车型号
                [[cell rac_valuesForKeyPath:@"carModelTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.brandModelNumber = x;
                }];
                
                //发动机型号
                [[cell rac_valuesForKeyPath:@"engineNumberTF.text" observer:self] subscribeNext:^(id  _Nullable x) {
                    
                    weakSelf.drivingLicenseModel.engineNumber = x;
                }];
            }

            __weak typeof(self) weakSelf = self;
            cell.callBack = ^{
              
                weakSelf.rows = 3;
                [weakSelf.tableView reloadData];
            };
            if (self.drivingLicenseModel && ![NSString strIsEmpty:self.drivingLicenseModel.numberPlateNumber]) {
        
                [cell showDataWithDic:@{@"numberPlateNumber":self.drivingLicenseModel.numberPlateNumber,@"vehicleIdentificationNumber":self.drivingLicenseModel.vehicleIdentificationNumber,@"brandModelNumber":self.drivingLicenseModel.brandModelNumber,@"engineNumber":self.drivingLicenseModel.engineNumber}];
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
                    
                    weakSelf.drivingLicenseModel.owner = x;
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
            
            if (self.drivingLicenseModel && ![NSString strIsEmpty:self.drivingLicenseModel.owner]) {
                
                [cell showDataWithModel:self.drivingLicenseModel];
            }
            
            return cell;
        }
    }
    return nil;
}

#pragma mark  ----  UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    BOOL canResponse = YES;
    CGPoint point = [touch locationInView:self.view];
    if (point.y < 103 + [SHUIScreenControl navigationBarHeight]) {
        
        canResponse = NO;
    }
    return canResponse;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(0);
        make.bottom.offset(0);
        make.width.offset(90);
        make.height.offset(44);
    }];
    
    [self.view addSubview:self.tableView];
    
    if (MAINHEIGHT >= 542 + 64 + 123) {
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.height.offset(542);
        }];
        self.tableView.scrollEnabled = NO;
        [self.view addSubview:self.saveBtn];
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.right.offset(-15);
            make.bottom.offset(-30 - [SHUIScreenControl bottomSafeHeight]);
            make.height.offset(44);
        }];
    }
    else{
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.bottom.offset(-44);
        }];
        
        [self.view addSubview:self.saveBtn];
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.right.offset(-15);
            make.bottom.offset(0);
            make.height.offset(44);
        }];
    }

    //需要重新设置导航的层级，不然阴影效果没了
    [self.view bringSubviewToFront:self.navigationbar];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    __weak typeof(self) weakSelf = self;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        weakSelf.tableView.scrollEnabled = YES;
        NSDictionary *userInfo = [x userInfo];
        CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
        CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
        [UIView animateWithDuration:duration animations:^{
            
            [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.offset(-rect.size.height);
            }];
        }];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        
        if (MAINHEIGHT >= 542 + 64 + 123) {
            
            self.tableView.scrollEnabled = NO;
        }
        
        NSDictionary *userInfo = [x userInfo];
        CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            
            if (MAINHEIGHT >= 542 + 64 + 123) {
                
                [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.offset(-123);
                }];
            }
            else{
                
                [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.offset(-44);
                }];
            }
        }];
    }];
}

//添加手势
-(void)addGesture{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    tap.delegate = self;
    __weak typeof(self) weakSelf = self;
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        [weakSelf.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
}

//提交
-(void)submit{
    
    NSDictionary * bodyParameters = [self.requestModel mj_keyValues];
    NSDictionary * configurationDic = @{@"requestUrlStr":Receptioncar,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
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
                    
                    //成功
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                        [weakSelf backBtnClicked:nil];
                    });
                }
                else{
                    
                    //异常
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

//自动识别
-(void)automaticIdentification{
    
    [[AipOcrService shardService] authWithAK:@"aWPDQqSndeWBNp3tlynb5S2a" andSK:@"RHxOyurd1nud4nAlCakIQMe93wc1UIMd"];
    __weak typeof(self) weakSelf = self;
    //新样式改为4
    [SHRoutingComponent openURL:TAKEPHOTO withParameter:@{@"cameraType":[NSNumber numberWithInteger:4]} callBack:^(NSDictionary *resultDic) {

        if ([resultDic.allKeys containsObject:@"error"]) {

            //异常
            NSLog(@"快速接车,异常");
        }
        else if ([resultDic.allKeys containsObject:@"image"]){

            dispatch_async(dispatch_get_main_queue(), ^{

                [MBProgressHUD wj_showActivityLoading:@"识别中" toView:weakSelf.view];
            });

            UIImage * image = resultDic[@"image"];
            weakSelf.drivingLicenseImage = image;
            [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {

                dispatch_async(dispatch_get_main_queue(), ^{

                    [MBProgressHUD wj_hideHUDForView:weakSelf.view];
                });

                if (result && [result isKindOfClass:[NSDictionary class]]) {

                    NSDictionary * resultDic = result[@"words_result"];
                    NSDictionary * firstDic = resultDic[@"发动机号码"];
                    weakSelf.drivingLicenseModel.engineNumber = firstDic[@"words"];
                    NSDictionary * secondDic = resultDic[@"号牌号码"];
                    weakSelf.drivingLicenseModel.numberPlateNumber = secondDic[@"words"];
                    [[PublicRequest sharedManager] requestIsExistedLicenseNumber:weakSelf.drivingLicenseModel.numberPlateNumber callBack:^(BOOL isExisted,VehicleFileModel * model,NSString * msg) {

                        if (isExisted) {

                            //已存在，跳转到车辆档案页
                            VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.vehicleFileModel = model;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                    NSDictionary * thirdDic = resultDic[@"所有人"];
                    weakSelf.drivingLicenseModel.owner = thirdDic[@"words"];
                    NSDictionary * forthDic = resultDic[@"使用性质"];
                    weakSelf.drivingLicenseModel.useTheNature = forthDic[@"words"];
                    NSDictionary * fifthDic = resultDic[@"住址"];
                    weakSelf.drivingLicenseModel.address = fifthDic[@"words"];
                    NSDictionary * sixthDic = resultDic[@"注册日期"];
                    weakSelf.drivingLicenseModel.registeredDate = sixthDic[@"words"];
                    NSDictionary * seventhDic = resultDic[@"车辆识别代号"];
                    weakSelf.drivingLicenseModel.vehicleIdentificationNumber = seventhDic[@"words"];
                    NSDictionary * eighthDic = resultDic[@"品牌型号"];
                    weakSelf.drivingLicenseModel.brandModelNumber = eighthDic[@"words"];
                    NSDictionary * ninthDic = resultDic[@"车辆类型"];
                    weakSelf.drivingLicenseModel.vehicleType = ninthDic[@"words"];
                    NSDictionary * tenthDic = resultDic[@"发证日期"];
                    weakSelf.drivingLicenseModel.dateIssue = tenthDic[@"words"];
                    dispatch_async(dispatch_get_main_queue(), ^{

                        weakSelf.rows = 2;
                        [weakSelf.tableView reloadData];
                    });
                }
            } failHandler:^(NSError *err) {

                NSLog(@"失败:%@", err);
                dispatch_async(dispatch_get_main_queue(), ^{

                    [MBProgressHUD wj_hideHUDForView:weakSelf.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                        [MBProgressHUD wj_showError:@"识别失败，请输入"];
                    });
                });
            }];
        }
    }];
}

@end
