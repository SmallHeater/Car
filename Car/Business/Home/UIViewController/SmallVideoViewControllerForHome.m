//
//  SmallVideoViewController.m
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SmallVideoViewControllerForHome.h"
#import "UserInforController.h"
#import "VideoModel.h"
#import "SHBaseCollectionView.h"
#import "VideoCollectionViewCell.h"
#import "PlayViewController.h"
#import "SHNavigationBar.h"


static NSString * cellID = @"VideoCollectionViewCell";

@interface SmallVideoViewControllerForHome ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) SHBaseCollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray<VideoModel *> * dataArray;
@property (nonatomic,assign) NSUInteger page;


@end

@implementation SmallVideoViewControllerForHome


#pragma mark  ----  懒加载

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * myLayout = [[UICollectionViewFlowLayout alloc] init];
        myLayout.minimumLineSpacing = 0;
        myLayout.minimumInteritemSpacing = 0;
        //默认左右滑动
        myLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT) collectionViewLayout:myLayout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        __weak typeof(self) weakSelf = self;
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
            [weakSelf requestData];
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }
    return _collectionView;
}

-(NSMutableArray<VideoModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setOffsetY:(CGFloat)offsetY{
    self.collectionView.contentOffset = CGPointMake(0, offsetY);
}

- (CGFloat)offsetY{
    return self.collectionView.contentOffset.y;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    if (isCanScroll == YES){
        [self.collectionView setContentOffset:CGPointMake(0, self.offsetY) animated:NO];
    }
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self drawUI];
    [self requestData];
    self.page = 1;
}

#pragma mark  ----  代理

#pragma mark  ----  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayViewController * playVC = [[PlayViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andDataArray:self.dataArray andSelectIndex:indexPath.row];
    playVC.hidesBottomBarWhenPushed = YES;
    if (self.navigationController) {
        
        [self.navigationController pushViewController:playVC animated:YES];
    }
    else{
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:playVC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [[UIViewController topMostController] presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    VideoModel * model = self.dataArray[indexPath.row];
    [cell show:model];
    return cell;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    float width = (MAINWIDTH - 1) / 2;
    
    return CGSizeMake(width, 274.0 / 187.0 * width);
}

//返回上左下右四边的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//返回cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

//cell之间的最小列间距a
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    NSUInteger topHeight = 0;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(topHeight);
        make.left.bottom.offset(0);
        make.width.offset(MAINWIDTH);
    }];
    
    self.scrollView = self.collectionView;
}

-(void)backBtnClicked:(UIButton *)btn{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)requestData{
    
    //position_id:首页：3，论坛页：2
    
    NSString * position_id = @"3";
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"position_id":@"2",@"page":[NSNumber numberWithInteger:self.page]};

    NSDictionary * configurationDic = @{@"requestUrlStr":GetVideos,@"bodyParameters":bodyParameters};
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
                        
                        if ([dataDic.allKeys containsObject:@"videos"]) {
                         
                            if (weakSelf.page == 1) {
                                
                                [weakSelf.dataArray removeAllObjects];
                            }
                            
                            NSArray * array = dataDic[@"videos"];
                            if (array && [array isKindOfClass:[NSArray class]]) {
                                
                                if (array.count == MAXCOUNT) {
                                    
                                    weakSelf.page++;
                                }
                                else{
                                    
                                    weakSelf.collectionView.mj_footer = nil;
                                }
                                
                                for (NSDictionary * dic in array) {
                                    
                                    VideoModel * model = [VideoModel mj_objectWithKeyValues:dic];
                                    [weakSelf.dataArray addObject:model];
                                }
                            }
                        }
                    }
                }
                else{
                    
                    //异常
                }
                [weakSelf.collectionView reloadData];
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
