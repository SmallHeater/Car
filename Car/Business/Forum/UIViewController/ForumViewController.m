//
//  ForumViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumViewController.h"
#import "SHTabView.h"
#import "UserInforController.h"
#import "ForumTabModel.h"
#import "SHImageAndTitleBtn.h"
#import "ForumArticleModel.h"
#import "ForumSingleCell.h"
#import "ForumThreeCell.h"
#import "ForumVideoCell.h"
#import "ForumDetailViewController.h"
#import "PostListCell.h"
#import "SmallVideoViewController.h"

#define BASEBTNTAG 1400

static NSString * ForumBaseCellId = @"ForumBaseCell";
static NSString * ForumSingleCellId = @"ForumSingleCell";
static NSString * PostListCellId = @"PostListCell";
static NSString * ForumThreeCellId = @"ForumThreeCell";
static NSString * ForumVideoCellId = @"ForumVideoCell";

@interface ForumViewController ()<UITableViewDelegate,UITableViewDataSource>

//头部页签项模型数组
@property (nonatomic,strong) NSMutableArray<ForumTabModel *> * tabForumTabModelArray;
//第二行页签项模型数组
@property (nonatomic,strong) NSMutableArray<ForumTabModel *> * sectionForumTabModelArray;
@property (nonatomic,strong) NSMutableArray<SHImageAndTitleBtn *> * sectionBtnArray;
@property (nonatomic,strong) NSMutableArray<SHTabModel *> * tabModelArray;
@property (nonatomic,strong) SHTabView * baseTabView;
//论坛页导航
@property (nonatomic,strong) UIView * forumNavView;
@property (nonatomic,strong) UIScrollView * sectionView;
@property (nonatomic,strong) NSMutableArray<ForumArticleModel *> * dataArray;
@property (nonatomic,strong) SHBaseTableView * tableView;
//小视频列表view
@property (nonatomic,strong) UIView * smallVideoView;

@end

@implementation ForumViewController

#pragma mark  ----  懒加载

-(NSMutableArray<ForumTabModel *> *)tabForumTabModelArray{
    
    if (!_tabForumTabModelArray) {
        
        _tabForumTabModelArray = [[NSMutableArray alloc] init];
    }
    return _tabForumTabModelArray;
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

-(NSMutableArray<SHTabModel *> *)tabModelArray{
    
    if (!_tabModelArray) {
        
        _tabModelArray = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < self.tabForumTabModelArray.count; i++) {
            
            ForumTabModel * forumTabModel = self.tabForumTabModelArray[i];
            SHTabModel * tabModel = [[SHTabModel alloc] init];
            tabModel.tabTitle = forumTabModel.title;
            tabModel.normalFont = FONT15;
            tabModel.normalColor = Color_333333;
            tabModel.selectedFont = BOLDFONT21;
            tabModel.selectedColor = Color_333333;
            tabModel.tabTag = BASEBTNTAG + i;
            tabModel.btnWidth = [tabModel.tabTitle widthWithFont:tabModel.selectedFont andHeight:30] + 10;;
            [_tabModelArray addObject:tabModel];
        }
    }
    return _tabModelArray;
}


-(SHTabView *)baseTabView{
    
    if (!_baseTabView) {
        
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineHeight = 4;
        lineModel.lineWidth = 11;
        lineModel.lineCornerRadio = 2;
        _baseTabView = [[SHTabView alloc] initWithItemsArray:self.tabModelArray showRightBtn:NO andSHTabSelectLineModel:lineModel isShowBottomLine:NO];
        __weak typeof(self) weakSelf = self;
        [[_baseTabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - BASEBTNTAG;
            for (ForumTabModel * model in weakSelf.tabForumTabModelArray) {
                
                model.isSelected = NO;
            }
            
            ForumTabModel * model = weakSelf.tabForumTabModelArray[index];
            model.isSelected = YES;
            if ([model.title isEqualToString:@"小视频"]) {
                
                [weakSelf.smallVideoView removeFromSuperview];
                weakSelf.tableView.hidden = YES;
                weakSelf.smallVideoView.hidden = NO;
                [weakSelf.view addSubview:weakSelf.smallVideoView];
            }
            else{
             
                weakSelf.tableView.hidden = NO;
                weakSelf.smallVideoView.hidden = YES;
                [weakSelf requestSectionListWithTabID:model.ForumID];
            }
        }];
    }
    return _baseTabView;
}

