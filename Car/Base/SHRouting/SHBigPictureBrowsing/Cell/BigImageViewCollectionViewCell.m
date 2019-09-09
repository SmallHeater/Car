//
//  BigImageViewCollectionViewCell.m
//  JHBigPictureBrowsing
//
//  Created by xianjunwang on 2018/7/10.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "BigImageViewCollectionViewCell.h"

@interface BigImageViewCollectionViewCell ()



@end

@implementation BigImageViewCollectionViewCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.bigImageView];
    }
    return self;
}

#pragma mark  ----  懒加载
-(UIImageView *)bigImageView{
    
    if (!_bigImageView) {
        
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bigImageView.clipsToBounds = YES;
    }
    return _bigImageView;
}

@end
