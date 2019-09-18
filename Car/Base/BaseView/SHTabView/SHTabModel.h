//
//  SHTabModel.h
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  页签项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTabModel : NSObject

//标题
@property (nonatomic,strong) NSString * tabTitle;
//默认字号
@property (nonatomic,strong) UIFont * normalFont;
//默认字体颜色
@property (nonatomic,strong) UIColor * normalColor;
//选中字号
@property (nonatomic,strong) UIFont * selectedFont;
//选中字体颜色
@property (nonatomic,strong) UIColor * selectedColor;



@end

NS_ASSUME_NONNULL_END
