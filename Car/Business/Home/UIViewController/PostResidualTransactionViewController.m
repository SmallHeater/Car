//
//  PostResidualTransactionViewController.m
//  Car
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostResidualTransactionViewController.h"
#import "PostJobInputCell.h"
#import "PostJobDescriptionCell.h"
#import "PostResidualTransactionRequestModel.h"
#import "UserInforController.h"
#import "PostResidualTransactionAmountCell.h"
#import "PostResidualTransactionImageCell.h"


static NSString * PostJobInputCellId = @"PostJobInputCell";
static NSString * PostResidualTransactionAmountCellId = @"PostResidualTransactionAmountCell";
static NSString * PostJobDescriptionCellId = @"PostJobDescriptionCell";
static NSString * PostResidualTransactionImageCellId = @"PostResidualTransactionImageCell";


@interface PostResidualTransactionViewController ()
//发布按钮
@property (nonatomic,strong) UIButton * postBtn;
@property (nonatomic,strong) PostResidualTransactionRequestModel * requestModel;
//cell添加的图片数
@property (nonatomic,assign) NSUInteger imageCount;
@property (nonatomic,strong) PostResidualTransactionImageCell * cell;

@end

@implementation PostResidualTransactionViewController

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
            if ([NSString strIsEmpty:weakSelf.requestModel.name]) {
                
                showStr = @"请输入标题";
            }
            else if ([NSString strIsEmpty:weakSelf.requestModel.money]){
                
                showStr = @"请输入金额";
            }
            else if ([NSString strIsEmpty:weakSelf.requestModel.RTdescription]){
                
                showStr = @"请输入商品介绍";
            }
            else if ([NSString strIsEmpty:weakSelf.requestModel.phone]){
                
                showStr = @"请输入手机号码";
            }
            else if (self.imageCount == 0){
                
                showStr = @"请上传照片";
            }
            
            if (showStr) {
                
                [MBProgressHUD wj_showError:showStr];
            }
            else{
                
                //让cell主动上传图片
                __weak typeof(self) weakSelf = self;
                [self.cell uploadImageCallBack:^(NSString *imagesUrl) {
                   
                    weakSelf.requestModel.images = imagesUrl;
                    [weakSelf postResidualTransaction];
                }];
            }
        }];
    }
    return _postBtn;
}

-(PostResidualTransactionRequestModel *)requestModel{
    
    if (!_requestModel) {
        
        _requestModel = [[PostResidualTransactionRequestModel alloc] init];
        _requestModel.user_id = [UserInforController sharedManager].userInforModel.userID;
    }
    return _requestModel;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row < 3) {
        
        cellHeight = 51;
    }
    else if (indexPath.row == 3){
        
        cellHeight = 89;
    }
    else if (indexPath.row == 4) {
        
        cellHeight = 430;
    }
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        PostJobInputCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobInputCellId];
        if (!cell) {
            
            cell = [[PostJobInputCell alloc] initWithReuseIdentifier:PostJobInputCellId andTitle:@"标       题" andPlaceholder:@"请输入标题" andShowBottomLine:YES];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.name = x;
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        PostResidualTransactionAmountCell * cell = [tableView dequeueReusableCellWithIdentifier:PostResidualTransactionAmountCellId];
        if (!cell) {
            
            cell = [[PostResidualTransactionAmountCell alloc] initWithReuseIdentifier:PostResidualTransactionAmountCellId andTitle:@"金      额" andShowBottomLine:YES];
            
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"isNegotiable" observer:self] subscribeNext:^(id  _Nullable x) {
                
                if ([x boolValue]) {
                    
                    weakSelf.requestModel.money = @"面议";
                }
            }];
            
            [[cell rac_valuesForKeyPath:@"amount" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.money = [[NSString alloc] initWithFormat:@"%.2f",[x floatValue]];
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 2){
        
        PostJobInputCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobInputCellId];
        if (!cell) {
            
            cell = [[PostJobInputCell alloc] initWithReuseIdentifier:PostJobInputCellId andTitle:@"手机号码" andPlaceholder:@"请输入手机号码" andShowBottomLine:YES];
            
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.phone = x;
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 3){
        
        PostJobDescriptionCell * cell = [tableView dequeueReusableCellWithIdentifier:PostJobDescriptionCellId];
        if (!cell) {
            
            cell = [[PostJobDescriptionCell alloc] initWithReuseIdentifier:PostJobDescriptionCellId andTitle:@"商品介绍" andShowBottomLine:YES];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"descrip" observer:self] subscribeNext:^(id  _Nullable x) {
                
                weakSelf.requestModel.RTdescription = x;
            }];
        }
        
        return cell;
    }
    else if (indexPath.row == 4){
        
        PostResidualTransactionImageCell * cell = [tableView dequeueReusableCellWithIdentifier:PostResidualTransactionImageCellId];
        if (!cell) {
            
            cell = [[PostResidualTransactionImageCell alloc] initWithReuseIdentifier:PostResidualTransactionImageCellId];
            self.cell = cell;
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"imageCount" observer:self] subscribeNext:^(id  _Nullable x) {
               
                weakSelf.imageCount = [x integerValue];
            }];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.view.backgroundColor = Color_F3F3F3;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.bottom.offset(-104 - [UIScreenControl bottomSafeHeight]);
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.postBtn];
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-25 - [UIScreenControl bottomSafeHeight]);
        make.height.offset(44);
    }];
}

//发布残值
-(void)postResidualTransaction{

    NSDictionary * bodyParameters = [self.requestModel mj_keyValues];
    NSDictionary * configurationDic = @{@"requestUrlStr":PostHandedGood,@"bodyParameters":bodyParameters};
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
