//
//  PostJobViewController.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobViewController.h"
#import "PostJobInputCell.h"
#import "PostJobMonthlySalaryCell.h"
#import "PostJobSelectCell.h"
#import "PostJobDescriptionCell.h"
#import "SHPickerView.h"
#import "PostJobRequestModel.h"
#import "UserInforController.h"
#import "WelfareTreatmentView.h"


static NSString * PostJobInputCellId = @"PostJobInputCell";
static NSString * PostJobMonthlySalaryCellId = @"PostJobMonthlySalaryCell";
static NSString * PostJobSelectCellId = @"PostJobSelectCell";
static NSString * PostJobDescriptionCellId = @"PostJobDescriptionCell";

#define PICKERBASETAG 1300

@interface PostJobViewController ()<SHPickerViewDelegate>

//发布按钮
@property (nonatomic,strong) UIButton * postBtn;
@property (nonatomic,strong) SHPickerView * pickerView;
//请求模型
@property (nonatomic,strong) PostJobRequestModel * postJobRequestModel;
//福利待遇cell
@property (nonatomic,strong) PostJobSelectCell * welfareTreatmentCell;
//福利待遇选择view
@property (nonatomic,strong) WelfareTreatmentView * welfareTreatmentView;
//职位类别cell
@property (nonatomic,strong) PostJobSelectCell * jobCell;
//学历要求cell
@property (nonatomic,strong) PostJobSelectCell * educationCell;
//工作年限cell
@property (nonatomic,strong) PostJobSelectCell * workingYearsCell;
//工作地点cell
@property (nonatomic,strong) PostJobSelectCell * workingPlaceCell;
//招聘参数字典
@property (nonatomic,strong) NSDictionary * jobOptionDic;
//福利待遇文字
@property (nonatomic,strong) NSMutableArray<NSDictionary *> * welfareTreatArray;

@end

@implementation PostJobViewController

#pragma mark  ----  懒加载

-(UIButton *)postBtn{
    
    if (!_postBtn) {
        
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.backgroundColor = Color_0072FF;
        _postBtn.layer.masksToBounds = YES;
        _postBtn.layer.cornerRadius = 5;
        [_postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_postBtn setTitle:@"发布" forState:UIControlStateNormal];
        _postBtn.titleLabel.font = FONT16;
        __weak typeof(self) weakSelf = self;
        [[_postBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            NSString * showStr;
            if ([NSString strIsEmpty:weakSelf.postJobRequestModel.name]) {
                
                showStr = @"请输入标题";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.monthly_salary]){
                
                showStr = @"请输入月薪";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.benefit_ids]){
                
                showStr = @"请选择福利待遇";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.job_id]){
                
                showStr = @"请选择职位类别";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.jobDescription]){
                
                showStr = @"请输入职位描述";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.education_id]){
                
                showStr = @"请选择学历要求";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.experience_id]){
                
                showStr = @"请选择工作年限";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.workplace_id]){
                
                showStr = @"请选择工作地点";
            }
            else if ([NSString strIsEmpty:weakSelf.postJobRequestModel.phone]){
                
                showStr = @"请输入联系电话";
            }
            
            if (showStr) {
                
                [MBProgressHUD wj_showError:showStr];
            }
            else{
                
                [weakSelf postJob];
            }
        }];
    }
    return _postBtn;
}

-(NSMutableArray<NSDictionary *> *)welfareTreatArray{
    
    if (!_welfareTreatArray) {
        
        _welfareTreatArray = [[NSMutableArray alloc] init];
    }
    return _welfareTreatArray;
}

-(WelfareTreatmentView *)welfareTreatmentView{
    
    if (!_welfareTreatmentView) {
        
        _welfareTreatmentView = [[WelfareTreatmentView alloc] init];
    }
    return _welfareTreatmentView;
}

