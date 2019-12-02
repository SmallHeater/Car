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

@property (nonatomic,assign) PostListVCType vcType;
@property (nonatomic,strong) NSString * sectionId;
@property (nonatomic,strong) NSString * userId;
@property (nonatomic,assign) NSUInteger page;

@end

@implementation PostListViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style andIsShowHead:YES andIsShowFoot:YES];
    if (self) {
        
        self.vcType = PostListVCType_tieziliebiao;
        self.sectionId = [NSString repleaseNilOrNull:sectionId];
    }
    return self;
}

//用户的帖子列表
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andUserId:(NSString *)userId{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style andIsShowHead:YES andIsShowFoot:YES];
    if (self) {
        
        self.vcType = PostListVCType_wodetieziliebiao;
        self.userId = [NSString repleaseNilOrNull:userId];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    self.page = 1;
    if (self.vcType == PostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == PostListVCType_wodetieziliebiao){
        
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
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"section_id":self.sectionId,@"page":[NSString stringWithFormat:@"%ld",self.page]};
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
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        if (weakSelf.page == 1) {
                            
                            [weakSelf.dataArray removeAllObjects];
                        }
                        NSArray * array = dataDic[@"articles"];
                        
                        if (array.count == MAXCOUNT) {
                            
                            weakSelf.page++;
                        }
                        else if (array.count == 0){
                            
                            [MBProgressHUD wj_showError:@"没有更多数据啦"];
                        }
                        
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
    
    NSDictionary * bodyParameters = @{@"user_id":self.userId,@"page":[NSString stringWithFormat:@"%ld",self.page]};
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
                
                if (weakSelf.page == 1) {
                    
                    [weakSelf.dataArray removeAllObjects];
                }

                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        NSArray * array = dataDic[@"articles"];
                        if (array.count == MAXCOUNT) {
                                           
                               weakSelf.page++;
                           }
                           else{
                               
                               weakSelf.tableView.mj_footer = nil;
                           }
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

//下拉刷新
-(void)loadNewData{
    
    self.page = 1;
   if (self.vcType == PostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == PostListVCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
    
    [super loadNewData];
}
//上拉加载
-(void)loadMoreData{
    
    if (self.vcType == PostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == PostListVCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
    
    [super loadMoreData];
}

@end
