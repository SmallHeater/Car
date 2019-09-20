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

static NSString * cellID = @"ItemListCollectionViewCell";

@interface ItemNewsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) SHBaseCollectionView * collectionView;

@property (nonatomic,strong) NSMutableArray * tabIDArray;

@end

@implementation ItemNewsCell

#pragma mark  ----  懒加载

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ItemListCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

-(NSMutableArray *)tabIDArray{
    
    if (!_tabIDArray) {
        
        _tabIDArray = [[NSMutableArray alloc] init];
    }
    return _tabIDArray;
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
    
    ItemListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString * tabID = self.tabIDArray[indexPath.row];
    [cell requestWithTabID:tabID];
    
    return cell;
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

#pragma mark  ----  自定义函数

+(float)cellHeight{
    
    float cellHeight = 0;
    cellHeight = MAINHEIGHT - [UIScreenControl liuHaiHeight] - 71 - 40 - [UIScreenControl bottomSafeHeight] - 44;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

@end
