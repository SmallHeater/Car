//
//  ForumDetailCell.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailTitleCell.h"

@interface ForumDetailTitleCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * iconImageView;

@end

@implementation ForumDetailTitleCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT24;
        _titleLabel.textColor = Color_333333;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
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

+(float)cellHeightWithModel:(ForumArticleModel *)model{
    
    float cellHeight = [model.title heightWithFont:BOLDFONT24 andWidth:MAINWIDTH -  16 * 2] + 14 * 2;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(14);
        make.bottom.offset(-14);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    self.titleLabel.text = [NSString repleaseNilOrNull:model.title];
}

@end
