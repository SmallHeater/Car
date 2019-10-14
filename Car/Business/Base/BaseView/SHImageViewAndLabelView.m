//
//  SHImageViewAndLabelView.m
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHImageViewAndLabelView.h"

@interface SHImageViewAndLabelView ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@property (nonatomic,strong) NSString * imageUrlStr;
@property (nonatomic,strong) NSString * contentStr;
//是否显示右侧分割线
@property (nonatomic,assign) BOOL isShowLine;

@end

@implementation SHImageViewAndLabelView

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlStr]];
    }
    return _iconImageView;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT10;
        _contentLabel.textColor = Color_333333;
        _contentLabel.text = self.contentStr;
    }
    return _contentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_D8D8D8;
    }
    return _lineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithImageUrlStr:(NSString *)imageUrlStr andText:(NSString *)text andShowLine:(BOOL)show{
    
    self = [super init];
    if (self) {
        
        self.imageUrlStr = [NSString repleaseNilOrNull:imageUrlStr];
        self.contentStr = [NSString repleaseNilOrNull:text];
        self.isShowLine = show;
        [self drawUI];
    }
    return self;
}


#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.offset(1);
        make.bottom.offset(-1);
        make.width.offset(12);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(3);
        make.top.bottom.offset(0);
        make.right.offset(-5);
    }];
    
    if (self.isShowLine) {
        
        [self addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(0);
            make.top.offset(3);
            make.bottom.offset(-3);
            make.width.offset(1);
        }];
    }
}

@end
