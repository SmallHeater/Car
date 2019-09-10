//
//  EvaImageView.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/5.
//  Copyright © 2017年 pk. All rights reserved.
//  带删除按钮的imageView,deleteAction事件会添加给button

#import <UIKit/UIKit.h>

@interface SHImageViewWithDeleteBtn : UIView
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIImage * showImg;
//删除事件，添加，则右上角显示删除按钮；不添加或者置为nil，删除按钮移除
@property (nonatomic,assign) SEL deleteAction;


//实例化方法，传递图片的点击事件
-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)rect andTarget:(id)target andAction:(SEL)action andButtonTag:(NSUInteger)btnTag;
//添加删除响应
-(void)addDeleteTarget:(id)target andAction:(SEL)action andBtnTag:(NSUInteger)tag;

@end
