//
//  SHPageControl.h
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  自定义样式的pageControl

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHPageControl : UIPageControl

@property (nonatomic, strong) UIImage * currentImage;

@property (nonatomic, strong) UIImage * inactiveImage;

@property (nonatomic, assign) CGSize currentImageSize;

@property (nonatomic, assign) CGSize inactiveImageSize;

@end

NS_ASSUME_NONNULL_END
