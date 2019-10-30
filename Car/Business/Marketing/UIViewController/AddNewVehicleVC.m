//
//  AddNewVehicleVC.m
//  Car
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AddNewVehicleVC.h"
#import "AddNewVehicleCell.h"
#import "CustomerManagementCell.h"
#import "BusinessReturnVisitViewController.h"

@interface AddNewVehicleVC ()<CustomerManagementCellDelegate>

@end

@implementation AddNewVehicleVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 209;
    }
    else if (indexPath.row == 1){
        
        cellHeight = 135;
    }
    else if (indexPath.row == 2){
        
        cellHeight = 135;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellId = @"AddNewVehicleCell";
        AddNewVehicleCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            cell = [[AddNewVehicleCell alloc] initWithReuseIdentifier:firstCellId];
        }
        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == 2){
        
        static NSString * fifthCellId = @"CustomerManagementCell";
        CustomerManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:fifthCellId];
        if (!cell) {
            
            cell = [[CustomerManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fifthCellId];
            cell.delegate = self;
        }
        
        NSDictionary * dataDic;
        if (indexPath.row == 1) {
            
            //title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
            dataDic = @{@"title":@"客户维护",@"btnDicArray":@[@{@"imageName":@"yewuhuifang",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"业务回访",@"itemId":@"yewuhuifang"},@{@"imageName":@"baoyangtuijian",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"保养推荐",@"itemId":@"baoyangtuijian"}]};
        }
        else if (indexPath.row == 2){
            
            dataDic = @{@"title":@"活动推广",@"btnDicArray":@[@{@"imageName":@"xinxifasong",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"信息发送",@"itemId":@"xinxifasong"},@{@"imageName":@"fasongjilu",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"发送记录",@"itemId":@"fasongjilu"},@{@"imageName":@"yixiankehu",@"imageWidth":[NSNumber numberWithInteger:30],@"imageHeight":[NSNumber numberWithInteger:30],@"btnTitle":@"意向客户",@"itemId":@"yixiankehu"}]};
        }
        
        [cell showData:dataDic];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  CustomerManagementCellDelegate

-(void)itemClickedWithItemID:(NSString *)itemId{
    
    if ([itemId isEqualToString:@"yewuhuifang"]) {
        
        //业务回访
        BusinessReturnVisitViewController * vc = [[BusinessReturnVisitViewController alloc] initWithTitle:@"业务回访" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([itemId isEqualToString:@"baoyangtuijian"]){
        
        //保养推荐
    }
}

@end
