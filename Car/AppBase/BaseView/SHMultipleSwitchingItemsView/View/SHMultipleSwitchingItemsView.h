//
//  SHMultipleSwitchingItemsView.h
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  横向有多个切换项的view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SHMultipleSwitchingItemsViewDelegate <NSObject>

-(void)selectedWithBtnTag:(NSUInteger)btnTag;

@end


@interface SHMultipleSwitchingItemsView : UIView

@property (nonatomic,weak) id<SHMultipleSwitchingItemsViewDelegate>delegate;

//normalTitleColor,正常标题颜色;selectedTitleColor,选中标题颜色;normalTitle,正常标题;selectedTitle,选中标题;normalFont,正常字体,NSNumber类型;selectedfont,选中字体，NSNumber类型;
-(instancetype)initWithItemsArray:(NSArray<NSDictionary *> *)itemsArray;

//设置按钮为选中
-(void)setBtnSelectedWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
