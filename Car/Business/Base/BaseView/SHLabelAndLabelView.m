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

@end

@implementation SHLabelAndLabelView

#pragma mark  ----  懒加载

#pragma mark  ----  生命周期函数

-(instancetype)initWithTopStr:(NSString *)topStr andBottomStr:(NSString *)bottomStr{
    
    self = [super init];
    if (self) {
        
        [self drawUI];
        self.topLabel.text = [NSString repleaseNilOrNull:topStr];
        self.bottomLabel.text = [NSString repleaseNilOrNull:bottomStr];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    
}

@end
