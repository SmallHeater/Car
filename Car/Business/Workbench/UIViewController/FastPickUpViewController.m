//
//  FastPickUpViewController.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FastPickUpViewController.h"
#import "IdentificationDrivingLicenseCell.h"


@interface FastPickUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FastPickUpViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 103;
    }
    else{
        
        cellHeight = 104;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
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
    
    return nil;
}

#pragma mark  ----  自定义函数



@end
