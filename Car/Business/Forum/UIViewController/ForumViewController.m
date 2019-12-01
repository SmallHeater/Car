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
#import "ForumArticleModel.h"
#import "SmallVideoViewController.h"
#import "SHBaseCollectionView.h"
#import "SmallVideoCollectionViewCell.h"
#import "ForumListViewController.h"
#import "MultiStylePostListViewController.h"


#define BASEBTNTAG 1400
static NSString * defaultCellId = @"UICollectionViewCell";
static NSString * smallVideoCellId = @"SmallVideoCollectionViewCell";

@interface ForumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

//头部页签项模型数组
@property (nonatomic,strong) NSMutableArray<ForumTabModel *> * tabForumTabModelArray;
@property (nonatomic,strong) NSMutableArray<SHTabModel *> * tabModelArray;
@property (nonatomic,strong) SHTabView * baseTabView;
//论坛页导航
@property (nonatomic,strong) UIView * forumNavView;
@property (nonatomic,strong) SHBaseCollectionView * collectionView;
//行业论坛view
@property (nonatomic,strong) UIView * industryForumView;
//杂谈view
@property (nonatomic,strong) UIView * miscellaneousView;
//学知识view
@property (nonatomic,strong) UIView * learnKnowledgeView;
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
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
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

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:defaultCellId];
        [_collectionView registerClass:[SmallVideoCollectionViewCell class] forCellWithReuseIdentifier:smallVideoCellId];
    }
    return _collectionView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestTablist];
}

#pragma mark  ----  UICollectionViewDelegate

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tabModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SHTabModel * model = self.tabModelArray[indexPath.row];
    if ([model.tabTitle isEqualToString:@"行业论坛"]){

        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:defaultCellId forIndexPath:indexPath];
        [cell addSubview:self.industryForumView];
        return cell;
    }
    else if ([model.tabTitle isEqualToString:@"杂谈"]){

        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:defaultCellId forIndexPath:indexPath];
         [cell addSubview:self.miscellaneousView];
        return cell;
    }
    else if ([model.tabTitle isEqualToString:@"学知识"]){

        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:defaultCellId forIndexPath:indexPath];
        [cell addSubview:self.learnKnowledgeView];
        return cell;
    }
    else if ([model.tabTitle isEqualToString:@"小视频"]) {

        //小视频
        SmallVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:smallVideoCellId forIndexPath:indexPath];
        [cell addSubview:self.smallVideoView];
        return cell;
    }
    return nil;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
}

//返回上左下右四边的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//返回cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//cell之间的最小列间距a
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark  ----  UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / MAINWIDTH;
    [self.baseTabView selectItemWithIndex:index];
}

#pragma mark  ----  自定义函数

-(void)drawNav{
    
    [self.view addSubview:self.forumNavView];
    [self.forumNavView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset([SHUIScreenControl navigationBarHeight]);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.forumNavView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.offset(-44 - [SHUIScreenControl bottomSafeHeight]);
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
                        }
                        [weakSelf createViews];
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

//实力化行业论坛view，杂谈view等
-(void)createViews{
    
    for (NSUInteger i = 0; i < self.tabForumTabModelArray.count; i++) {
        
        ForumTabModel * model = self.tabForumTabModelArray[i];
        if ([model.title isEqualToString:@"行业论坛"]) {
            
            ForumListViewController * vc = [[ForumListViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andIsShowHead:YES andIsShowFoot:YES];
            self.industryForumView = vc.view;
            self.industryForumView.frame = CGRectMake(0,0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
            [self addChildViewController:vc];
            [vc requestSectionListWithTabID:model.ForumID];
        }
        else if ([model.title isEqualToString:@"杂谈"]){

            MultiStylePostListViewController * vc = [[MultiStylePostListViewController alloc] initWithTitle:model.title andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andSectionId:model.ForumID vcType:MultiStylePostListVCType_tieziliebiao];
            self.miscellaneousView = vc.view;
            self.miscellaneousView.frame = CGRectMake(0,0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
            [self addChildViewController:vc];
        }
        else if ([model.title isEqualToString:@"学知识"]){

            MultiStylePostListViewController * vc = [[MultiStylePostListViewController alloc] initWithTitle:model.title andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andSectionId:model.ForumID vcType:MultiStylePostListVCType_tieziliebiao];
            self.learnKnowledgeView = vc.view;
            self.learnKnowledgeView.frame = CGRectMake(0,0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
            [self addChildViewController:vc];
        }
        else if ([model.title isEqualToString:@"小视频"]){

            SmallVideoViewController * vc = [[SmallVideoViewController alloc] initWithType:VCType_Forum];
            self.smallVideoView = vc.view;
            self.smallVideoView.frame = CGRectMake(0,0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44 - [SHUIScreenControl bottomSafeHeight]);
            [self addChildViewController:vc];
        }
    }
}

@end
