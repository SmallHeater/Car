
//
//  ResidualTransactionCarouseCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionCarouseCell.h"
#import "CarouselView.h"


@interface ResidualTransactionCarouseCell ()

@property (nonatomic,strong) CarouselView * carouselView;

@end

@implementation ResidualTransactionCarouseCell

#pragma mark  ----  懒加载

-(CarouselView *)carouselView{
    
    if (!_carouselView) {
        
        _carouselView = [[CarouselView alloc] initWithPageControlType:PageControlType_MiddlePage];
    }
    return _carouselView;
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

+(float)cellHeight{
    
    return 300.0 / 375.0 * MAINWIDTH;
}

-(void)drawUI{
    
    [self addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

@end
