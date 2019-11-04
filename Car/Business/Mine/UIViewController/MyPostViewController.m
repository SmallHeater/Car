//
//  MyPostViewController.m
//  Car
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MyPostViewController.h"
#import "ForumArticleModel.h"
#import "CarItemVideoCell.h"
#import "ForumDetailViewController.h"
#import "CarItemSingleCell.h"
#import "CarItemThreeCell.h"
#import "CarItemVideoCell.h"
#import "UserInforController.h"
#import "CarItemTextCell.h"


static NSString * CarItemTextCellId = @"CarItemTextCell";
static NSString * CarItemSingleCellID = @"CarItemSingleCell";
static NSString * CarItemVideoCellID = @"CarItemVideoCell";
static NSString * CarItemThreeCellID = @"CarItemThreeCell";

@interface MyPostViewController ()

@end

@implementation MyPostViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    ForumArticleModel * model = self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"zero"]) {
        
        cellHeight = [CarItemTextCell cellHeight:model];
    }
    else if ([model.type isEqualToString:@"single"]) {
        
        cellHeight = 130;
    }
    else if ([model.type isEqualToString:@"three"]) {
        
        cellHeight = 222;
    }
    else if ([model.type isEqualToString:@"video"]) {
        
        cellHeight = [CarItemVideoCell cellHeightWithTitle:model.title];
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumArticleModel * articleModel = self.dataArray[indexPath.row];
    ForumDetailViewController * vc = [[ForumDetailViewController alloc] initWithTitle:articleModel.section_title andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andModel:articleModel];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = self.dataArray.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumArticleModel * model = self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"zero"]) {
        
        CarItemTextCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemTextCellId];
        if (!cell) {
            
            cell = [[CarItemTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemTextCellId];
        }
        
        [cell show:model];
        return cell;
    }
    else if ([model.type isEqualToString:@"single"]) {
        
        CarItemSingleCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemSingleCellID];
        if (!cell) {
            
            cell = [[CarItemSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemSingleCellID];
        }
        
        [cell show:model];
        return cell;
    }
    else if ([model.type isEqualToString:@"three"]){
        
        CarItemThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemThreeCellID];
        if (!cell) {
            
            cell = [[CarItemThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemThreeCellID];
        }
        
        [cell show:model];
        return cell;
    }
    else if ([model.type isEqualToString:@"video"]){
        
        CarItemVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemVideoCellID];
        if (!cell) {
            
            cell = [[CarItemVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemVideoCellID];
        }
        
        [cell show:model];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)requestListData{
    
    //发起请求
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetMyForums,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                NSNumber * code = dic[@"code"];
                
                [weakSelf.dataArray removeAllObjects];
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        NSArray * arr = dataDic[@"articles"];
                        if (arr && [arr isKindOfClass:[NSArray class]]) {
                            
                            for (NSDictionary * dic in arr) {
                                
                                ForumArticleModel * model = [ForumArticleModel mj_objectWithKeyValues:dic];
                                [weakSelf.dataArray addObject:model];
                            }
                        }
                    }
                }
                else{
                    
                    //异常
                }
                [weakSelf.tableView reloadData];
                //如果内容少，则不滑动
                if (weakSelf.tableView.contentSize.height < weakSelf.tableView.bounds.size.height) {
                    
                    weakSelf.tableView.scrollEnabled = NO;
                }
                else{
                    
                    weakSelf.tableView.scrollEnabled = YES;
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
