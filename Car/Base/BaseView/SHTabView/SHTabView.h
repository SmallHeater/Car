//
//  SHTabView.h
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  可滑动的页签view

#import <UIKit/UIKit.h>
#import "SHTabModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHTabView : UIView

//页签数组;是否显示右侧更多按钮
-(instancetype)initWithItemsArray:(NSArray<SHTabModel *> *)itemsArray showRightBtn:(BOOL)isShow;

//设置对应的索引按钮选中
-(void)selectItemWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
