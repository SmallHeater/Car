//
//  ItemListCollectionViewCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ItemListCollectionViewCell.h"
#import "UserInforController.h"
#import "ForumArticleModel.h"
#import "CarItemSingleCell.h"
#import "CarItemVideoCell.h"
#import "CarItemThreeCell.h"
#import "ForumDetailViewController.h"
#import "CarItemTextCell.h"

static NSString * CarItemTextCellId = @"CarItemTextCell";
static NSString * CarItemSingleCellID = @"CarItemSingleCell";
static NSString * CarItemVideoCellID = @"CarItemVideoCell";
static NSString * CarItemThreeCellID = @"CarItemThreeCell";


@interface ItemListCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHBaseTableView * tableView;

@property (nonatomic,strong) NSString * tabID;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,strong) NSMutableArray<ForumArticleModel *> * dataArray;
//上一次的y值
@property (nonatomic,assign) float lastY;

@end

@implementation ItemListCollectionViewCell

#pragma mark  ----  懒加载

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        NSNumber * canScrollNumber = [[NSUserDefaults standardUserDefaults] valueForKey:@"itemListTableViewCanScroll"];
        _tableView.scrollEnabled = canScrollNumber.boolValue;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        __weak typeof(self) weakSelf = self;
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf requestWithTabID:weakSelf.tabID];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }
    return _tableView;
}

-(NSMutableArray<ForumArticleModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self drawUI];
        self.page = 1;
        //tableview能否滑动
        __weak typeof(self) weakSelf = self;
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"ItemListTableViewScroll" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            
            NSDictionary * dic = x.userInfo;
            NSNumber * canScrollNumber = dic[@"canScroll"];
            weakSelf.tableView.scrollEnabled = canScrollNumber.boolValue;
            NSNumber * yNumber = dic[@"y"];
            if (yNumber.floatValue > weakSelf.lastY) {
                
                weakSelf.lastY = yNumber.floatValue;
                weakSelf.tableView.contentOffset = CGPointMake(0, weakSelf.lastY);
            }
        }];
    }
    
    return self;
}

#pragma mark  ----  代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float y = scrollView.contentOffset.y;
    if (y < 0) {
        
        //已滑动到最大
        self.tableView.scrollEnabled = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeTableViewScroll" object:nil userInfo:@{@"canScroll":[NSNumber numberWithBool:YES],@"y":[NSNumber numberWithFloat:-y]}];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.lastY = 0;
}

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    ForumArticleModel * model = self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"single"]) {
        
        cellHeight = [CarItemSingleCell cellheight];
    }
    else if ([model.type isEqualToString:@"three"]) {
        
        cellHeight = [CarItemThreeCell cellHeightWithText:model.title];
    }
    else if ([model.type isEqualToString:@"video"]) {
        
        cellHeight = [CarItemVideoCell cellHeightWithTitle:model.title];
    }
    else if ([model.type isEqualToString:@"zero"]){
        
        cellHeight = [CarItemTextCell cellHeight:model];
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumArticleModel * articleModel = self.dataArray[indexPath.row];
    ForumDetailViewController * vc = [[ForumDetailViewController alloc] initWithTitle:articleModel.section_title andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andArticleId:[NSString stringWithFormat:@"%ld",articleModel.ArticleId]];
    vc.hidesBottomBarWhenPushed = YES;
    UIViewController * topVc = [UIViewController topMostController];
    if (topVc.navigationController) {

        [topVc.navigationController pushViewController:vc animated:YES];
    }
    else{
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [topVc presentViewController:nav animated:YES completion:nil];
    }
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
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

//请求数据
-(void)requestWithTabID:(NSString *)tabID{
    
    self.tabID = [NSString repleaseNilOrNull:tabID];
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"tab_id":[NSString repleaseNilOrNull:tabID],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetArticles,@"bodyParameters":bodyParameters};
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
                        
                        NSArray * arr = dataDic[@"articles"];
                        if (arr && [arr isKindOfClass:[NSArray class]]) {
                            
                            if (arr.count == MAXCOUNT) {
                                
                                weakSelf.page++;
                            }
                            else if (arr.count == 0){
                                
                                [MBProgressHUD wj_showError:@"没有更多数据啦"];
                                weakSelf.tableView.mj_footer = nil;
                            }
                            else{
                                
                                weakSelf.tableView.mj_footer = nil;
                            }
                            
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
