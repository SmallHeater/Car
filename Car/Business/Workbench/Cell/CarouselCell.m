//
//  CarouselCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarouselCell.h"
#import "SHCarouselView.h"
#import "CarouselModel.h"

@interface CarouselCell ()

@property (nonatomic,assign) CarouselStyle style;

@property (nonatomic,strong) SHCarouselView * carouselView;

@end

@implementation CarouselCell

#pragma mark  ----  懒加载

-(SHCarouselView *)carouselView{
    
    if (!_carouselView) {
        
        _carouselView = [[SHCarouselView alloc] initWithPageControlType:PageControlType_MiddlePage];
        if (self.style == CarouselStyle_gongzuotai) {
            
            _carouselView.layer.cornerRadius = 15;
            _carouselView.layer.masksToBounds = YES;
        }
    }
    return _carouselView;
}

#pragma mark  ----  SET

-(void)setClickCallBack:(ClickCallBack)clickCallBack{
    
    if (clickCallBack) {
        
        self.carouselView.clickCallBack = clickCallBack;
    }
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andStyle:(CarouselStyle)style{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.style = style;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.carouselView];
    if (self.style == CarouselStyle_gongzuotai) {
     
        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(15);
            make.right.offset(-16);
            make.top.bottom.offset(20);
            make.bottom.offset(-20);
        }];
    }
    else if(self.style == CarouselStyle_shouye){
        
        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.bottom.offset(0);
        }];
    }
}

-(void)showData:(NSArray<CarouselModel *> *)array{
    
    NSMutableArray * carouselDicArray = [[NSMutableArray alloc] init];
    for (CarouselModel * model in array) {
        
        NSString * CarouselImageUrlStr = [[NSString alloc] initWithFormat:@"%@",model.image];
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.CarouselId,@"CarouselId",CarouselImageUrlStr,@"CarouselImageUrlStr", nil];
        [carouselDicArray addObject:dic];
    }
    [self.carouselView refreshData:carouselDicArray];
}

@end
