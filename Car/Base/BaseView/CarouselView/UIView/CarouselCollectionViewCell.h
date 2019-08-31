//
//  CarouselCollectionViewCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播view的cell

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class CarouselDataModel;

@interface CarouselCollectionViewCell : UICollectionViewCell

-(void)showWithModel:(CarouselDataModel *)model;

@end

NS_ASSUME_NONNULL_END
