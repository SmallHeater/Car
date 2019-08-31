//
//  CarouselCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播区cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CarouselModel;

@interface CarouselCell : UITableViewCell

-(void)showData:(NSArray<CarouselModel *> *)array;

@end

NS_ASSUME_NONNULL_END
