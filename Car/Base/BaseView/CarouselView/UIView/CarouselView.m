//
//  CarouselView.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionViewCell.h"
#import "CarouselDataModel.h"
#import "SHPageControl.h"


static NSString * cellID = @"CarouselCollectionViewCell";

@interface CarouselView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray<CarouselDataModel *> * dataArray;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) SHPageControl * pageControl;
//自动轮播定时器
@property (nonatomic,strong) dispatch_source_t timer;

@end

@implementation CarouselView

#pragma mark  ----- 懒加载

-(NSMutableArray<CarouselDataModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

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

//-(XHPageControl *)pageControl{
//
//    if (!_pageControl) {
//
//        _pageControl = [[XHPageControl alloc] init];
//        _pageControl.type = PageControlMiddle;
//        _pageControl.currentPage = 0;
//        _pageControl.currentBkImg = [UIImage imageNamed:@"pageIconSelected"];
//        _pageControl.otherBkImg = [UIImage imageNamed:@"pageIconNormal"];
//        _pageControl.otherMultiple = 14.0 / 3.0;
//        _pageControl.currentMultiple = 14.0 / 3.0;
//        _pageControl.controlSpacing = 4;
//        _pageControl.controlSize = 3;
//    }
//    return _pageControl;
//}

-(SHPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[SHPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.currentImageSize = CGSizeMake(14, 3);
        _pageControl.currentImage = [UIImage imageNamed:@"pageIconSelected"];
        _pageControl.inactiveImageSize = CGSizeMake(14, 3);
        _pageControl.inactiveImage = [UIImage imageNamed:@"pageIconNormal"];;
    }
    return _pageControl;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        //需要等masonry布局完成后才能获取到frame
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self drawUI];
        });
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UICollectionViewDelegate

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CarouselCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell showWithModel:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    self.pageControl.currentPage = index;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

//CarouselId,CarouselImageUrlStr
-(void)refreshData:(NSArray<NSDictionary *> *)array{
    
    for (NSDictionary * dic in array) {
        
        CarouselDataModel * model = [CarouselDataModel mj_objectWithKeyValues:dic];
        [self.dataArray addObject:model];
    }
    
    [self.collectionView reloadData];
    [self addPageControl];
}

-(void)addPageControl{
    
    self.pageControl.numberOfPages = self.dataArray.count;
    
    float pageControlWidth = self.dataArray.count * 18 - 4;
    
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(pageControlWidth);
        make.bottom.offset(-14);
        make.height.offset(3);
    }];
    [self bringSubviewToFront:self.pageControl];
    [self addTimer];
}

//添加定时器
-(void)addTimer{
    
    if (self.timer) {
        
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(5.0*NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        
        //定时器需要执行的操作
    
        if (weakSelf.collectionView.contentOffset.x == CGRectGetWidth(self.frame) * (weakSelf.dataArray.count - 1)) {
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        }
        else{
            
            NSUInteger index = weakSelf.collectionView.contentOffset.x / CGRectGetWidth(self.frame);
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index + 1 inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        }
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
}
    
@end