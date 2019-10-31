//
//  SHImageAndLabelControl.h
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  上方图片，下方文字的按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHImageAndLabelControl : UIControl

@property (readonly,nonatomic,strong) NSString * title;

//本地图片实例化方式
-(instancetype)initWithImageName:(NSString *)imageName andImageSize:(CGSize)imageSize andTitle:(NSString *)title;
//网络图片实例化方式
-(instancetype)initWithImageUrl:(NSString *)imageUrl andImageSize:(CGSize)imageSize andTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
