//
//  FilletBtn.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 IP. All rights reserved.
//

#import "FilletBtn.h"

@interface FilletBtn ()

@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIColor * selectedTitleColor;


@end

@implementation FilletBtn

#pragma mark  ----  自定义函数

+(float)getBtnWidthWithTitle:(NSString *)btnTitle andBtnFont:(UIFont *)font andBtnHeight:(float)height{
    
    float titleWidth = [[btnTitle repleaseNilOrNull] widthWithFont:font andHeight:height];
    return titleWidth + 27 * 2;
}

#pragma mark  ----  SET

-(void)setFrame:(CGRect)frame{
    
    super.frame = frame;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.height / 2;
    self.layer.borderWidth = 0.5;
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    
    [super setTitleColor:color forState:state];
    if (state == UIControlStateSelected) {
        
        self.selectedTitleColor = color;
    }
    else if (state == UIControlStateNormal){
        
        self.titleColor = color;
    }
}

-(void)setSelected:(BOOL)selected{
    
    super.selected = selected;
    if (selected) {
        
        self.layer.borderColor = self.selectedTitleColor.CGColor;
    }
    else{
        
         self.layer.borderColor = self.titleColor.CGColor;
    }
}

@end
