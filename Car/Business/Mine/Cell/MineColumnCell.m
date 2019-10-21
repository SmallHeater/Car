//
//  MineColumnCell.m
//  Car
//
//  Created by xianjun wang on 2019/10/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MineColumnCell.h"

@interface MineColumnCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * titleLabel;
//消息数
@property (nonatomic,strong) UILabel * countsLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;
//消息数
@property (nonatomic,assign) NSUInteger count;

@end

@implementation MineColumnCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT17;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)countsLabel{
    
    if (!_countsLabel) {
        
        _countsLabel = [[UILabel alloc] init];
        _countsLabel.backgroundColor = Color_F74E4E;
        _countsLabel.font = FONT10;
        _countsLabel.textColor = [UIColor whiteColor];
        _countsLabel.textAlignment = NSTextAlignmentCenter;
        _countsLabel.layer.cornerRadius = 7;
        _countsLabel.layer.masksToBounds = YES;
        _countsLabel.hidden = YES;
    }
    return _countsLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andCount:(NSUInteger)count{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.count = count;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(20);
        make.width.height.offset(22);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(12);
        make.top.offset(0);
        make.bottom.offset(-1);
        make.right.offset(-50);
    }];
    
    [self addSubview:self.countsLabel];
    [self.countsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(23);
        make.right.offset(-35);
        make.width.height.offset(14);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_left);
        make.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(NSString *)iconName andTitle:(NSString *)title{
    
    self.iconImageView.image = [UIImage imageNamed:[NSString repleaseNilOrNull:iconName]];
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
}
-(void)showCount:(NSUInteger)count{
    
    if (count > 0) {
        
        self.countsLabel.hidden = NO;
        self.countsLabel.text = [[NSString alloc] initWithFormat:@"%ld",count];
    }
}

@end
