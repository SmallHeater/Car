//
//  ResidualTransactionDetailViewController.m
//  Car
//
//  Created by xianjun wang on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionDetailViewController.h"
#import "SHImageAndTitleBtn.h"
#import "ResidualTransactionCarouseCell.h"
#import "ResidualTransactionTitleCell.h"
#import "ResidualTransactionAuthenticationCell.h"
#import "ResidualTransactionServiceDetailsCell.h"
#import "ResidualTransactionMerchantCell.h"
#import "ResidualTransactionComplaintCell.h"
#import "DetailBottomView.h"
#import "UserInforController.h"

static NSString * ResidualTransactionCarouseCellID = @"ResidualTransactionCarouseCell";
static NSString * ResidualTransactionTitleCellID = @"ResidualTransactionTitleCell";
static NSString * ResidualTransactionAuthenticationCellID = @"ResidualTransactionAuthenticationCell";
static NSString * ResidualTransactionServiceDetailsCellID = @"ResidualTransactionServiceDetailsCell";
static NSString * ResidualTransactionMerchantCellID = @"ResidualTransactionMerchantCell";
static NSString * ResidualTransactionComplaintCellID = @"ResidualTransactionComplaintCell";

@interface ResidualTransactionDetailViewController ()

//底部 view
@property (nonatomic,strong) DetailBottomView * bottomView;
@property (nonatomic,strong) ResidualTransactionModel * model;

@end

@implementation ResidualTransactionDetailViewController

#pragma mark  ----  懒加载

-(DetailBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[DetailBottomView alloc] init];
        [_bottomView refreshCollectinState:self.model.markered];
        __weak typeof(self) weakSelf = self;
        [[_bottomView rac_signalForSelector:@selector(collectBtnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            //收藏的响应
            NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"id":weakSelf.model.RTId};
            NSDictionary * configurationDic = @{@"requestUrlStr":HandedGoodMarkered,@"bodyParameters":bodyParameters};
            [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
                
                if (![resultDic.allKeys containsObject:@"error"]) {
                    
                    //成功的
                    NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                    if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                        
                        weakSelf.model.markered = !weakSelf.model.markered;
                    }
                    else{
                    }
                }
                else{
                    
                    //失败的
                }
            }];
        }];
        [[_bottomView rac_signalForSelector:@selector(phoneBtnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            NSString * telStr = [NSString stringWithFormat:@"tel:%@",weakSelf.model.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }];
    }
    return _bottomView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andModel:(ResidualTransactionModel *)model{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = [ResidualTransactionCarouseCell cellHeight];
    }
    else if (indexPath.row == 1){
        
        cellHeight = 73;
    }
    else if (indexPath.row == 2){
        
        cellHeight = 32;
    }
    else if (indexPath.row == 3){
        
        cellHeight = [ResidualTransactionServiceDetailsCell cellHeightWithStr:@""];
    }
    else if (indexPath.row == 4){
        
        cellHeight = 108;
    }
    else if (indexPath.row == 5){
        
        cellHeight = 80;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ResidualTransactionCarouseCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionCarouseCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionCarouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionCarouseCellID];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [cell show:[self.model.images componentsSeparatedByString:@","]];
        });
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        ResidualTransactionTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionTitleCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionTitleCellID];
            NSString * telStr = [NSString stringWithFormat:@"tel:%@",self.model.phone];
            [[cell rac_signalForSelector:@selector(callImageViewTaped)] subscribeNext:^(RACTuple * _Nullable x) {
               
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }];
        }
        
        [cell showTitle:self.model.name price:self.model.money];
        return cell;
    }
    else if(indexPath.row == 2){
        
        ResidualTransactionAuthenticationCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionAuthenticationCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionAuthenticationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionAuthenticationCellID];
        }
        
        return cell;
    }
    else if (indexPath.row == 3){
        
        ResidualTransactionServiceDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionServiceDetailsCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionServiceDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionServiceDetailsCellID];
        }
        
        [cell show:self.model.RTDescription];
        return cell;
    }
    else if (indexPath.row == 4){
        
        ResidualTransactionMerchantCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionMerchantCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionMerchantCellID];
        }
        
        NSDictionary * dic = @{@"shop_avatar":self.model.shop_avatar,@"shop_name":self.model.shop_name,@"shop_phone":self.model.shop_phone,@"shop_credit":self.model.shop_credit};
        [cell showDic:dic];
        return cell;
    }
    else if (indexPath.row == 5){
        
        ResidualTransactionComplaintCell * cell = [tableView dequeueReusableCellWithIdentifier:ResidualTransactionComplaintCellID];
        if (!cell) {
            
            cell = [[ResidualTransactionComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResidualTransactionComplaintCellID];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.bottom.offset(-50 - [SHUIScreenControl bottomSafeHeight]);
    }];
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-[SHUIScreenControl bottomSafeHeight]);
        make.height.offset(50);
    }];
}
@end
