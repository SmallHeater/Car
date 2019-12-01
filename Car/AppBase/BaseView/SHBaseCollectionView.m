//
//  SHBaseCollectionView.m
//  Car
//
//  Created by xianjun wang on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaseCollectionView.h"

@implementation SHBaseCollectionView

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    UICollectionViewFlowLayout * myLayout;
    if (layout) {
        
        myLayout = (UICollectionViewFlowLayout *)layout;
    }
    else{
        
        myLayout = [[UICollectionViewFlowLayout alloc] init];
        myLayout.minimumLineSpacing = 0;
        myLayout.minimumInteritemSpacing = 0;
        //默认左右滑动
        myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    self = [super initWithFrame:frame collectionViewLayout:myLayout];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //分页
        self.pagingEnabled = YES;
        if (@available(iOS 10.0, *)) {
            
            //避免首次滑动cell执行两次
            self.prefetchingEnabled = NO;
        }
    }
    return self;
}


@end
