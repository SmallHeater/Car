//
//  SHMultipleSwitchingItemModel.h
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  切换项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMultipleSwitchingItemModel : NSObject

//正常标题颜色
@property (nonatomic,strong) UIColor * normalTitleColor;
//选中标题颜色
@property (nonatomic,strong) UIColor * selectedTitleColor;
//正常标题
@property (nonatomic,strong) NSString * normalTitle;
//选中标题
@property (nonatomic,strong) NSString * selectedTitle;
//正常字体
@property (nonatomic,strong) UIFont * normalFont;
//选中字体
@property (nonatomic,strong) UIFont * selectedfont;
//tag(必须)
@property (nonatomic,strong) NSNumber * btnTag;

@end

NS_ASSUME_NONNULL_END
