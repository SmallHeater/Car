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
#import "BaiDuBosControl.h"

@interface FastPickUpViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView * tableView;
//保存按钮
@property (nonatomic,strong) UIButton * saveBtn;
//行驶证模型
@property (nonatomic,strong) DrivingLicenseModel * drivingLicenseModel;
//快速接车请求模型
@property (nonatomic,strong) FastPickUpRequestModel * requestModel;
//行驶证图片
@property (nonatomic,strong) UIImage * drivingLicenseImage;
//提交请求的MBP
@property (nonatomic,strong) MBProgressHUD * mbp;

@end

@implementation FastPickUpViewController

#pragma mark  ----  懒加载

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

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //取消contentSize和contentOffset的改的，解决闪屏问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        //        _tableView.backgroundColor = [UIColor redColor];
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
        [_saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = Color_F3F3F3;
    [self addGesture];
    [[AipOcrService shardService] authWithAK:@"aWPDQqSndeWBNp3tlynb5S2a" andSK:@"RHxOyurd1nud4nAlCakIQMe93wc1UIMd"];
    [self drawUI];
    [self registrationNotice];
}

#pragma mark  ----  代理

# pragma mark ---- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
    }
    
    return  YES;
}

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 103;
    }
    else if (indexPath.row == 1){
        
        cellHeight = 245;
    }
    else{
        
        cellHeight = 194;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        __weak typeof(self) weakSelf = self;
        [SHRoutingComponent openURL:TAKEPHOTO withParameter:@{@"cameraType":[NSNumber numberWithInteger:2]} callBack:^(NSDictionary *resultDic) {
            
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
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellId = @"IdentificationDrivingLicenseCell";
        IdentificationDrivingLicenseCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[IdentificationDrivingLicenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellId = @"VehicleInformationCell";
        VehicleInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[VehicleInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            __weak typeof(self) weakSelf = self;
            cell.enCallBack = ^(NSString * _Nonnull result) {
                
                weakSelf.drivingLicenseModel.engineNumber = [NSString repleaseNilOrNull:result];
            };
            cell.bmnCallBack = ^(NSString * _Nonnull result) {
                
                weakSelf.drivingLicenseModel.brandModelNumber = [NSString repleaseNilOrNull:result];
            };
            cell.vinCallBack = ^(NSString * _Nonnull result) {
                
                weakSelf.drivingLicenseModel.vehicleIdentificationNumber = [NSString repleaseNilOrNull:result];
            };
            cell.npnCallBack = ^(NSString * _Nonnull result) {
                
                weakSelf.drivingLicenseModel.numberPlateNumber = [NSString repleaseNilOrNull:result];
            };
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            __weak typeof(self) weakSelf = self;
            cell.contactsCallBack = ^(NSString * _Nonnull result) {
                
                weakSelf.drivingLicenseModel.owner = [NSString repleaseNilOrNull:result];
            };
            
            cell.phoneNumberCallBack = ^(NSString * _Nonnull result) {
              
                weakSelf.requestModel.phone = [NSString repleaseNilOrNull:result];
            };
            
            cell.dataCallBack = ^(NSString * _Nonnull result) {
              
                weakSelf.requestModel.insurance_period = [NSString repleaseNilOrNull:result];
            };
        }
        
        if (self.drivingLicenseModel && ![NSString strIsEmpty:self.drivingLicenseModel.owner]) {
            
            [cell showDataWithModel:self.drivingLicenseModel];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.tableView];
    
    if (MAINHEIGHT >= 542 + 64 + 123) {
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.height.offset(542);
        }];
        self.tableView.scrollEnabled = NO;
    }
    else{
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
            make.bottom.offset(-123);
        }];
    }

    
    //需要重新设置导航的层级，不然阴影效果没了
    [self.view bringSubviewToFront:self.navigationbar];
    
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-30 - [UIScreenControl bottomSafeHeight]);
        make.height.offset(44);
    }];
}

//注册通知
-(void)registrationNotice{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//添加手势
-(void)addGesture{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    
    self.tableView.scrollEnabled = YES;
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
    
    self.tableView.scrollEnabled = NO;
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(-123);
        }];
    }];
}

//保存按钮的响应
-(void)saveBtnClicked:(UIButton *)btn{
    
    self.requestModel.user_id = [UserInforController  sharedManager].userInforModel.userID;
    self.requestModel.license_number = self.drivingLicenseModel.numberPlateNumber;
    self.requestModel.vin = self.drivingLicenseModel.vehicleIdentificationNumber;
    self.requestModel.type = self.drivingLicenseModel.brandModelNumber;
    self.requestModel.engine_no = self.drivingLicenseModel.engineNumber;
    self.requestModel.contacts = self.drivingLicenseModel.owner;
    self.requestModel.vehicle_license_image = @"";
    
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
        
        //上传行驶证照片
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.mbp = [MBProgressHUD wj_showActivityLoadingToView:weakSelf.view];
        });
        [[BaiDuBosControl sharedManager] uploadImage:self.drivingLicenseImage callBack:^(NSString * _Nonnull imagePath) {
            
            if (![NSString strIsEmpty:imagePath]) {
                
                weakSelf.requestModel.vehicle_license_image = imagePath;
            }
            [weakSelf submit];
        }];
    }
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

-(void)viewTaped:(UIGestureRecognizer *)ges{
    
    [self.view endEditing:YES];
}

@end
