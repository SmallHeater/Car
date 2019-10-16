//
//  CarouselCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播区cell

NS_ASSUME_NONNULL_BEGIN

@class CarouselModel;

typedef NS_ENUM(NSUInteger,CarouselStyle){
    
    CarouselStyle_gongzuotai,//工作台页面轮播区样式
    CarouselStyle_shouye //首页页面轮播区样式
};

typedef void(^ClickCallBack)(NSString * urlStr);

@interface CarouselCell : SHBaseTableViewCell

@property (nonatomic,copy) ClickCallBack clickCallBack;

-(void)showData:(NSArray<CarouselModel *> *)array;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andStyle:(CarouselStyle)style;

@end

NS_ASSUME_NONNULL_END
