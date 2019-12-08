//
//  HoverPageScrollView.h
//  HoverDome_OC
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 com.etraffic.EasyCharging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoverPageScrollView : UIScrollView<UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSArray *scrollViewWhites;

@end

NS_ASSUME_NONNULL_END
