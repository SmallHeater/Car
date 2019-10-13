//
//  ForumSingleCell.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumSingleCell.h"

@interface ForumSingleCell ()

@property (nonatomic,strong) UIImageView * singleImageView;

@end

@implementation ForumSingleCell

#pragma mark  ----  懒加载

-(UIImageView *)singleImageView{
    
    if (!_singleImageView) {
        
        _singleImageView = [[UIImageView alloc] init];
        _singleImageView.backgroundColor = [UIColor clearColor];
    }
    return _singleImageView;
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
    
    [self addSubview:self.singleImageView];
    [self.singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.bottom.offset(-53);
        make.width.height.offset(104);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    [super show:model];
    NSString * imgUrl = [NSString repleaseNilOrNull:model.images.firstObject];
    [self.singleImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end
