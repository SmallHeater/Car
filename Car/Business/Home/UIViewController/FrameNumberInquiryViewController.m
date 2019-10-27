//
//  FrameNumberInquiryViewController.m
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FrameNumberInquiryViewController.h"
#import "SHImageAndTitleBtn.h"
#import "FrameNumberTF.h"
#import "BaseWKWebViewController.h"
#import "FrameNumberCell.h"
#import "CarInfoModel.h"

static NSString * cellId = @"FrameNumberCell";

@interface FrameNumberInquiryViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView * tableHeaderView;
//车辆信息模型
@property (nonatomic,strong) CarInfoModel * carInfoModel;
//车架号
@property (nonatomic,strong) NSString * vin;

@end

@implementation FrameNumberInquiryViewController


#pragma mark  ----  懒加载

-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 158)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        FrameNumberTF * searchTF = [[FrameNumberTF alloc] init];
        searchTF.delegate = self;
        searchTF.placeholder = @"请输入车架号";
        searchTF.font = FONT14;
        searchTF.textColor = Color_333333;
        __weak typeof(self) weakSelf = self;
        searchTF.callBack = ^{
          
            if (![NSString strIsEmpty:searchTF.text] && searchTF.text.length == 17) {
                
                weakSelf.vin = searchTF.text;
            }
            else{
                
                [MBProgressHUD wj_showError:@"请输入正确的车架号"];
            }
        };
        
        [_tableHeaderView addSubview:searchTF];
        [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.top.offset(17);
            make.right.offset(-15);
            make.height.offset(40);
        }];
        
        //按钮宽度
        float btnWidth = 50;
        //左右间隔
        float leftInterVal = 15;
        //按钮间隔
        float btnInterval = (MAINWIDTH - leftInterVal * 2 - btnWidth * 5) / 4;
        //买配件按钮
        SHImageAndTitleBtn * maipeijianBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 37, btnWidth, 12) andImageName:@"maipeijian" andSelectedImageName:@"maipeijian" andTitle:@"买配件"];
        [maipeijianBtn refreshFont:FONT12];
        [maipeijianBtn refreshTitle:@"买配件" color:Color_666666];
        [[maipeijianBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            NSString * urlStr = @"https://xcbb.xcx.zyxczs.com/mobile.php?phone=18737510089";
            BaseWKWebViewController * vc = [[BaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [_tableHeaderView addSubview:maipeijianBtn];
        [maipeijianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(leftInterVal);
            make.bottom.offset(-29);
            make.width.offset(btnWidth);
            make.height.offset(49);
        }];
        
        //维修记录按钮
        SHImageAndTitleBtn * weixiujiluBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 37, btnWidth, 12) andImageName:@"weixiujilu" andSelectedImageName:@"weixiujilu" andTitle:@"维修记录"];
        [weixiujiluBtn refreshFont:FONT12];
        [weixiujiluBtn refreshTitle:@"维修记录" color:Color_666666];
        [[weixiujiluBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [MBProgressHUD wj_showError:@"暂未开放"];
        }];
        [_tableHeaderView addSubview:weixiujiluBtn];
        [weixiujiluBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(maipeijianBtn.mas_right).offset(btnInterval);
            make.bottom.offset(-29);
            make.width.offset(btnWidth);
            make.height.offset(49);
        }];
        
        //出险记录按钮
        SHImageAndTitleBtn * chuxianjiluBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 37, btnWidth, 12) andImageName:@"fasongjilu" andSelectedImageName:@"fasongjilu" andTitle:@"出险记录"];
        [chuxianjiluBtn refreshFont:FONT12];
        [chuxianjiluBtn refreshTitle:@"出险记录" color:Color_666666];
        [[chuxianjiluBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [MBProgressHUD wj_showError:@"暂未开放"];
        }];
        [_tableHeaderView addSubview:chuxianjiluBtn];
        [chuxianjiluBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weixiujiluBtn.mas_right).offset(btnInterval);
            make.bottom.offset(-29);
            make.width.offset(btnWidth);
            make.height.offset(49);
        }];
        
        //车况查询按钮
        SHImageAndTitleBtn * chekuangchaxunBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 37, btnWidth, 12) andImageName:@"daishouchaxun" andSelectedImageName:@"daishouchaxun" andTitle:@"车况查询"];
        [chekuangchaxunBtn refreshFont:FONT12];
        [chekuangchaxunBtn refreshTitle:@"车况查询" color:Color_666666];
        [[chekuangchaxunBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [MBProgressHUD wj_showError:@"暂未开放"];
        }];
        [_tableHeaderView addSubview:chekuangchaxunBtn];
        [chekuangchaxunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(chuxianjiluBtn.mas_right).offset(btnInterval);
            make.bottom.offset(-29);
            make.width.offset(btnWidth);
            make.height.offset(49);
        }];
        
        //原厂数据按钮
        SHImageAndTitleBtn * yuanchangshujuBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 37, btnWidth, 12) andImageName:@"yewuhuifang" andSelectedImageName:@"yewuhuifang" andTitle:@"原厂数据"];
        [yuanchangshujuBtn refreshFont:FONT12];
        [yuanchangshujuBtn refreshTitle:@"原厂数据" color:Color_666666];
        [[yuanchangshujuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [MBProgressHUD wj_showError:@"暂未开放"];
        }];
        [_tableHeaderView addSubview:yuanchangshujuBtn];
        [yuanchangshujuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(chekuangchaxunBtn.mas_right).offset(btnInterval);
            make.bottom.offset(-29);
            make.width.offset(btnWidth);
            make.height.offset(49);
        }];
        
        //分割
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = Color_EEEEEE;
        [_tableHeaderView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.offset(0);
            make.height.offset(10);
        }];
    }
    return _tableHeaderView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [self createData];
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self addRAC];
}

