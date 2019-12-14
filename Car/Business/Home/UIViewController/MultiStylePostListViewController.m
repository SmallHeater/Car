//
//  PostListViewController.m
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MultiStylePostListViewController.h"
#import "UserInforController.h"
#import "ForumArticleModel.h"
#import "ForumDetailViewController.h"
#import "CarItemVideoCell.h"
#import "CarItemTextCell.h"
#import "CarItemSingleCell.h"
#import "CarItemThreeCell.h"

#import "ForumBaseCell.h"
#import "ForumSingleCell.h"
#import "PostListCell.h"
#import "ForumThreeCell.h"
#import "ForumVideoCell.h"

static NSString * CarItemTextCellId = @"CarItemTextCell";
static NSString * CarItemSingleCellID = @"CarItemSingleCell";
static NSString * CarItemVideoCellID = @"CarItemVideoCell";
static NSString * CarItemThreeCellID = @"CarItemThreeCell";

static NSString * ForumBaseCellId = @"ForumBaseCell";
static NSString * ForumSingleCellId = @"ForumSingleCell";
static NSString * PostListCellId = @"PostListCell";
static NSString * ForumThreeCellId = @"ForumThreeCell";
static NSString * ForumVideoCellId = @"ForumVideoCell";

@interface MultiStylePostListViewController ()

@property (nonatomic,assign) MultiStylePostListVCType vcType;
@property (nonatomic,strong) NSString * sectionId;
@property (nonatomic,assign) NSUInteger page;

@end

@implementation MultiStylePostListViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSectionId:(NSString *)sectionId vcType:(MultiStylePostListVCType)vcType{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style andIsShowHead:YES andIsShowFoot:YES];
    if (self) {
        
        self.vcType = vcType;
        if (vcType == MultiStylePostListVCType_tieziliebiao) {
         
            self.sectionId = [NSString repleaseNilOrNull:sectionId];
        }
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    self.page = 1;
    if (self.vcType == MultiStylePostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == MultiStylePostListVCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.vcType == MultiStylePostListVCType_tieziliebiao) {
    
        float cellHeight = 0;
        ForumArticleModel * articleModel = self.dataArray[indexPath.row];
        if ([articleModel.type isEqualToString:@"zero"]) {
            
            cellHeight = [ForumBaseCell cellHeightWithTitle:articleModel.title];
        }
        else if ([articleModel.type isEqualToString:@"single"]) {
            
            cellHeight = [ForumSingleCell cellHeightWithTitle:articleModel.title];
        }
        else if ([articleModel.type isEqualToString:@"single_left"]){
            
            cellHeight = 129;
        }
        else if ([articleModel.type isEqualToString:@"three"]){
            
            cellHeight = [ForumThreeCell cellHeightWithTitle:articleModel.title];
        }
        else if ([articleModel.type isEqualToString:@"video"]){
            
            cellHeight = [ForumVideoCell cellHeightWithTitle:articleModel.title];
        }
        return cellHeight;
    }
    else if (self.vcType == MultiStylePostListVCType_wodetieziliebiao){
        
        float cellHeight = 0;
        ForumArticleModel * model = self.dataArray[indexPath.row];
        if ([model.type isEqualToString:@"single"]) {
            
            cellHeight = 130;
        }
        else if ([model.type isEqualToString:@"three"]) {
            
            cellHeight = 222;
        }
        else if ([model.type isEqualToString:@"video"]) {
            
            cellHeight = [CarItemVideoCell cellHeightWithTitle:model.title];
        }
        else if ([model.type isEqualToString:@"zero"]){
            
            cellHeight = [CarItemTextCell cellHeight:model];
        }
        
        return cellHeight;
    }
    
    return 0;
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
    
    ForumArticleModel * model = self.dataArray[indexPath.row];
    if (self.vcType == MultiStylePostListVCType_tieziliebiao) {
        
        if ([model.type isEqualToString:@"zero"]) {
        
            ForumBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumBaseCellId];
            if (!cell) {
                
                cell = [[ForumBaseCell alloc] initWithReuseIdentifier:ForumBaseCellId];
            }
            
            [cell show:model];
            return cell;
        }
        else if ([model.type isEqualToString:@"single"]) {
            
            ForumSingleCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumSingleCellId];
            if (!cell) {
                
                cell = [[ForumSingleCell alloc] initWithReuseIdentifier:ForumSingleCellId];
            }
            
            [cell show:model];
            return cell;
        }
        else if ([model.type isEqualToString:@"single_left"]){
         
            PostListCell * cell = [tableView dequeueReusableCellWithIdentifier:PostListCellId];
            if (!cell) {
                
                cell = [[PostListCell alloc] initWithReuseIdentifier:PostListCellId];
            }
        
            //imageUrl,图片地址;title,标题;pv,NSNumber,浏览量;section_title,来源;
            NSDictionary * dic = @{@"imageUrl":model.images[0],@"title":model.title,@"pv":[NSNumber numberWithInteger:model.pv],@"section_title":model.section_title};
            [cell show:dic];
            return cell;
        }
        else if ([model.type isEqualToString:@"three"]){
            
            ForumThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumThreeCellId];
            if (!cell) {
                
                cell = [[ForumThreeCell alloc] initWithReuseIdentifier:ForumThreeCellId];
            }
            
            [cell show:model];
            return cell;
        }
        else if ([model.type isEqualToString:@"video"]){
            
            ForumVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumVideoCellId];
            if (!cell) {
                
                cell = [[ForumVideoCell alloc] initWithReuseIdentifier:ForumVideoCellId];
            }
            
            [cell show:model];
            return cell;
        }
    }
    else if (self.vcType == MultiStylePostListVCType_wodetieziliebiao){
        
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
    }
    
    return nil;
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
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"page":[NSString stringWithFormat:@"%ld",self.page]};
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
   if (self.vcType == MultiStylePostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == MultiStylePostListVCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
    
    [super loadNewData];
}
//上拉加载
-(void)loadMoreData{
    
    if (self.vcType == MultiStylePostListVCType_tieziliebiao) {
        
        [self requestData];
    }
    else if (self.vcType == MultiStylePostListVCType_wodetieziliebiao){
        
        [self requestMyArticleData];
    }
    
    [super loadMoreData];
}

@end
