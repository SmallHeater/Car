//
//  ForumListViewController.m
//  Car
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumListViewController.h"
#import "ForumTabModel.h"
#import "SHImageAndTitleBtn.h"
#import "SHTabModel.h"
#import "ForumArticleModel.h"
#import "ForumBaseCell.h"
#import "ForumSingleCell.h"
#import "PostListCell.h"
#import "ForumThreeCell.h"
#import "ForumVideoCell.h"
#import "ForumDetailViewController.h"
#import "UserInforController.h"
#import "PostListViewController.h"
#import "MultiStylePostListViewController.h"

static NSString * ForumBaseCellId = @"ForumBaseCell";
static NSString * ForumSingleCellId = @"ForumSingleCell";
static NSString * PostListCellId = @"PostListCell";
static NSString * ForumThreeCellId = @"ForumThreeCell";
static NSString * ForumVideoCellId = @"ForumVideoCell";


@interface ForumListViewController ()

@property (nonatomic,strong) UIView * tableHeaderView;
//第二行页签项模型数组
@property (nonatomic,strong) NSMutableArray<ForumTabModel *> * sectionForumTabModelArray;
@property (nonatomic,strong) NSMutableArray<SHImageAndTitleBtn *> * sectionBtnArray;
@property (nonatomic,strong) UIScrollView * sectionView;
@property (nonatomic,strong) NSString * tabId;
@property (nonatomic,strong) NSString * section_id;
@property (nonatomic,assign) NSUInteger page;

@end

@implementation ForumListViewController

#pragma mark  ----  懒加载

-(UIView *)tableHeaderView{
    
    if (_tableHeaderView == nil) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 132)];
        
        UILabel * headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, MAINWIDTH, 42)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, MAINWIDTH, 21)];
        headerLabel.backgroundColor = [UIColor whiteColor];
        headerLabel.font = BOLDFONT21;
        headerLabel.textColor = Color_333333;
        headerLabel.text = @"  论坛动态";
        [headerView addSubview:headerLabel];
        [_tableHeaderView addSubview:headerView];
    }
    return _tableHeaderView;
}

-(NSMutableArray<ForumTabModel *> *)sectionForumTabModelArray{
    
    if (!_sectionForumTabModelArray) {
        
        _sectionForumTabModelArray = [[NSMutableArray alloc] init];
    }
    return _sectionForumTabModelArray;
}

