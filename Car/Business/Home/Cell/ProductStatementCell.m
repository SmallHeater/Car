//
//  ProductStatementCell.m
//  Car
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ProductStatementCell.h"

@interface ProductStatementCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * bottomLine;
@property (nonatomic,assign) BOOL isShowBottomLine;

@end

@implementation ProductStatementCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT14;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
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

-(UILabel *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = Color_F5F5F5;
    }
    return _bottomLine;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andShowBottomLine:(BOOL)show{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.isShowBottomLine = show;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(18);
        make.top.offset(10);
        make.right.offset(-18);
        make.height.offset(20);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.offset(-16);
        make.bottom.offset(-18);
    }];
    
    if (self.isShowBottomLine) {
        
        [self addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.offset(0);
            make.height.offset(8);
        }];
    }
}

-(void)show:(NSString *)title content:(NSString *)content{
    
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
    self.contentLabel.text = [NSString repleaseNilOrNull:content];
}


@end
