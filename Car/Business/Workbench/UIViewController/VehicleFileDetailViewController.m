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


@end

@implementation VehicleFileDetailViewController

#pragma mark  ----  懒加载

-(UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maintenanceRecordsViewTaped:)];
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
    
    [super viewDidLoad];
    [self drawUI];
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell test];
        
        return cell;
    }
    else if (indexPath.row == 1){
        
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

    self.view.backgroundColor = Color_F3F3F3;
    self.viewState = ViewState_show;
    [self.navigationbar addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.offset(22);
        make.right.offset(-13);
        make.bottom.offset(-12);
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
    
    self.maintenanceRecordsLabel.text = @"维修记录(10)";
    
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
        self.maintenanceRecordsView.hidden = YES;
        self.bottomView.hidden = NO;
    }
    else if (self.viewState == ViewState_edit){
        
        self.viewState = ViewState_show;
        self.maintenanceRecordsView.hidden = NO;
        self.bottomView.hidden = YES;
    }
    
    btn.userInteractionEnabled = YES;
}


//去维修记录页面
-(void)maintenanceRecordsViewTaped:(UIGestureRecognizer *)gesture{
    
    OneCarMaintenanceRecordsViewController * vc = [[OneCarMaintenanceRecordsViewController alloc] initWithTitle:@"维修记录" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
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
