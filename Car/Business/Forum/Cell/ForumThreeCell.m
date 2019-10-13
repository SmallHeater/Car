//
//  ForumThreeCell.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumThreeCell.h"

@interface ForumThreeCell ()

@property (nonatomic,strong) UIImageView * oneImageView;
@property (nonatomic,strong) UIImageView * twoImageView;
@property (nonatomic,strong) UIImageView * threeImageView;

@end

@implementation ForumThreeCell

#pragma mark  ----  懒加载

-(UIImageView *)oneImageView{
    
    if (!_oneImageView) {
        
        _oneImageView = [[UIImageView alloc] init];
        _oneImageView.backgroundColor = [UIColor clearColor];
    }
    return _oneImageView;
}

-(UIImageView *)twoImageView{
    
    if (!_twoImageView) {
        
        _twoImageView = [[UIImageView alloc] init];
        _twoImageView.backgroundColor = [UIColor clearColor];
    }
    return _twoImageView;
}

-(UIImageView *)threeImageView{
    
    if (!_threeImageView) {
        
        _threeImageView = [[UIImageView alloc] init];
        _threeImageView.backgroundColor = [UIColor clearColor];
    }
    return _threeImageView;
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
    cellHeight += 77;
    cellHeight += [title heightWithFont:FONT17 andWidth:MAINWIDTH - 15 * 2];
    cellHeight += 17 + 104;
    cellHeight += 53;
    return cellHeight;
}

-(void)drawUI{
    
    [super drawUI];
    
    NSUInteger imageWidth = 109;
    NSUInteger imageHeight = 104;
    float interval = (MAINWIDTH - 15 * 2 - imageWidth * 3) / 2;
    
    [self addSubview:self.oneImageView];
    [self.oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.bottom.offset(-53);
        make.width.offset(imageWidth);
        make.height.offset(imageHeight);
    }];
    
    [self addSubview:self.twoImageView];
    [self.twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.oneImageView.mas_right).offset(interval);
        make.bottom.equalTo(self.oneImageView.mas_bottom);
        make.width.offset(imageWidth);
        make.height.offset(imageHeight);
    }];
    
    [self addSubview:self.threeImageView];
    [self.threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.twoImageView.mas_right).offset(interval);
        make.bottom.equalTo(self.oneImageView.mas_bottom);
        make.width.offset(imageWidth);
        make.height.offset(imageHeight);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    [super show:model];
    
    if (model.images.count == 3) {
        
        NSString * firstImgUrl = model.images[0];
        NSString * secondImgUrl = model.images[1];
        NSString * thirdImgUrl = model.images[0];
        [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:firstImgUrl]];
        [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:secondImgUrl]];
        [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:thirdImgUrl]];
    }
}


@end
