//
//  VideoCollectionViewCell.m
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@interface VideoCollectionViewCell ()

//背景图
@property (nonatomic,strong) UIImageView * bgImageView;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//头像
@property (nonatomic,strong) UIImageView * avaterImageView;
//昵称
@property (nonatomic,strong) UILabel * nickNameLabel;
//播放次数
@property (nonatomic,strong) UILabel * playCountLabel;

@end

@implementation VideoCollectionViewCell

#pragma mark  ----  懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT14;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.masksToBounds = YES;
        _avaterImageView.layer.cornerRadius = 8;
    }
    return _avaterImageView;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = FONT10;
        _nickNameLabel.textColor = [UIColor whiteColor];
    }
    return _nickNameLabel;
}

-(UILabel *)playCountLabel{
    
    if (!_playCountLabel) {
        
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.font = FONT10;
        _playCountLabel.textColor = [UIColor whiteColor];
        _playCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _playCountLabel;
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
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(8);
        make.right.offset(-8);
        make.bottom.offset(-40);
        make.height.offset(30);
    }];
    
    [self addSubview:self.avaterImageView];
    [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(8);
        make.bottom.offset(-9);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avaterImageView.mas_right).offset(7);
        make.bottom.offset(-13);
        make.height.offset(10);
        make.width.offset(60);
    }];
    
    [self addSubview:self.playCountLabel];
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-13);
        make.bottom.offset(-13);
        make.width.offset(40);
        make.height.offset(10);
    }];
}

@end
