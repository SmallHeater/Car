//
//  ItemNewsCell.m
//  Car
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ItemNewsCell.h"
#import "ItemListCollectionViewCell.h"
#import "SHBaseCollectionView.h"
#import "SmallVideoViewController.h"

static NSString * defaultCellId = @"UICollectionViewCell";
static NSString * cellID = @"ItemListCollectionViewCell";

@interface ItemNewsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) SHBaseCollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * tabIDArray;
@property (nonatomic,strong) SmallVideoViewController * vc;

@end

@implementation ItemNewsCell

#pragma mark  ----  懒加载

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ItemListCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:defaultCellId];
    }
    return _collectionView;
}

-(NSMutableArray *)tabIDArray{
    
    if (!_tabIDArray) {
        
        _tabIDArray = [[NSMutableArray alloc] init];
    }
    return _tabIDArray;
}

-(SmallVideoViewController *)vc{
    
    if (!_vc) {
        
        _vc = [[SmallVideoViewController alloc] initWithType:VCType_Home];
    }
    return _vc;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTabIDsArray:(NSMutableArray *)array{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (array) {
            
            [self.tabIDArray addObjectsFromArray:array];
        }
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  UICollectionViewDelegate

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tabIDArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * tabID = self.tabIDArray[indexPath.row];
    if ([tabID isEqualToString:@"5"]) {
        
        //小视频
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:defaultCellId forIndexPath:indexPath];
        UIView * tempView = self.vc.view;
        tempView.frame = CGRectMake(0, 0, MAINWIDTH,[ItemNewsCell cellHeight]);
        [cell addSubview:tempView];
        return cell;
    }
    else{
     
        ItemListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        [cell requestWithTabID:tabID];
        return cell;
    }
    return nil;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.bounds.size;
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
}

#pragma mark  ----  自定义函数

+(float)cellHeight{
    
    float cellHeight = 0;
    cellHeight = MAINHEIGHT - [SHUIScreenControl liuHaiHeight] - 71 - 40 - [SHUIScreenControl bottomSafeHeight] - 44;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

//滑动
-(void)scrollToIndex:(NSUInteger)index{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
