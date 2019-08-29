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

@end

@implementation MaintenanceRecordsDetailViewController

#pragma mark  ----  懒加载

-(UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        
        //删除按钮
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundColor:Color_F23E3E];
        deleteBtn.titleLabel.font = FONT16;
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:deleteBtn];
        //保存按钮
        UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setBackgroundColor:Color_0072FF];
        saveBtn.titleLabel.font = FONT16;
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
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
        
        cellHeight = [MaintenanceLogCell cellHeight];
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell test];
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellId = @"MaintenanceLogCell";
        MaintenanceLogCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[MaintenanceLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell test];
        return cell;
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.viewState = ViewState_show;
    [self.navigationbar addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.offset(22);
        make.right.offset(-13);
        make.bottom.offset(-12);
    }];
    
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.offset(-44);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.offset(44);
    }];
}

//编辑按钮的响应
-(void)editBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    if (self.viewState == ViewState_show) {
        
        self.viewState = ViewState_edit;
    }
    else if (self.viewState == ViewState_edit){
        
        self.viewState = ViewState_show;
    }
    
    btn.userInteractionEnabled = YES;
}

//删除按钮的响应
-(void)deleteBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = NO;
}

//保存按钮的响应
-(void)saveBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    btn.userInteractionEnabled = NO;
}


@end