#pragma mark  ----  代理

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    if (![NSString strIsEmpty:textField.text] && textField.text.length == 17) {
        
        self.vin = textField.text;
    }
    else{
        
        [MBProgressHUD wj_showError:@"请输入正确的车架号"];
    }
    return YES;
}


#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FrameNumberCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[FrameNumberCell alloc] initWithReuseIdentifier:cellId];
    }
    
    NSString * content = @"";
    if (self.carInfoModel) {
        
        if (indexPath.row == 0) {
            
            content = self.carInfoModel.manufacturer;
        }
        else if (indexPath.row == 1){
            
            content = self.carInfoModel.brand;
        }
        else if (indexPath.row == 2){
            
            content = self.carInfoModel.cartype;
        }
        else if (indexPath.row == 3){
            
            content = self.carInfoModel.name;
        }
        else if (indexPath.row == 4){
            
            content = self.carInfoModel.yeartype;
        }
        else if (indexPath.row == 5){
         
            content = self.carInfoModel.environmentalstandards;
        }
        else if (indexPath.row == 6){
            
            content = self.carInfoModel.comfuelconsumption;
        }
        else if (indexPath.row == 7){
            
            content = self.carInfoModel.engine;
        }
        else if (indexPath.row == 8){
            
            content = self.carInfoModel.gearbox;
        }
        else if (indexPath.row == 9){
            
            content = self.carInfoModel.drivemode;
        }
        else if (indexPath.row == 10){
            
            content = self.carInfoModel.carbody;
        }
        else if (indexPath.row == 11){
            
            content = self.carInfoModel.fronttiresize;
        }
        else if (indexPath.row == 12){
         
            content = self.carInfoModel.reartiresize;
        }
    }
    
    [cell showTitle:self.dataArray[indexPath.row] andContent:content];
    
    return cell;
}

#pragma mark  ----  自定义函数
-(void)drawUI{
    
    [self.view addSubview:self.tableHeaderView];
    [self.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.height.offset(158);
    }];
    [self.view bringSubviewToFront:self.navigationbar];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.tableHeaderView.mas_bottom);
    }];
}

-(void)createData{
    
    [self.dataArray addObject:@"厂家名称"];
    [self.dataArray addObject:@"品牌"];
    [self.dataArray addObject:@"车型"];
    [self.dataArray addObject:@"名称"];
    [self.dataArray addObject:@"年款"];
    [self.dataArray addObject:@"排放标准"];
    [self.dataArray addObject:@"油耗"];
    [self.dataArray addObject:@"发动机"];
    [self.dataArray addObject:@"变速箱"];
    [self.dataArray addObject:@"驱动方式"];
    [self.dataArray addObject:@"车身形式"];
    [self.dataArray addObject:@"前轮胎尺寸"];
    [self.dataArray addObject:@"后轮胎尺寸"];
}

-(void)addRAC{
    
    __weak typeof(self) weakSelf = self;
    [[self rac_valuesForKeyPath:@"vin" observer:self] subscribeNext:^(id  _Nullable x) {
       
        if (![NSString strIsEmpty:x]) {
            
            [weakSelf requestData];
        }
    }];
}

-(void)requestData{
    
    NSString * url = [[NSString alloc] initWithFormat:@"https://api.jisuapi.com/vin/query?appkey=511c775e40ea6171&vin=%@",self.vin];
    NSDictionary * configurationDic = @{@"requestUrlStr":url,@"requestType":[NSNumber numberWithInt:1]};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"result"];
                //成功
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    
                    weakSelf.carInfoModel = [CarInfoModel mj_objectWithKeyValues:dataDic];
                    [weakSelf.tableView reloadData];
                }
                else{
                    
                    //异常
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

@end
