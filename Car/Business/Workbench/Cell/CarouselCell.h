//
//  CarouselCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播区cell

NS_ASSUME_NONNULL_BEGIN

@class CarouselModel;

typedef void(^ClickCallBack)(NSString * urlStr);

@interface CarouselCell : SHBaseTableViewCell

@property (nonatomic,copy) ClickCallBack clickCallBack;

-(void)showData:(NSArray<CarouselModel *> *)array;

@end

NS_ASSUME_NONNULL_END