-(NSMutableArray<SHImageAndTitleBtn *> *)sectionBtnArray{
    
    if (!_sectionBtnArray) {
        
        _sectionBtnArray = [[NSMutableArray alloc] init];
    }
    return _sectionBtnArray;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.tableView.tableHeaderView = self.tableHeaderView;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumArticleModel * articleModel = self.dataArray[indexPath.row];
    if ([articleModel.type isEqualToString:@"zero"]) {
    
        ForumBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumBaseCellId];
        if (!cell) {
            
            cell = [[ForumBaseCell alloc] initWithReuseIdentifier:ForumBaseCellId];
        }
        
        [cell show:articleModel];
        return cell;
    }
    else if ([articleModel.type isEqualToString:@"single"]) {
        
        ForumSingleCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumSingleCellId];
        if (!cell) {
            
            cell = [[ForumSingleCell alloc] initWithReuseIdentifier:ForumSingleCellId];
        }
        
        [cell show:articleModel];
        return cell;
    }
    else if ([articleModel.type isEqualToString:@"single_left"]){
     
        PostListCell * cell = [tableView dequeueReusableCellWithIdentifier:PostListCellId];
        if (!cell) {
            
            cell = [[PostListCell alloc] initWithReuseIdentifier:PostListCellId];
        }
    
        //imageUrl,图片地址;title,标题;pv,NSNumber,浏览量;section_title,来源;
        NSDictionary * dic = @{@"imageUrl":articleModel.images[0],@"title":articleModel.title,@"pv":[NSNumber numberWithInteger:articleModel.pv],@"section_title":articleModel.section_title};
        [cell show:dic];
        return cell;
    }
    else if ([articleModel.type isEqualToString:@"three"]){
        
        ForumThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumThreeCellId];
        if (!cell) {
            
            cell = [[ForumThreeCell alloc] initWithReuseIdentifier:ForumThreeCellId];
        }
        
        [cell show:articleModel];
        return cell;
    }
    else if ([articleModel.type isEqualToString:@"video"]){
        
        ForumVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumVideoCellId];
        if (!cell) {
            
            cell = [[ForumVideoCell alloc] initWithReuseIdentifier:ForumVideoCellId];
        }
        
        [cell show:articleModel];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawSectionView{
    
    for (SHImageAndTitleBtn * btn in self.sectionBtnArray) {
        
        [btn removeFromSuperview];
    }
    
    if (self.sectionView) {
        
        [self.sectionView removeFromSuperview];
        self.sectionView = nil;
    }
   
    self.sectionView = [[UIScrollView alloc] init];
    self.sectionView.scrollEnabled = NO;
    [self.tableHeaderView addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(90);
    }];
    
    float btnX = 15;
    float btnWidth = 50;
    float btnHeight = 70;
    float btnInterval = (MAINWIDTH - btnX * 2 - btnWidth * 5) / 4;
    for (NSUInteger i = 0; i < self.sectionForumTabModelArray.count; i++) {
        
        ForumTabModel * tabModel = self.sectionForumTabModelArray[i];
        SHImageAndTitleBtn * btn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(btnX, 20, btnWidth, btnHeight) andImageFrame:CGRectMake(0, 0, btnWidth, btnWidth) andTitleFrame:CGRectMake(0, 58, btnWidth, 12) andImageName:@"" andSelectedImageName:@"" andTitle:tabModel.title];
        [btn refreshFont:FONT12];
        [btn refreshTitle:tabModel.title];
        [btn setImageUrl:tabModel.image];
        [btn setImageViewCornerRadius:btnWidth/2];
        if ([tabModel.title isEqualToString:@"全部论坛"] == NO) {
         
            [btn showImageStr:[NSString stringWithFormat:@"%ld",tabModel.count]];
        }
        btnX += btnWidth + btnInterval;
        [self.sectionBtnArray addObject:btn];
        [self.sectionView addSubview:btn];
        __weak typeof(self) weakSelf = self;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            weakSelf.section_id = tabModel.ForumID;
            if ([weakSelf.section_id isEqualToString:@"0"]) {
                
                //全部论坛
                [weakSelf requestForumList];
            }
            else{
                
//                //其余项，如维修保养，电子电路等
//                PostListViewController * vc = [[PostListViewController alloc] initWithTitle:tabModel.title andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:weakSelf.section_id];
//                vc.hidesBottomBarWhenPushed = YES;
//                [weakSelf.navigationController pushViewController:vc animated:YES];
                
                MultiStylePostListViewController * vc = [[MultiStylePostListViewController alloc] initWithTitle:tabModel.title andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:weakSelf.section_id vcType:MultiStylePostListVCType_tieziliebiao];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
    
    if (btnX + 15 > MAINWIDTH) {
        
        self.sectionView.contentSize = CGSizeMake(btnX + 15, 70);
    }
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.offset(0);
        make.bottom.offset(0);
    }];
}

-(void)requestSectionListWithTabID:(NSString *)tabId{
    
    self.tabId = [NSString repleaseNilOrNull:tabId];
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"tab_id":self.tabId};
    NSDictionary * configurationDic = @{@"requestUrlStr":SectionList,@"bodyParameters":bodyParameters};
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
                        
                        NSArray * arr = dataDic[@"sections"];
                        [weakSelf.sectionForumTabModelArray removeAllObjects];
                        for (NSUInteger i = 0; i < arr.count; i++) {
                            
                            NSDictionary * dic = arr[i];
                            ForumTabModel * model = [ForumTabModel mj_objectWithKeyValues:dic];
                            [weakSelf.sectionForumTabModelArray addObject:model];
                            if (i == 0) {
                                
                                model.isSelected = YES;
                                weakSelf.section_id = model.ForumID;
                                [weakSelf requestForumList];
                            }
                            else{
                                
                                model.isSelected = NO;
                            }
                        }
                        [weakSelf drawSectionView];
                    }
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

//下拉刷新(回调函数)
-(void)loadNewData{
    
    self.page = 1;
    [self requestForumList];
    [super loadNewData];
}
//上拉加载(回调函数)
-(void)loadMoreData{
    
    [self requestForumList];
    [super loadMoreData];
}

-(void)requestForumList{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"section_id":[NSString repleaseNilOrNull:self.section_id],@"page":[NSString stringWithFormat:@"%ld",self.page]};
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
                
                [weakSelf refreshViewType:BTVCType_RefreshTableView];
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
