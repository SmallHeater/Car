//
//  MineViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadCell.h"
#import "MineColumnCell.h"
#import "UserInforController.h"
#import "PersonalInformationVC.h"
#import "OilPurchaseRecordViewController.h"
#import "SHBaseWKWebViewController.h"
#import "PostManagementViewController.h"
#import "AboutViewController.h"

static NSString * MineHeadCellID = @"MineHeadCell";
static NSString * MineColumnCellID = @"MineColumnCell";

@interface MineViewController ()

@end

@implementation MineViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 318;
    }
    else{
        
        cellHeight = 61;
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        PersonalInformationVC * vc = [[PersonalInformationVC alloc] initWithTitle:@"个人资料" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1){
        
        PostManagementViewController * vc = [[PostManagementViewController alloc] initWithTitle:@"帖子管理" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2){
        
        OilPurchaseRecordViewController * vc = [[OilPurchaseRecordViewController alloc] initWithTitle:@"机油采购记录" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3){
        
        //关于
        AboutViewController * vc = [[AboutViewController alloc] initWithTitle:@"关于平台" andIsShowBackBtn:YES];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        MineHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:MineHeadCellID];
        if (!cell) {
            
            cell = [[MineHeadCell alloc] initWithReuseIdentifier:MineHeadCellID];
        }
        
        [cell show:[UserInforController sharedManager].userInforModel];
        return cell;
    }
    else{
        
        MineColumnCell * cell = [tableView dequeueReusableCellWithIdentifier:MineColumnCellID];
        if (!cell) {
            
            cell = [[MineColumnCell alloc] initWithReuseIdentifier:MineColumnCellID andCount:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSDictionary * dic = self.dataArray[indexPath.row - 1];
        [cell show:dic[@"iconImage"] andTitle:dic[@"title"]];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.offset(-20);
    }];
}

//创造数据
-(void)createData{
    
    //上线暂时注释
//    NSDictionary * firstDic = @{@"iconImage":@"xiaoxi",@"title":@"我的消息"};
    NSDictionary * secondDic = @{@"iconImage":@"tiezi",@"title":@"帖子管理"};
//    NSDictionary * thirdDic = @{@"iconImage":@"fanxian",@"title":@"机油返现"};
    NSDictionary * forthDic = @{@"iconImage":@"jilu",@"title":@"采购记录"};
    NSDictionary * fifthDic = @{@"iconImage":@"guanyu",@"title":@"关于平台"};
//    [self.dataArray addObject:firstDic];
    [self.dataArray addObject:secondDic];
//    [self.dataArray addObject:thirdDic];
    [self.dataArray addObject:forthDic];
    [self.dataArray addObject:fifthDic];
}

-(void)requestListData{
 
    //发起请求
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetUserInfo,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                NSDictionary * staffDic = dataDic[@"staff"];
                UserInforModel * userInforModel = [UserInforModel mj_objectWithKeyValues:staffDic];
                [UserInforController sharedManager].userInforModel = userInforModel;
                [weakSelf.tableView reloadData];
                NSDictionary * userInforDic = [userInforModel mj_keyValues];
                //缓存用户信息模型字典
                [SHRoutingComponent openURL:CACHEDATA withParameter:@{@"CacheKey":USERINFORMODELKEY,@"CacheData":userInforDic}];
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
