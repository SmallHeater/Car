//
//  WorkbenchViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "WorkbenchViewController.h"
#import "AutoRepairShopCell.h"
#import "CarouselCell.h"
#import "SearchBarCell.h"
#import "AnnouncementCell.h"
#import "CustomerManagementCell.h"
#import "VehicleFileViewController.h"
#import "FastPickUpViewController.h"
#import "MaintenanceRecordsViewController.h"
#import "RevenueListViewController.h"
#import "UserInforController.h"
#import "WorkbenchModel.h"
#import "ProfitStatisticsViewController.h"
#import "VehicleFileViewController.h"
#import "PaymentManagementViewController.h"
#import "BusinessSummaryViewController.h"
#import "SHBaiDuBosControl.h"
#import <AipOcrSdk/AipOcrService.h>
#import <AipOcrSdk/AipCaptureCardVC.h>
#import "SHBaseWKWebViewController.h"
#import "DrivingLicenseModel.h"
#import "VehicleFileDetailViewController.h"
#import "BusinessReturnVisitViewController.h"

@interface WorkbenchViewController ()<CustomerManagementCellDelegate>

//数据模型
@property (nonatomic,strong) WorkbenchModel * workbenchModel;

@end

@implementation WorkbenchViewController

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self refreshViewType:BTVCType_AddTableView];
    [self requestListData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}
