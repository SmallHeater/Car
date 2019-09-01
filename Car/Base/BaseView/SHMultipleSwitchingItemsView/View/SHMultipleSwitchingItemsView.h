//
//  SHMultipleSwitchingItemsView.h
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  横向有多个切换项的view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMultipleSwitchingItemsView : UIView

//normalTitleColor,正常标题颜色;selectedTitleColor,选中标题颜色;normalTitle,正常标题;selectedTitle,选中标题;normalFont,正常字体;selectedfont,选中字体;
-(instancetype)initWithItemsArray:(NSArray<NSDictionary *> *)itemsArray;

@end

NS_ASSUME_NONNULL_END
