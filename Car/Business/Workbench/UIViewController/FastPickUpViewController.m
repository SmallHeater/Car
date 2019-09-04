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


@interface FastPickUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
//保存按钮
@property (nonatomic,strong) UIButton * saveBtn;
//行驶证模型
@property (nonatomic,strong) DrivingLicenseModel * drivingLicenseModel;
//快速接车请求模型
@property (nonatomic,strong) FastPickUpRequestModel * requestModel;

@end

@implementation FastPickUpViewController

#pragma mark  ----  懒加载

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
    [[AipOcrService shardService] authWithAK:@"yqvmGyaz0wtcXGCO0rwg5OhD" andSK:@"mC8IKB7HzwRtuwQrloawUPHSFTjGqwHk"];
    [self drawUI];
    [self registrationNotice];
}

#pragma mark  ----  代理

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
            }
            else if ([resultDic.allKeys containsObject:@"image"]){
                
                UIImage * image = resultDic[@"image"];
                [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {
                    
                    if (result && [result isKindOfClass:[NSDictionary class]]) {
                        
                        weakSelf.drivingLicenseModel = [[DrivingLicenseModel alloc] init];
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
        }

        if (self.drivingLicenseModel) {
            
            [cell showDataWithModel:self.drivingLicenseModel];
        }
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString * thirdCellId = @"DriverInformationCell";
        DriverInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            
            cell = [[DriverInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (self.drivingLicenseModel) {
            
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

//保存按钮的响应
-(void)saveBtnClicked:(UIButton *)btn{
    
    self.requestModel.user_id = [UserInforController  sharedManager].userInforModel.userID;
    self.requestModel.license_number = self.drivingLicenseModel.numberPlateNumber;
    self.requestModel.vin = self.drivingLicenseModel.vehicleIdentificationNumber;
    self.requestModel.type = self.drivingLicenseModel.brandModelNumber;
    self.requestModel.engine_no = self.drivingLicenseModel.engineNumber;
    self.requestModel.contacts = self.drivingLicenseModel.owner;
    self.requestModel.phone = @"";
    self.requestModel.insurance_period = @"";
    self.requestModel.vehicle_license_image = @"";
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

@end
