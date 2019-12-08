//
//  HoverPageScrollView.m
//  HoverDome_OC
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 com.etraffic.EasyCharging. All rights reserved.
//

#import "HoverPageScrollView.h"

@implementation HoverPageScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (self.scrollViewWhites == nil) return YES;
    for (UIScrollView *item in self.scrollViewWhites) {
        if (otherGestureRecognizer.view == item){
            return YES;
        }
    }
    return NO;
}
@end
