//
//  HoverChildViewController.h
//  HoverDome_OC
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 com.etraffic.EasyCharging. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HoverChildViewController;

@protocol HoverChildViewControllerDelegate <NSObject>
@optional
- (void)hoverChildViewController:(HoverChildViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface HoverChildViewController : UIViewController

@property(nonatomic, assign) CGFloat offsetY;
@property(nonatomic, assign) BOOL isCanScroll;
@property(nonatomic, weak) id<HoverChildViewControllerDelegate> scrollDelegate;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
