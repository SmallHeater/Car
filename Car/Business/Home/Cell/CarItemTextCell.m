//
//  CarItemSingleCell.m
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarItemTextCell.h"

@interface CarItemTextCell ()

@property (nonatomic,strong) UILabel * titleLabel;
//浏览量，买家论坛
@property (nonatomic,strong) UILabel * pageviewsAndSourceLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation CarItemTextCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT17;
        _titleLabel.textColor = Color_333333;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)pageviewsAndSourceLabel{
    
    if (!_pageviewsAndSourceLabel) {
        
        _pageviewsAndSourceLabel = [[UILabel alloc] init];
        _pageviewsAndSourceLabel.font = FONT12;
        _pageviewsAndSourceLabel.textColor = Color_999999;
    }
    return _pageviewsAndSourceLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

+(float)cellHeight:(ForumArticleModel *)model{
    
    return [[NSString repleaseNilOrNull:model.title] heightWithFont:FONT17 andWidth:MAINWIDTH - 14 * 2] + 16 * 3 + 12 + 1;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(14);
        make.top.offset(16);
        make.right.offset(-14);
        make.bottom.offset(-45);
    }];
    
    [self addSubview:self.pageviewsAndSourceLabel];
    [self.pageviewsAndSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.offset(-17);
        make.width.offset(MAINWIDTH - 14 * 2);
        make.height.offset(12);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    if (model) {
        
        self.titleLabel.text = [NSString repleaseNilOrNull:model.title];
        NSString * pageviewsAndSourceStr = [[NSString alloc] initWithFormat:@"%ld浏览量 / %@",model.pv,model.section_title];
        self.pageviewsAndSourceLabel.text = pageviewsAndSourceStr;
    }
}

@end
