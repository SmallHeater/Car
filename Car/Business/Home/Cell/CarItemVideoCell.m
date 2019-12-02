//
//  CarItemVideoCell.m
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarItemVideoCell.h"

@interface CarItemVideoCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * carNewImageView;
//浏览量，买家论坛
@property (nonatomic,strong) UILabel * pageviewsAndSourceLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation CarItemVideoCell

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

-(UIImageView *)carNewImageView{
    
    if (!_carNewImageView) {
        
        _carNewImageView = [[UIImageView alloc] init];
        _carNewImageView.backgroundColor = [UIColor clearColor];
        _carNewImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _carNewImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _carNewImageView.clipsToBounds = YES;
    }
    return _carNewImageView;
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

+(float)cellHeightWithTitle:(NSString *)title{
    
    float cellHeight = 0;
    cellHeight += 16;
    cellHeight += [title heightWithFont:FONT17 andWidth:MAINWIDTH - 46];
    cellHeight += 16;
    cellHeight += 190.0 / 345.0 * (MAINWIDTH - 30);
    cellHeight += 44;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(14);
        make.top.offset(16);
        make.right.offset(-31);
        make.height.offset(37);
    }];
    
    [self addSubview:self.carNewImageView];
    [self.carNewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(14);
        make.right.offset(-16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.height.equalTo(self.carNewImageView.mas_width).multipliedBy(190.0/345.0);
    }];
    
    [self addSubview:self.pageviewsAndSourceLabel];
    [self.pageviewsAndSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.carNewImageView.mas_left);
        make.top.equalTo(self.carNewImageView.mas_bottom).offset(16);
        make.right.equalTo(self.carNewImageView.mas_right);
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
        
        NSString * title = [NSString repleaseNilOrNull:model.title];
        self.titleLabel.text = [NSString repleaseNilOrNull:title];
        float labelHeight = [title heightWithFont:FONT17 andWidth:MAINWIDTH - 46];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.offset(labelHeight);
        }];
        
        NSString * pageviewsAndSourceStr = [[NSString alloc] initWithFormat:@"%ld浏览量 / %@",model.pv,model.section_title];
        self.pageviewsAndSourceLabel.text = pageviewsAndSourceStr;
        if (model.images && model.images.count > 0) {
            
            [self.carNewImageView sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
        }
    }
}

@end