-(SHPickerView *)pickerView{
    
    if (!_pickerView) {
        
        _pickerView = [[SHPickerView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT) andTitle:@"选择时间" andComponent:1 andData:nil];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

-(PostJobRequestModel *)postJobRequestModel{
    
    if (!_postJobRequestModel) {
        
        _postJobRequestModel = [[PostJobRequestModel alloc] init];
        _postJobRequestModel.user_id = [UserInforController sharedManager].userInforModel.userID;
    }
    return _postJobRequestModel;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestJobOption];
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 4) {
        
        cellHeight = 89;
    }
    else{
        
        cellHeight = 51;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        PostJobInputCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobInputCellId];
        if (!cell) {
            
            cell = [[PostJobInputCell alloc] initWithReuseIdentifier:PostJobInputCellId andTitle:@"标       题" andPlaceholder:@"请输入标题" andShowBottomLine:YES];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
               
                weakSelf.postJobRequestModel.name = x;
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        PostJobMonthlySalaryCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobMonthlySalaryCellId];
        if (!cell) {
            
            cell = [[PostJobMonthlySalaryCell alloc] initWithReuseIdentifier:PostJobMonthlySalaryCellId andTitle:@"月       薪" andShowBottomLine:YES];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"isNegotiable" observer:self] subscribeNext:^(id  _Nullable x) {
                
                if ([x boolValue]) {
                 
                    weakSelf.postJobRequestModel.monthly_salary = @"面议";
                }
            }];
            
            //最低工资
            [[cell rac_valuesForKeyPath:@"minimumWage" observer:self] subscribeNext:^(id  _Nullable x) {
                
                NSString * monthly_salary = weakSelf.postJobRequestModel.monthly_salary;
                if ([NSString strIsEmpty:monthly_salary]) {
                    
                    weakSelf.postJobRequestModel.monthly_salary = [[NSString alloc] initWithFormat:@"%ld -",[x integerValue]];
                }
                else if([monthly_salary containsString:@"-"]){
                    
                    //修改
                    NSRange rangge = [monthly_salary rangeOfString:@"-"];
                    NSString * repleaseStr = [monthly_salary substringWithRange:NSMakeRange(0, rangge.location)];
                    NSString * usedStr = [[NSString alloc] initWithFormat:@"%ld -",[x integerValue]];
                    weakSelf.postJobRequestModel.monthly_salary = [monthly_salary stringByReplacingOccurrencesOfString:repleaseStr withString:usedStr];
                }
                else{
                    
                    //插入最低工资
                    NSString * usedStr = [[NSString alloc] initWithFormat:@"%ld -",[x integerValue]];
                    weakSelf.postJobRequestModel.monthly_salary = [[NSString alloc] initWithFormat:@"%@%@",usedStr,monthly_salary];
                }
            }];
            
            //最高工资
            [[cell rac_valuesForKeyPath:@"maximumWage" observer:self] subscribeNext:^(id  _Nullable x) {
                
                NSString * monthly_salary = weakSelf.postJobRequestModel.monthly_salary;
                if ([NSString strIsEmpty:monthly_salary]) {
                    
                    weakSelf.postJobRequestModel.monthly_salary = [[NSString alloc] initWithFormat:@"%ld",[x integerValue]];
                }
                else if([monthly_salary containsString:@"-"]){
                    
                    //修改或者插入
                    NSRange range = [monthly_salary rangeOfString:@"-"];
                    NSString * repleaseStr = [monthly_salary substringWithRange:NSMakeRange(range.location, monthly_salary.length - range.location)];
                    NSString * usedStr = [[NSString alloc] initWithFormat:@"- %ld",[x integerValue]];
                    weakSelf.postJobRequestModel.monthly_salary = [monthly_salary stringByReplacingOccurrencesOfString:repleaseStr withString:usedStr];
                }
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        PostJobSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobSelectCellId];
        if (!cell) {
            
            cell = [[PostJobSelectCell alloc] initWithReuseIdentifier:PostJobSelectCellId andTitle:@"福利待遇" andPlaceholder:@"选择提供的福利，如包吃包住" andShowBottomLine:YES];
            self.welfareTreatmentCell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(selectLabelTaped)] subscribeNext:^(RACTuple * _Nullable x) {
               
                [weakSelf.view endEditing:YES];
                [weakSelf.welfareTreatmentView show:weakSelf.jobOptionDic[@"benefit"]];
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.welfareTreatmentView];
                [weakSelf.welfareTreatmentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.top.bottom.offset(0);
                }];
            }];
            
            [[self.welfareTreatmentView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
                
                UIButton * btn = x.first;
                NSString * title = btn.currentTitle;
                for (NSDictionary * dic in weakSelf.jobOptionDic[@"benefit"]) {
                    
                    if ([title isEqualToString:dic[@"name"]]) {
                        
                        if (btn.isSelected) {
                            
                            //添加
                            [weakSelf.welfareTreatArray addObject:dic];
                            
                        }
                        else{
                            
                            //删除
                            [weakSelf.welfareTreatArray removeObject:dic];
                        }
                        break;
                    }
                }
            }];
            
            [[self.welfareTreatmentView rac_signalForSelector:@selector(closeBtnClicked)] subscribeNext:^(RACTuple * _Nullable x) {
            
                [weakSelf.welfareTreatArray removeAllObjects];
            }];

            [[self.welfareTreatmentView rac_signalForSelector:@selector(finishBtnClicked)] subscribeNext:^(RACTuple * _Nullable x) {
                
                NSMutableString * str = [[NSMutableString alloc] init];
                NSMutableArray * idArray = [[NSMutableArray alloc] init];
                for (NSDictionary * dic in weakSelf.welfareTreatArray) {
                    
                    [str appendString:dic[@"name"]];
                    [str appendString:@","];
                    [idArray addObject:dic[@"id"]];
                }
                
                str = [str substringToIndex:str.length - 1];
                [cell refreshLabel:str];
                
                weakSelf.postJobRequestModel.benefit_ids = [idArray componentsJoinedByString:@","];
            }];
        }
        return cell;
    }
    else if (indexPath.row == 3){
        
        PostJobSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobSelectCellId];
        if (!cell) {
            
            cell = [[PostJobSelectCell alloc] initWithReuseIdentifier:PostJobSelectCellId andTitle:@"职位类别" andPlaceholder:@"选择职位类别" andShowBottomLine:YES];
            self.jobCell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(selectLabelTaped)] subscribeNext:^(RACTuple * _Nullable x) {
                
                [weakSelf.view endEditing:YES];
                NSMutableArray * dicArray = [[NSMutableArray alloc] init];
                for (NSDictionary * dic in weakSelf.jobOptionDic[@"job"]) {
                    
                    NSDictionary * valueDic = [[NSDictionary alloc] initWithObjectsAndKeys:dic[@"name"],@"title",dic[@"id"],@"key", nil];
                    [dicArray addObject:valueDic];
                }
                weakSelf.pickerView.data = dicArray;
                weakSelf.pickerView.tag = PICKERBASETAG + 1;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.pickerView];
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 4){
        
        PostJobDescriptionCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobDescriptionCellId];
        if (!cell) {
            
            cell = [[PostJobDescriptionCell alloc] initWithReuseIdentifier:PostJobDescriptionCellId andTitle:@"职位描述" andShowBottomLine:YES];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"descrip" observer:self] subscribeNext:^(id  _Nullable x) {
                
               weakSelf.postJobRequestModel.jobDescription = x;
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 5){
        
        PostJobSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobSelectCellId];
        if (!cell) {
            
            cell = [[PostJobSelectCell alloc] initWithReuseIdentifier:PostJobSelectCellId andTitle:@"学历要求" andPlaceholder:@"选择学历要求" andShowBottomLine:YES];
            self.educationCell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(selectLabelTaped)] subscribeNext:^(RACTuple * _Nullable x) {
                
                [weakSelf.view endEditing:YES];
                NSMutableArray * dicArray = [[NSMutableArray alloc] init];
                for (NSDictionary * dic in weakSelf.jobOptionDic[@"education"]) {
                    
                    NSDictionary * valueDic = [[NSDictionary alloc] initWithObjectsAndKeys:dic[@"name"],@"title",dic[@"id"],@"key", nil];
                    [dicArray addObject:valueDic];
                }
                weakSelf.pickerView.data = dicArray;
                weakSelf.pickerView.tag = PICKERBASETAG + 2;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.pickerView];
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 6){
        
        PostJobSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobSelectCellId];
        if (!cell) {
            
            cell = [[PostJobSelectCell alloc] initWithReuseIdentifier:PostJobSelectCellId andTitle:@"工作年限" andPlaceholder:@"选择工作年限" andShowBottomLine:YES];
            self.workingYearsCell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(selectLabelTaped)] subscribeNext:^(RACTuple * _Nullable x) {
                
                [weakSelf.view endEditing:YES];
                NSMutableArray * dicArray = [[NSMutableArray alloc] init];
                for (NSDictionary * dic in weakSelf.jobOptionDic[@"experience"]) {
                    
                    NSDictionary * valueDic = [[NSDictionary alloc] initWithObjectsAndKeys:dic[@"name"],@"title",dic[@"id"],@"key", nil];
                    [dicArray addObject:valueDic];
                }
                weakSelf.pickerView.data = dicArray;
                weakSelf.pickerView.tag = PICKERBASETAG + 3;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.pickerView];
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 7){
        
        PostJobSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobSelectCellId];
        if (!cell) {
            
            cell = [[PostJobSelectCell alloc] initWithReuseIdentifier:PostJobSelectCellId andTitle:@"工作地点" andPlaceholder:@"选择工作地点" andShowBottomLine:YES];
            self.workingPlaceCell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(selectLabelTaped)] subscribeNext:^(RACTuple * _Nullable x) {
                
                [weakSelf.view endEditing:YES];
                NSMutableArray * dicArray = [[NSMutableArray alloc] init];
                for (NSDictionary * dic in weakSelf.jobOptionDic[@"workplace"]) {
                    
                    NSDictionary * valueDic = [[NSDictionary alloc] initWithObjectsAndKeys:dic[@"name"],@"title",dic[@"id"],@"key", nil];
                    [dicArray addObject:valueDic];
                }
                weakSelf.pickerView.data = dicArray;
                weakSelf.pickerView.tag = PICKERBASETAG + 4;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.pickerView];
            }];
        }
        
        return cell;
    }
    if (indexPath.row == 8) {
        
        PostJobInputCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobInputCellId];
        if (!cell) {
            
            cell = [[PostJobInputCell alloc] initWithReuseIdentifier:PostJobInputCellId andTitle:@"联系电话" andPlaceholder:@"请输入联系电话" andShowBottomLine:YES];

            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(textFieldShouldBeginEditing:)] subscribeNext:^(RACTuple * _Nullable x) {
               
                //弹出键盘
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.offset(-300);
                    }];
                }];
            }];
            [[cell rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.postJobRequestModel.phone = x;
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.offset(104 + [SHUIScreenControl bottomSafeHeight]);
                    }];
                }];
            }];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  SHPickerViewDelegate

