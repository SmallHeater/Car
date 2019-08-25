//
//  CarouselView.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionViewCell.h"


static NSString * cellID = @"CarouselCollectionViewCell";

@interface CarouselView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

@end

@implementation CarouselView

#pragma mark  ----- 懒加载

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        // 设置布局方向(滚动方向)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置列的最小间距
        layout.minimumInteritemSpacing = 0;
        //最小行间距
        layout.minimumLineSpacing = 0;
        // 设置布局的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:NSClassFromString(@"CarouselCollectionViewCell") forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        //需要等masonry布局完成后才能获取到frame
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self drawUI];
        });
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UICollectionViewDelegate

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CarouselCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        cell.backgroundColor = [UIColor greenColor];
    }
    else{
     
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

@end
