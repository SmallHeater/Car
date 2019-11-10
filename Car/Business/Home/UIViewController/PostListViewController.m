//
//  PostListViewController.m
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostListViewController.h"
#import "PostListCell.h"
#import "UserInforController.h"
#import "ForumArticleModel.h"
#import "ForumDetailViewController.h"

static NSString * cellID = @"PostListCell";

@interface PostListViewController ()

@property (nonatomic,assign) VCType vcType;
@property (nonatomic,strong) NSString * sectionId;

@end

@implementation PostListViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId vcType:(VCType)vcType{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.vcType = vcType;
        if (vcType == VCType_tieziliebiao) {
         
            self.sectionId = [NSString repleaseNilOrNull:sectionId];
        }
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    
    if (self.vcType == VCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == VCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 129;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumArticleModel * articleModel = self.dataArray[indexPath.row];
    ForumDetailViewController * detailViewController = [[ForumDetailViewController alloc] initWithTitle:articleModel.section_title andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andArticleId:[NSString stringWithFormat:@"%ld",articleModel.ArticleId]];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[PostListCell alloc] initWithReuseIdentifier:cellID];
    }
    
    ForumArticleModel * model = self.dataArray[indexPath.row];
    //imageUrl,图片地址;title,标题;pv,NSNumber,浏览量;section_title,来源;
    NSString * imageUrl = @"";
    if (model.images && [model.images isKindOfClass:[NSArray class]] && model.images.count > 0) {
        
        imageUrl = model.images[0];
    }
    NSDictionary * dic = @{@"imageUrl":imageUrl,@"title":model.title,@"pv":[NSNumber numberWithInteger:model.pv],@"section_title":model.section_title};
    [cell show:dic];
    return cell;
}

#pragma mark  ----  自定义函数

-(void)requestData{
    
    //GetUserArticles
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"section_id":self.sectionId};
    NSDictionary * configurationDic = @{@"requestUrlStr":ForumList,@"bodyParameters":bodyParameters};
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
                        
                        NSArray * array = dataDic[@"articles"];
                        for (NSDictionary * dic in array) {
                            
                            ForumArticleModel * model = [ForumArticleModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                }
                else{
                    
                    //异常
                }
                
                [weakSelf.tableView reloadData];
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

-(void)requestMyArticleData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetUserArticles,@"bodyParameters":bodyParameters};
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
                        
                        NSArray * array = dataDic[@"articles"];
                        for (NSDictionary * dic in array) {
                            
                            ForumArticleModel * model = [ForumArticleModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                }
                else{
                    
                    //异常
                }
                
                [weakSelf.tableView reloadData];
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