-(void)picker:(SHPickerView *)picker didSelectedArray:(NSMutableArray *)selectDicArray{
    
    if (selectDicArray.count > 0) {
     
        NSDictionary * dic = selectDicArray[0];
        switch (picker.tag - PICKERBASETAG) {
            case 0:
            {
                
                break;
            }
            case 1:
            {
                
                //职位类别
                NSNumber * number = dic[@"key"];
                self.postJobRequestModel.job_id = [[NSString alloc] initWithFormat:@"%ld",number.integerValue];
                [self.jobCell refreshLabel:dic[@"title"]];
                break;
            }
            case 2:
            {
                
                //学历要求
                NSNumber * number = dic[@"key"];
                self.postJobRequestModel.education_id = [[NSString alloc] initWithFormat:@"%ld",number.integerValue];
                [self.educationCell refreshLabel:dic[@"title"]];
                break;
            }
            case 3:
            {
                
                //工作年限
                NSNumber * number = dic[@"key"];
                self.postJobRequestModel.experience_id = [[NSString alloc] initWithFormat:@"%ld",number.integerValue];
                [self.workingYearsCell refreshLabel:dic[@"title"]];
                break;
            }
            case 4:
            {
             
                //工作地点
                NSNumber * number = dic[@"key"];
                self.postJobRequestModel.workplace_id = [[NSString alloc] initWithFormat:@"%ld",number.integerValue];
                [self.workingPlaceCell refreshLabel:dic[@"title"]];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark  ----  自定义函数

-(void)drawUI{
     
    self.view.backgroundColor = Color_F3F3F3;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.bottom.offset(104 + [SHUIScreenControl bottomSafeHeight]);
    }];

    
    [self.view addSubview:self.postBtn];
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-25 - [SHUIScreenControl bottomSafeHeight]);
        make.height.offset(44);
    }];
}

-(void)requestJobOption{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":JobOption,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    NSDictionary * dataDic = dic[@"data"];
                    weakSelf.jobOptionDic = dataDic;
                }
                else{
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

//发布招聘
-(void)postJob{
    
    NSDictionary * bodyParameters = [self.postJobRequestModel mj_keyValues];
    NSDictionary * configurationDic = @{@"requestUrlStr":PostJob,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    [MBProgressHUD wj_showSuccess:dic[@"msg"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                        [weakSelf backBtnClicked:nil];
                    });
                }
                else{
                    
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

@end
