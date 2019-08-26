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


@interface WorkbenchViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    // Do any additional setup after loading the view.
    
    
    [self refreshViewType:BTVCType_AddTableView];
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
            
            cellHeight = 48;
            break;
        case 1:
            
            cellHeight = (MAINWIDTH - 15 - 16) / 346.0 * 150.0;
            break;
        case 2:
            
            cellHeight = 58;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        
        VehicleFileViewController * vc = [[VehicleFileViewController alloc] initWithTitle:@"车辆档案列表" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        
        [cell showAutoRepairShopName:@"北京修车厂"];
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellId = @"CarouselCell";
        CarouselCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[CarouselCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
        }
        
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString * thirdCellId = @"SearchBarCell";
        SearchBarCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            
            cell = [[SearchBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else if (indexPath.row == 3){
        
        static NSString * forthCellId = @"AnnouncementCell";
        AnnouncementCell * cell = [tableView dequeueReusableCellWithIdentifier:forthCellId];
        if (!cell) {
            
            cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forthCellId];
        }
        
//        cell.backgroundColor = [UIColor orangeColor];
        
        return cell;
    }
    else if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6){
        
        static NSString * fifthCellId = @"CustomerManagementCell";
        CustomerManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:fifthCellId];
        if (!cell) {
            
            cell = [[CustomerManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fifthCellId];
        }
   
        NSDictionary * dataDic;
        if (indexPath.row == 4) {
            
            //title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
            dataDic = @{@"title":@"客户管理",@"btnDicArray":@[@{@"imageName":@"kuaidujieche",@"imageWidth":[NSNumber numberWithInteger:28],@"imageHeight":[NSNumber numberWithInteger:25],@"btnTitle":@"快速接车"},@{@"imageName":@"kehudangan",@"imageWidth":[NSNumber numberWithInteger:23],@"imageHeight":[NSNumber numberWithInteger:24],@"btnTitle":@"客户档案"},@{@"imageName":@"weixiujilu",@"imageWidth":[NSNumber numberWithInteger:26],@"imageHeight":[NSNumber numberWithInteger:25],@"btnTitle":@"维修记录"}]};
        }
        else if (indexPath.row == 5){
            
            dataDic = @{@"title":@"财务管理",@"btnDicArray":@[@{@"imageName":@"yingshouliebiao",@"imageWidth":[NSNumber numberWithInteger:25],@"imageHeight":[NSNumber numberWithInteger:25],@"btnTitle":@"营收列表"},@{@"imageName":@"huikuanguanli",@"imageWidth":[NSNumber numberWithInteger:21],@"imageHeight":[NSNumber numberWithInteger:26],@"btnTitle":@"回款管理"},@{@"imageName":@"liruntongji",@"imageWidth":[NSNumber numberWithInteger:22],@"imageHeight":[NSNumber numberWithInteger:24],@"btnTitle":@"利润统计"},@{@"imageName":@"yingyehuizong",@"imageWidth":[NSNumber numberWithInteger:22],@"imageHeight":[NSNumber numberWithInteger:22],@"btnTitle":@"营业汇总"}]};
        }
        else if (indexPath.row == 6){
            
            dataDic = @{@"title":@"车险管理",@"btnDicArray":@[@{@"imageName":@"daishouchaxun",@"imageWidth":[NSNumber numberWithInteger:23],@"imageHeight":[NSNumber numberWithInteger:20],@"btnTitle":@"待售查询"},@{@"imageName":@"xiaoshouzhuangtai",@"imageWidth":[NSNumber numberWithInteger:21],@"imageHeight":[NSNumber numberWithInteger:21],@"btnTitle":@"销售状态"}]};
        }
        
        [cell showData:dataDic];
        
        return cell;
    }
    
    return nil;
}



@end