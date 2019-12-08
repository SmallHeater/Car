//
//  HoverPageViewController.h
//  HoverPageViewController <https://github.com/QiaokeZ/iOS_HoverPageViewController>
//
//  Created by admin on 2019/2/27
//  Copyright © 2019 zhouqiao. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>
#import "HoverChildViewController.h"

@class HoverPageViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol HoverPageViewControllerDelegate <NSObject>
@optional
- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

@interface HoverPageViewController : UIViewController

- (instancetype)initWithViewControllers:(NSArray<HoverChildViewController *> *)viewControllers
                             headerView:(UIView *)headerView
                          pageTitleView:(UIView *)pageTitleView;

+ (instancetype)viewControllers:(NSArray<HoverChildViewController *> *)viewControllers
                     headerView:(UIView *)headerView
                  pageTitleView:(UIView *)pageTitleView;

@property(nonatomic, strong, readonly) NSArray<HoverChildViewController *> *viewControllers;
@property(nonatomic, strong, readonly) UIView *headerView;
@property(nonatomic, strong, readonly) UIView *pageTitleView;
@property(nonatomic, assign, readonly) NSUInteger currentIndex;
@property(nonatomic, weak) id<HoverPageViewControllerDelegate> delegate;

- (void)moveToAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
