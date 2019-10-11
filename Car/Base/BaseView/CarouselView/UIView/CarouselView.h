//
//  CarouselView.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  轮播view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickCallBack)(NSString * urlStr);

typedef NS_ENUM(NSUInteger,PageControlType){
    
    PageControlType_Default = 0,//默认没有
    PageControlType_MiddlePage,//中间小白点
    PageControlType_RightLabel//右侧数值
};

@interface CarouselView : UIView

@property (nonatomic,copy) ClickCallBack clickCallBack;

-(instancetype)initWithPageControlType:(PageControlType)type;

//CarouselId:唯一标识;type:0,图片;CarouselImageUrlStr:显示的图片地址;urlStr:点击之后打开的链接
-(void)refreshData:(NSArray<NSDictionary *> *)array;

@end

NS_ASSUME_NONNULL_END
