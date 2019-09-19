//
//  CarItemSingleCell.m
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarItemSingleCell.h"

@interface CarItemSingleCell ()

@property (nonatomic,strong) UILabel * contentLabel;
//浏览量，买家论坛
@property (nonatomic,strong) UILabel * pageviewsAndSourceLabel;
@property (nonatomic,strong) UIImageView * carNewImageView;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation CarItemSingleCell

#pragma mark  ----  懒加载

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT17;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)pageviewsAndSourceLabel{
    
    if (!_pageviewsAndSourceLabel) {
        
        _pageviewsAndSourceLabel = [[UILabel alloc] init];
        _pageviewsAndSourceLabel.font = FONT12;
        _pageviewsAndSourceLabel.textColor = Color_999999;
    }
    return _pageviewsAndSourceLabel;
}

-(UIImageView *)carNewImageView{
    
    if (!_carNewImageView) {
        
        _carNewImageView = [[UIImageView alloc] init];
        _carNewImageView.backgroundColor = [UIColor clearColor];
    }
    return _carNewImageView;
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

-(void)drawUI{
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.height.offset(20);
        make.right.offset(149);
        make.height.offset(37);
    }];
    
    [self addSubview:self.pageviewsAndSourceLabel];
    [self.pageviewsAndSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentLabel.mas_left);
        make.top.offset(90);
        make.width.equalTo(self.contentLabel.mas_width);
        make.height.offset(12);
    }];
    
    [self addSubview:self.carNewImageView];
    [self.carNewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.offset(113);
        make.height.offset(86);
        make.top.offset(21);
        make.right.offset(-16);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(CarItemNewModel *)model{
    
    if (model) {
        
        self.contentLabel.text = [NSString repleaseNilOrNull:model.title];
        NSString * pageviewsAndSourceStr = [[NSString alloc] initWithFormat:@"%ld浏览量 / %@",model.pv.integerValue,model.section_title];
        self.pageviewsAndSourceLabel.text = pageviewsAndSourceStr;
        if (model.images && model.images.count > 0) {
            
            [self.carNewImageView sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
        }
    }
}

@end
