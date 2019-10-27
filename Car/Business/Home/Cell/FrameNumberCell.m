//
//  FrameNumberCell.m
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FrameNumberCell.h"

@interface FrameNumberCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation FrameNumberCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_666666;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT16;
        _contentLabel.textColor = Color_333333;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DEDEDE;
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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(17);
        make.top.bottom.offset(0);
        make.width.offset(80);
    }];
    
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.offset(-21);
        make.top.bottom.offset(0);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.offset(0);
        make.height.offset(1);
        make.left.offset(15);
        make.right.offset(-15);
    }];
}

-(void)showTitle:(NSString *)title andContent:(NSString *)content{
    
    NSString * titleStr = [NSString repleaseNilOrNull:title];
    float width = [titleStr widthWithFont:FONT16 andHeight:50];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.bottom.offset(0);
        make.width.offset(width);
    }];
    
    self.titleLabel.text = titleStr;
    self.contentLabel.text = [NSString repleaseNilOrNull:content];
}

@end