#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    switch (indexPath.row) {
        case 0:
            
            cellHeight = 28;
            break;
        case 1:
            
            cellHeight = (MAINWIDTH - 15 * 2) / 345.0 * 150.0 + 20 * 2;
            break;
        case 2:
            
            cellHeight = 40;
            break;
        case 3:
            
            cellHeight = 68;
            break;
        case 4:
            
            cellHeight = 135;
            break;
        case 5:
            
            cellHeight = 135;
            break;
        case 6:
            
            cellHeight = 135;
            break;
        default:
            break;
    }
    
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellId = @"AutoRepairShopCell";
        AutoRepairShopCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[AutoRepairShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
        }
        
        [cell showAutoRepairShopName:[UserInforController sharedManager].userInforModel.shop_name];
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellId = @"CarouselCell";
        CarouselCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[CarouselCell alloc] initWithReuseIdentifier:secondCellId andStyle:CarouselStyle_gongzuotai];
            
            __weak typeof(self) weakSelf = self;
            cell.clickCallBack = ^(NSString * _Nonnull urlStr) {
                
                if (![NSString strIsEmpty:urlStr]) {
                 
                    SHBaseWKWebViewController * webViewController = [[SHBaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
                    webViewController.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:webViewController animated:YES];
                }
            };
        }
        
        if (self.workbenchModel.banner && self.workbenchModel.banner.count > 0) {
            
            [cell showData:self.workbenchModel.banner];
        }
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString * thirdCellId = @"SearchBarCell";
        SearchBarCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            
            cell = [[SearchBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
            __weak typeof(self) weakSelf = self;
            cell.searchCallBack = ^(NSString * _Nonnull searchText) {
                
                if (![NSString strIsEmpty:searchText]) {
                 
                    [weakSelf searchWithStr:searchText];
                }
            };
            
            cell.scanningCallBack = ^{
                
                [weakSelf scanning];
            };
        }
        
        return cell;
    }
    else if (indexPath.row == 3){
        
        static NSString * forthCellId = @"AnnouncementCell";
        AnnouncementCell * cell = [tableView dequeueReusableCellWithIdentifier:forthCellId];
        if (!cell) {
            
            cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forthCellId];
        }
        
        if (self.workbenchModel.notice && self.workbenchModel.notice.count > 0) {
            
            [cell showData:self.workbenchModel.notice];
        }
        return cell;
    }
    else if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6){
        
        static NSString * fifthCellId = @"CustomerManagementCell";
        CustomerManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:fifthCellId];
        if (!cell) {
            
            cell = [[CustomerManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fifthCellId];
            cell.delegate = self;
        }
   
        NSDictionary * dataDic;
        if (indexPath.row == 4) {
            
            //title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
            dataDic = @{@"title":@"客户管理",@"btnDicArray":@[@{@"imageName":@"kuaisujieche",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"快速接车",@"itemId":@"kuaisujieche"},@{@"imageName":@"kehudangan",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"车辆档案",@"itemId":@"kehudangan"},@{@"imageName":@"weixiujilu",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"维修记录",@"itemId":@"weixiujilu"}]};
        }
        else if (indexPath.row == 5){
            
            dataDic = @{@"title":@"财务管理",@"btnDicArray":@[@{@"imageName":@"yingshouliebiao",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"营收列表",@"itemId":@"yingshouliebiao"},@{@"imageName":@"huikuanguanli",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"回款管理",@"itemId":@"huikuanguanli"},@{@"imageName":@"liruntongji",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"利润统计",@"itemId":@"liruntongji"},@{@"imageName":@"yingyehuizong",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"营业汇总",@"itemId":@"yingyehuizong"}]};
        }
//        else if (indexPath.row == 6){
//
//            dataDic = @{@"title":@"车险管理",@"btnDicArray":@[@{@"imageName":@"daishouchaxun",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"待售查询",@"itemId":@"daishouchaxun"},@{@"imageName":@"xiaoshouzhuangtai",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"销售状态",@"itemId":@"xiaoshouzhuangtai"}]};
//        }
        else if (indexPath.row == 6) {
            
            //title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
            dataDic = @{@"title":@"客户维护",@"btnDicArray":@[@{@"imageName":@"yewuhuifang",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"业务回访",@"itemId":@"yewuhuifang"},@{@"imageName":@"baoyangtuijian",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"保养推荐",@"itemId":@"baoyangtuijian"}]};
        }
        
        [cell showData:dataDic];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  CustomerManagementCellDelegate

-(void)itemClickedWithItemID:(NSString *)itemId{
    
    SHBaseViewController * vc;
    if ([itemId isEqualToString:@"kuaisujieche"]) {
        
        //快速接车
        vc = [[FastPickUpViewController alloc] initWithTitle:@"快速接车" andIsShowBackBtn:YES];
    }
    else if ([itemId isEqualToString:@"kehudangan"]) {
        
        //车辆档案
        vc = [[VehicleFileViewController alloc] initWithTitle:@"车辆档案列表" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    }
    else if ([itemId isEqualToString:@"weixiujilu"]) {
        
        //维修记录
        vc = [[MaintenanceRecordsViewController alloc] initWithTitle:@"维修记录" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    }
    else if ([itemId isEqualToString:@"yingshouliebiao"]) {
        
        //营收列表
        vc = [[RevenueListViewController alloc] initWithTitle:@"营收列表" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    }
    else if ([itemId isEqualToString:@"huikuanguanli"]) {
        
        //回款管理
        vc = [[PaymentManagementViewController alloc] initWithTitle:@"回款管理" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    }
    else if ([itemId isEqualToString:@"liruntongji"]) {
        
        //利润统计
        vc = [[ProfitStatisticsViewController alloc] initWithTitle:@"利润统计" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    }
    else if ([itemId isEqualToString:@"yingyehuizong"]) {
        
        //营业汇总
        vc = [[BusinessSummaryViewController alloc] initWithTitle:@"营业汇总" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStyleGrouped];
    }
    else if ([itemId isEqualToString:@"daishouchaxun"]) {
        
        //待售查询
    }
    else if ([itemId isEqualToString:@"xiaoshouzhuangtai"]) {
        
        //销售状态
    }
    else if ([itemId isEqualToString:@"yewuhuifang"]) {
        
        //业务回访
        BusinessReturnVisitViewController * vc = [[BusinessReturnVisitViewController alloc] initWithTitle:@"业务回访" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([itemId isEqualToString:@"baoyangtuijian"]){
        
        //保养推荐
    }
    if (vc) {
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark  ----  自定义函数

-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Bench,@"bodyParameters":bodyParameters};
    __weak WorkbenchViewController * weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                self.workbenchModel = [WorkbenchModel mj_objectWithKeyValues:dataDic];
                [weakSelf refreshViewType:BTVCType_RefreshTableView];
            }
            else{
                
                
            }
        }
        else{
        
            //失败的
           
        }
    }];
}

//搜索
-(void)searchWithStr:(NSString *)str{
    
    __weak typeof(self) weakSelf = self;
    [[PublicRequest sharedManager] requestIsExistedLicenseNumber:str callBack:^(BOOL isExisted,VehicleFileModel * model,NSString * msg) {
        
        if (isExisted) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //已存在，跳转到车辆档案页
                VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                vc.hidesBottomBarWhenPushed = YES;
                vc.vehicleFileModel = model;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            });
        }
        else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                DrivingLicenseModel * model = [[DrivingLicenseModel alloc] init];
                model.numberPlateNumber = str;
                FastPickUpViewController * vc = [[FastPickUpViewController alloc] initWithTitle:@"快速接车" andIsShowBackBtn:YES];
                vc.hidesBottomBarWhenPushed = YES;
                vc.drivingLicenseModel = model;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            });
        }
    }];
}

