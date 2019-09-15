//
//  EvaImageView.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/5.
//  Copyright © 2017年 pk. All rights reserved.
//  带删除按钮的imageView

#import <UIKit/UIKit.h>

typedef void(^DeleteCallBack)(NSUInteger btnTag);

@interface SHImageViewWithDeleteBtn : UIView

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,copy) DeleteCallBack deleteCallBack;


//实例化方法
-(instancetype)initWithImage:(UIImage *)image andButtonTag:(NSUInteger)btnTag;


@end
