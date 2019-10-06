//
//  PostJobBaseCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobBaseCell.h"

@interface PostJobBaseCell ()

@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation PostJobBaseCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_666666;
    }
    return _titleLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andShowBottomLine:(BOOL)isShow{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawBaseUI];
        self.titleLabel.text = [NSString repleaseNilOrNull:title];
        self.bottomLineLabel.hidden = !isShow;
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawBaseUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.offset(0);
        make.width.offset(70);
        make.bottom.offset(-1);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

@end
