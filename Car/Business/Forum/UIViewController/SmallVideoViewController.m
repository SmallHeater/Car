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
#import "PushAndPlayViewController.h"


static NSString * cellID = @"VideoCollectionViewCell";

@interface SmallVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,assign) VCType type;
@property (nonatomic,strong) SHBaseCollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray<VideoModel *> * dataArray;

@end

@implementation SmallVideoViewController

#pragma mark  ----  懒加载

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
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
    
    PushAndPlayViewController * vc = [[PushAndPlayViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    VideoModel * model = self.dataArray[indexPath.row];
//    NSURL*url = [NSURL URLWithString:@"http://dlhls.cdn.zhanqi.tv/zqlive/3884_bR1ms.m3u8"];
//
//    AVPlayerViewController* play = [[AVPlayerViewController alloc]init];
//
//    play.player= [[AVPlayer alloc]initWithURL:url];
//
//    play.allowsPictureInPicturePlayback=YES;//这个是允许画中画的,默认应该是开启的,但是我的没有效果,现在还不知道什么原因
//
//    [play.player play]; //这里我设置直接播放,页面弹出后会直接播放,要不然还需要点击一下播放按钮
//
//    [self presentViewController:play animated:YES completion:nil];
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
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
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
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"position_id":@"2"};
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
