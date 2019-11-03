//
//  ImageAndTitleBtn.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  图片，文字的按钮,默认字号是14，字体颜色是Color_333333

#import <UIKit/UIKit.h>

@interface SHImageAndTitleBtn : UIControl

-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title;

//刷新文字
-(void)refreshTitle:(NSString *)title;
//刷新色值
-(void)refreshColor:(UIColor *)textColor;
//刷新字号
-(void)refreshFont:(UIFont *)labelFont;
//刷新图片
-(void)refreshImage:(NSString *)imageName orImageUrlStr:(NSString *)imageUrlStr;
//设置图片圆角
-(void)setImageViewCornerRadius:(float)cornerRadius;
//设置图片地址
-(void)setImageUrl:(NSString *)imageUrl;

@end
