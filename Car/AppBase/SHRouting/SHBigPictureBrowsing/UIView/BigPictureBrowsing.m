//
//  BigPictureBrowsing.m
//  SHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/6.
//

#import "BigPictureBrowsing.h"
#import "UIImageView+WebCache.h"
#import "SHAssetImageModel.h"
#import "BigImageViewCollectionViewCell.h"


@interface BigPictureBrowsing ()<UICollectionViewDelegate,UICollectionViewDataSource>

//图片数据label
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UICollectionView * imageCollectionView;

@end


@implementation BigPictureBrowsing

#pragma mark  ----  懒加载
-(UILabel *)titleLabel{
    
    if (!_titleLabel){
        
        //iOS11之后新增了一个safeAreaInsets属性,当a大于0时即是iPhone X ，XR，XS ，XS Max等。
        CGFloat safeAreaHeight;
        if (@available(iOS 11.0, *)) {
            
            safeAreaHeight =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        } else {
            
            safeAreaHeight = 0;
        }
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,safeAreaHeight + 13, MAINWIDTH, 18)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"0/0";
    }
    return _titleLabel;
}

-(UICollectionView *)imageCollectionView{
    
    if (!_imageCollectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT) collectionViewLayout:layout];
        _imageCollectionView.backgroundColor = [UIColor whiteColor];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.showsHorizontalScrollIndicator = NO;
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        //分页
        _imageCollectionView.pagingEnabled = YES;
        if (@available(iOS 10.0, *)) {
            
            //避免首次滑动cell执行两次
            _imageCollectionView.prefetchingEnabled = NO;
        }
        [_imageCollectionView registerClass:[BigImageViewCollectionViewCell class] forCellWithReuseIdentifier:@"BigImageViewCollectionViewCell"];
    }
    return _imageCollectionView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array andSelectedIndex:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
         
            self.dataArray = [[NSArray alloc] initWithArray:array];

            if (self.dataArray.count > 0) {
                
                self.imageCollectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self addSubview:self.imageCollectionView];
                });
                
                CGFloat offsetX = MAINWIDTH * index;
                [self.imageCollectionView setContentOffset:CGPointMake(offsetX, 0)];
            }
        }
    }
    return self;
}


-(void)layoutSubviews{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.titleLabel];
}

#pragma mark  ----  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self imageTaped];
}

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //图片资源
    BigImageViewCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageViewCollectionViewCell" forIndexPath:indexPath];
    
    NSUInteger index = indexPath.row;
    id value = self.dataArray[index];
    if ([value isKindOfClass:[SHAssetImageModel class]]) {
        
        SHAssetImageModel * imageModel = (SHAssetImageModel *)value;
        cell.bigImageView.image = imageModel.originalImage;
    }
    else if ([value isKindOfClass:[UIImage class]]){
        
        UIImage * image = (UIImage *)value;
        cell.bigImageView.image = image;
    }
    else if ([value isKindOfClass:[NSString class]]){
        
        NSString * urlStr = (NSString *)value;
        NSURL * url = [NSURL URLWithString:urlStr];
        [cell.bigImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultImagebig.tiff"]];
    }
    else if ([value isKindOfClass:[NSURL class]]){
        
        NSURL * url = (NSURL *)value;
        [cell.bigImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultImagebig.tiff"]];
    }
    
    self.titleLabel.text = [[NSString alloc] initWithFormat:@"%lu/%lu",(unsigned long)(index + 1),(unsigned long)self.dataArray.count];
    
    return cell;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MAINWIDTH, MAINHEIGHT);
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
//移除大图浏览
-(void)imageTaped{
    
    [self.titleLabel removeFromSuperview];
    [self removeFromSuperview];
}

@end
