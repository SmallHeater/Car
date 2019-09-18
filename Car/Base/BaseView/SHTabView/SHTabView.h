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

-(instancetype)initWithItemsArray:(NSArray<SHTabModel *> *)itemsArray;

@end

NS_ASSUME_NONNULL_END
