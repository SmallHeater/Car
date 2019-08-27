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

@interface FastPickUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

//保存按钮
@property (nonatomic,strong) UIButton * saveBtn;

@end

@implementation FastPickUpViewController

#pragma mark  ----  懒加载

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
    [self drawUI];
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
        
        [cell test];
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString * thirdCellId = @"DriverInformationCell";
        DriverInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            
            cell = [[DriverInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell test];
        
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

//保存按钮的响应
-(void)saveBtnClicked:(UIButton *)btn{
    
}

@end
