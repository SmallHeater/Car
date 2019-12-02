//
//  ForumVideoCell.m
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumVideoCell.h"

@interface ForumVideoCell ()

@property (nonatomic,strong) UIImageView * videoImageView;

@end

@implementation ForumVideoCell

#pragma mark  ----  懒加载

-(UIImageView *)videoImageView{
    
    if (!_videoImageView) {
        
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.backgroundColor = [UIColor clearColor];
        _videoImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _videoImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _videoImageView.clipsToBounds = YES;
    }
    return _videoImageView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithTitle:(NSString *)title{
    
    float cellHeight = 0;
    cellHeight += 73;
    cellHeight += [title heightWithFont:FONT17 andWidth:MAINWIDTH - 15 * 2];
    cellHeight += 15 + 190.0 / 345.0 * (MAINWIDTH - 30);
    cellHeight += 45;
    return cellHeight;
}

-(void)drawUI{
    
    [super drawUI];
    float imageViewHeight = 190.0 / 345.0 * (MAINWIDTH - 30);
    [self addSubview:self.videoImageView];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-45);
        make.height.offset(imageViewHeight);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    [super show:model];
    NSString * imgUrl = [NSString repleaseNilOrNull:model.images.firstObject];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end