//扫描识别
-(void)scanning{
    
    [[AipOcrService shardService] authWithAK:@"aWPDQqSndeWBNp3tlynb5S2a" andSK:@"RHxOyurd1nud4nAlCakIQMe93wc1UIMd"];
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:TAKEPHOTO withParameter:@{@"cameraType":[NSNumber numberWithInteger:2]} callBack:^(NSDictionary *resultDic) {
        
        if ([resultDic.allKeys containsObject:@"error"]) {
            
            //异常
            NSLog(@"识别异常");
        }
        else if ([resultDic.allKeys containsObject:@"image"]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD wj_showActivityLoading:@"识别中" toView:weakSelf.view];
            });
            
            UIImage * image = resultDic[@"image"];
            
            __block BOOL ocrFinished = NO;
            [[AipOcrService shardService] detectPlateNumberFromImage:image withOptions:nil successHandler:^(id result) {
                
                if (!ocrFinished) {
                    
                    ocrFinished = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD wj_hideHUDForView:weakSelf.view];
                    });
                    
                    if (result && [result isKindOfClass:[NSDictionary class]]) {
                        
                        
                        NSDictionary * resultDic = result[@"words_result"];
                        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]] && [resultDic.allKeys containsObject:@"number"]) {
                            
                            //车牌号
                            NSString * number = resultDic[@"number"];
                            [[PublicRequest sharedManager] requestIsExistedLicenseNumber:number callBack:^(BOOL isExisted,VehicleFileModel * model,NSString * msg) {
                                
                                if (isExisted) {
                                    
                                    //已存在，跳转到车辆档案页
                                    VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                                    vc.hidesBottomBarWhenPushed = YES;
                                    vc.vehicleFileModel = model;
                                    [weakSelf.navigationController pushViewController:vc animated:YES];
                                }
                                else{
                                    
                                    DrivingLicenseModel * model = [[DrivingLicenseModel alloc] init];
                                    model.numberPlateNumber = number;
                                    FastPickUpViewController * vc = [[FastPickUpViewController alloc] initWithTitle:@"快速接车" andIsShowBackBtn:YES];
                                    vc.hidesBottomBarWhenPushed = YES;
                                    vc.drivingLicenseModel = model;
                                    [weakSelf.navigationController pushViewController:vc animated:YES];
                                }
                            }];
                        }
                        else{
                            
                            [MBProgressHUD wj_showError:@"识别失败"];
                        }
                    }
                }

            } failHandler:^(NSError *err) {
                
                if (!ocrFinished) {
                    
                    ocrFinished = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD wj_hideHUDForView:weakSelf.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD wj_showError:@"识别失败"];
                        });
                    });
                }
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (ocrFinished) {
                    
                }
                else{
                    
                    ocrFinished = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD wj_hideHUDForView:weakSelf.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD wj_showError:@"识别失败"];
                        });
                    });
                }
            });
        }
    }];
}

@end
