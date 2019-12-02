//
//  CarouselCollectionViewCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCarouselCollectionViewCell.h"
#import "SHCarouselDataModel.h"


@interface SHCarouselCollectionViewCell ()

@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation SHCarouselCollectionViewCell

#pragma mark  ----  懒加载

-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)showWithModel:(SHCarouselDataModel *)model{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.CarouselImageUrlStr]];
}

@end
