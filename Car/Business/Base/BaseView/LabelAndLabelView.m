//
//  LabelAndLabelView.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/26.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "LabelAndLabelView.h"

@interface LabelAndLabelView (){
    
    BOOL hadAddAboveLabel;//是否已添加上方的label
    BOOL hadAddBelowLabel;//是否已添加下方的label
}
@end


@implementation LabelAndLabelView

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame andAboveLabelText:(NSString * )aboveLabelText andBelowLabelText:(NSString *)belowLabelText{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = Color_FFFFFF;
        
        if (aboveLabelText && aboveLabelText.length > 0) {
            
            self.aboveLabel.text = aboveLabelText;
            [self addSubview:self.aboveLabel];
            hadAddAboveLabel = YES;
        }
        else{
            
            hadAddAboveLabel = NO;
        }
        
        
        if (belowLabelText && belowLabelText.length > 0) {
            
            self.belowLabel.text = belowLabelText;
            [self addSubview:self.belowLabel];
            hadAddBelowLabel = YES;
        }
        else{
            
            hadAddBelowLabel = NO;
        }
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)refreshAboveLabelText:(NSString *)aboveLabelText belowLabelText:(NSString *)belowLabelText{
    
    if (aboveLabelText) {
        
        self.aboveLabel.text = aboveLabelText;
        
        if (!hadAddAboveLabel) {
            
            [self addSubview:self.aboveLabel];
        }
    }
    
    if (belowLabelText) {
        
        self.belowLabel.text = belowLabelText;
        
        if (!hadAddBelowLabel) {
            
            [self addSubview:self.belowLabel];
        }
    }
}

#pragma mark  ----  懒加载
-(UILabel *)aboveLabel{
    
    if (!_aboveLabel) {
        
        _aboveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 8 * 3)];
        _aboveLabel.font = FONT12;
        _aboveLabel.textColor = Color_333333;
        _aboveLabel.textAlignment = NSTextAlignmentCenter;
        _aboveLabel.backgroundColor = Color_E7E7E7;
    }
    return _aboveLabel;
}

-(UILabel *)belowLabel{
    
    if (!_belowLabel) {
        
        _belowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.aboveLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.aboveLabel.frame))];
        _belowLabel.font = BOLDFONT16;
        _belowLabel.textColor = Color_333333;
        _belowLabel.textAlignment = NSTextAlignmentCenter;
        _belowLabel.backgroundColor = Color_FFFFFF;
    }
    return _belowLabel;
}

@end
