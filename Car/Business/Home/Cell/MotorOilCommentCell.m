//
//  MotorOilCommentCell.m
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilCommentCell.h"

@interface MotorOilCommentCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * dateLabel;
//评价
@property (nonatomic,strong) UILabel * commentLabel;
//内容
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation MotorOilCommentCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 35;
    }
    return _iconImageView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT12;
        _nameLabel.textColor = Color_333333;
    }
    return _nameLabel;
}

-(UILabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT10;
        _dateLabel.textColor = Color_999999;
    }
    return _dateLabel;
}

-(UILabel *)commentLabel{
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = FONT10;
        _commentLabel.textColor = Color_999999;
        _commentLabel.text = @"评价";
    }
    return _commentLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT12;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
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

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(10);
        make.width.height.offset(35);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.offset(-70);
        make.height.offset(17);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(0);
        make.top.offset(13);
        make.width.offset(70);
        make.height.offset(14);
    }];
    
    
}

@end
