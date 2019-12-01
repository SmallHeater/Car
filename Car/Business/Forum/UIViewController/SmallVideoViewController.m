//
//  SmallVideoViewController.m
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SmallVideoViewController.h"
#import "UserInforController.h"
#import "VideoModel.h"
#import "SHBaseCollectionView.h"
#import "VideoCollectionViewCell.h"
#import "PlayViewController.h"
#import "SHNavigationBar.h"


static NSString * cellID = @"VideoCollectionViewCell";

@interface SmallVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) SHNavigationBar * navigationbar;
@property (nonatomic,assign) VCType type;
@property (nonatomic,strong) SHBaseCollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray<VideoModel *> * dataArray;

@end

@implementation SmallVideoViewController


#pragma mark  ----  懒加载
-(SHNavigationBar *)navigationbar{
    
    if (!_navigationbar) {
        
        _navigationbar = [[SHNavigationBar alloc] initWithTitle:@"我发布的视频列表" andShowBackBtn:YES];
        [_navigationbar addbackbtnTarget:self andAction:@selector(backBtnClicked:)];
    }
    return _navigationbar;
}

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
    }
    return _collectionView;
}

-(NSMutableArray<VideoModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithType:(VCType)type{
    
    self = [super init];
    if (self) {
        
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self drawUI];
    [self requestData];
}

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
    if (self.type == VCType_MyVideos) {
        
        topHeight = [SHUIScreenControl navigationBarHeight];
        [self.view addSubview:self.navigationbar];
        [self.navigationbar mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.offset(0);
            make.height.offset([SHUIScreenControl navigationBarHeight]);
        }];
    }
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(topHeight);
        make.left.bottom.offset(0);
        make.width.offset(MAINWIDTH);
    }];
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
    
    NSString * position_id = @"";
    if (self.type == VCType_Forum) {
        
        position_id = @"2";
    }
    else if (self.type == VCType_Home){
        
        position_id = @"3";
    }
    
    NSDictionary * bodyParameters;
    if (self.type == VCType_MyVideos) {
        
        position_id = @"0";
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"position_id":@"2",@"owner_id":[UserInforController sharedManager].userInforModel.userID};
    }
    else{
        
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"position_id":@"2"};
    }
    
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
                         
                            NSArray * array = dataDic[@"videos"];
                            if (array && [array isKindOfClass:[NSArray class]]) {
                                
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
