//
//  CarouselCollectionViewCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import "CarouselDataModel.h"


@interface CarouselCollectionViewCell ()

@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation CarouselCollectionViewCell

#pragma mark  ----  懒加载

-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
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

-(void)showWithModel:(CarouselDataModel *)model{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.CarouselImageUrlStr]];
}

@end
