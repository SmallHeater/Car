//
//  CarouselCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarouselCell.h"
#import "CarouselView.h"

@interface CarouselCell ()

@property (nonatomic,strong) CarouselView * carouselView;

@end

@implementation CarouselCell

#pragma mark  ----  懒加载

-(CarouselView *)carouselView{
    
    if (!_carouselView) {
        
        _carouselView = [[CarouselView alloc] init];
        _carouselView.layer.cornerRadius = 15;
        _carouselView.layer.masksToBounds = YES;
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

-(void)drawUI{
    
    [self addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-16);
        make.top.bottom.offset(0);
    }];
}

@end
