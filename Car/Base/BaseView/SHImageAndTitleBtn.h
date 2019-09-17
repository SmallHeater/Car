//
//  ImageAndTitleBtn.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  图片，文字的按钮

#import <UIKit/UIKit.h>

@interface SHImageAndTitleBtn : UIControl

-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title andTarget:(id)target andAction:(SEL)action;

//刷新文字和色值
-(void)refreshTitle:(NSString *)title color:(UIColor *)textColor;
//刷新字号
-(void)refreshFont:(UIFont *)labelFont;
//刷新图片
-(void)refreshImage:(NSString *)imageName orImageUrlStr:(NSString *)imageUrlStr;


@end