-(UIView *)forumNavView{
    
    if (!_forumNavView) {
        
        _forumNavView = [[UIView alloc] init];
        //搜索按钮
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.hidden = YES;
        [searchBtn setImage:[UIImage imageNamed:@"sousuohei"] forState:UIControlStateNormal];
        [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            //跳转到搜索页面
        }];
        [_forumNavView addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.offset(31);
            make.right.offset(-8);
            make.bottom.offset(0);
        }];
        
        [_forumNavView addSubview:self.baseTabView];
        [self.baseTabView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.bottom.offset(0);
            make.height.offset(34);
            make.right.equalTo(searchBtn.mas_left).offset(0);
        }];
    }
    return _forumNavView;
}

-(NSMutableArray<ForumArticleModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(UIView *)smallVideoView{
    
    if (!_smallVideoView) {
        
        SmallVideoViewController * vc = [[SmallVideoViewController alloc] initWithType:VCType_Forum];
        _smallVideoView = vc.view;
        _smallVideoView.frame = CGRectMake(0, CGRectGetMaxY(self.forumNavView.frame) + 10, MAINWIDTH, MAINHEIGHT - CGRectGetHeight(self.forumNavView.frame) - 10 - 44 - [SHUIScreenControl bottomSafeHeight]);
        [self addChildViewController:vc];
    }
    return _smallVideoView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestTablist];
    [self drawTableView];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight = 80;
    return headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel * headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 80)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.font = BOLDFONT21;
    headerView.textColor = Color_333333;
    headerView.text = @"  论坛动态";
    return headerView;
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

-(void)drawNav{
    
    [self.view addSubview:self.forumNavView];
    [self.forumNavView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset([SHUIScreenControl navigationBarHeight]);
    }];
}

-(void)drawSectionView{
    
    for (SHImageAndTitleBtn * btn in self.sectionBtnArray) {
        
        [btn removeFromSuperview];
    }
    
    if (self.sectionView) {
        
        [self.sectionView removeFromSuperview];
        self.sectionView = nil;
    }
   
    self.sectionView = [[UIScrollView alloc] init];
    [self.view addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.forumNavView.mas_bottom).offset(0);
        make.height.offset(90);
    }];
    
    float btnX = 15;
    float btnWidth = 50;
    float btnHeight = 70;
    for (NSUInteger i = 0; i < self.sectionForumTabModelArray.count; i++) {
        
        ForumTabModel * tabModel = self.sectionForumTabModelArray[i];
        SHImageAndTitleBtn * btn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(btnX, 20, btnWidth, btnHeight) andImageFrame:CGRectMake(0, 0, btnWidth, btnWidth) andTitleFrame:CGRectMake(0, 58, btnWidth, 12) andImageName:@"" andSelectedImageName:@"" andTitle:tabModel.title];
        [btn refreshFont:FONT12];
        [btn refreshTitle:tabModel.title];
        [btn setImageUrl:tabModel.image];
        [btn setImageViewCornerRadius:btnWidth/2];
        btnX += btnWidth + 25;
        [self.sectionBtnArray addObject:btn];
        [self.sectionView addSubview:btn];
        __weak typeof(self) weakSelf = self;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf requestForumListWithSectionId:tabModel.ForumID];
        }];
    }
    
    if (btnX + 15 > MAINWIDTH) {
        
        self.sectionView.contentSize = CGSizeMake(btnX + 15, 70);
    }
}

-(void)drawTableView{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.offset([SHUIScreenControl navigationBarHeight] + 90);
    }];
}

-(void)requestTablist{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":TabList,@"bodyParameters":bodyParameters};
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
                        for (NSUInteger i = 0; i < arr.count; i++) {
                            
                            NSDictionary * dic = arr[i];
                            ForumTabModel * model = [ForumTabModel mj_objectWithKeyValues:dic];
                            [weakSelf.tabForumTabModelArray addObject:model];
                            if (i == 0) {
                                
                                model.isSelected = YES;
                                [weakSelf requestSectionListWithTabID:model.ForumID];
                            }
                            else{
                                
                                model.isSelected = NO;
                            }
                        }
                        [weakSelf drawNav];
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

-(void)requestSectionListWithTabID:(NSString *)tabId{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"tab_id":[NSString repleaseNilOrNull:tabId]};
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
                                [weakSelf requestForumListWithSectionId:model.ForumID];
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

-(void)requestForumListWithSectionId:(NSString *)sectionId{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"section_id":[NSString repleaseNilOrNull:sectionId]};
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


@end
