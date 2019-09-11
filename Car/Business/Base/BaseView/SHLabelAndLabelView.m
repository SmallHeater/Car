//
//  SHLabelAndLabelView.m
//  Car
//
//  Created by mac on 2019/9/9.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHLabelAndLabelView.h"

@interface SHLabelAndLabelView ()

@property (nonatomic,strong) UILabel * topLabel;
@property (nonatomic,strong) UILabel * bottomLabel;
@property (nonatomic,assign) float topLabelHeight;
@property (nonatomic,assign) float bottomLabelHeight;


@end

@implementation SHLabelAndLabelView

#pragma mark  ----  懒加载

-(UILabel *)topLabel{
    
    if (!_topLabel) {
        
        _topLabel = [[UILabel alloc] init];
    }
    return _topLabel;
}

-(UILabel *)bottomLabel{
    
    if (!_bottomLabel) {
     
        _bottomLabel = [[UILabel alloc] init];
    }
    return _bottomLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTopStr:(NSString *)topStr andTopLabelHeight:(float)topHeight andBottomStr:(NSString *)bottomStr andBottomHeight:(float)bottomHeight{
    
    self = [super init];
    if (self) {
        
        self.topLabelHeight = topHeight;
        self.bottomLabelHeight = bottomHeight;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            [self drawUI];
        });
        self.topLabel.text = [NSString repleaseNilOrNull:topStr];
        self.bottomLabel.text = [NSString repleaseNilOrNull:bottomStr];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(weakSelf.topLabelHeight);
    }];
    
    [self addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.offset(0);
        make.height.offset(weakSelf.bottomLabelHeight);
    }];
}

-(void)refreshTopLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)botomLabelText{
    
    if ([NSString strIsEmpty:topLabelText]) {
        
        self.topLabel.text = topLabelText;
    }
    
    if ([NSString strIsEmpty:botomLabelText]) {
        
        self.bottomLabel.text = botomLabelText;
    }
}

-(void)setTopLabelFont:(UIFont *)topLabelFont bottomLabelFont:(UIFont *)botomLabelFont{
    
    if (topLabelFont) {
        
        self.topLabel.font = topLabelFont;
    }
    
    if (botomLabelFont) {
        
        self.bottomLabel.font = botomLabelFont;
    }
}

-(void)setTopLabelTextColor:(UIColor *)topLabelTextColor bottomLabelTextColor:(UIColor *)botomLabelTextColor{
    
    if (topLabelTextColor) {
        
        self.topLabel.textColor = topLabelTextColor;
    }
    
    if (botomLabelTextColor) {
        
        self.bottomLabel.textColor = botomLabelTextColor;
    }
}

-(void)setTopLabelTextAlignment:(NSTextAlignment)topLabelTextAlignment bottomLabelTextAlignment:(NSTextAlignment)botomLabelTextAlignment{
    
    if (topLabelTextAlignment) {
        
        self.topLabel.textAlignment = topLabelTextAlignment;
    }
    
    if (botomLabelTextAlignment) {
        
        self.bottomLabel.textAlignment = botomLabelTextAlignment;
    }
}

@end
