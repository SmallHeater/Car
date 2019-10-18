//
//  MyShoppingCartView.h
//  Car
//
//  Created by xianjun wang on 2019/10/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  我的购物车view(机油专卖那里)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OilGoodModel;

@interface MyShoppingCartView : UIView

-(instancetype)initWithArray:(NSMutableArray<OilGoodModel *> *)array;

@end

NS_ASSUME_NONNULL_END
