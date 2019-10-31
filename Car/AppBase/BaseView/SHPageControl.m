//
//  SHPageControl.m
//  Car
//
//  Created by xianjun wang on 2019/8/31.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHPageControl.h"

@interface SHPageControl ()

@end

@implementation SHPageControl

#pragma mark  ----  SET

- (void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    [self removeDefaultWhitePoint];
    [self updateDots];
}

#pragma mark  ----  生命周期函数

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

#pragma mark  ----  自定义函数
//移除小白点
-(void)removeDefaultWhitePoint{
    
    //设置原始小白点大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIView * subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 0;
        size.width = 0;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

- (void)updateDots{
    
    for (int i = 0; i < [self.subviews count]; i++) {
        
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            
            dot.image = self.currentImage;
            dot.bounds = CGRectMake(0, 0, self.currentImageSize.width, self.currentImageSize.height);
        }else{
            
            dot.image = self.inactiveImage;
            dot.bounds = CGRectMake(0, 0, self.inactiveImageSize.width, self.inactiveImageSize.height);
        }
    }
}

- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        
        for (UIView *subview in view.subviews) {
            
            if ([subview isKindOfClass:[UIImageView class]]) {
                
                dot = (UIImageView *)subview;
                break;
            }
        }

        if (dot == nil) {
            
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }else {
        
        dot = (UIImageView *)view;
        
    }

    return dot;
}

@end
