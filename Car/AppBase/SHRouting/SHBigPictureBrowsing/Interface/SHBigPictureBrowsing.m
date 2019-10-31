//
//  JHBigPictureBrowsing.m
//  JHBigPictureBrowsing
//
//  Created by xianjunwang on 2018/3/30.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHBigPictureBrowsing.h"
#import "BigPictureBrowsing.h"


@implementation SHBigPictureBrowsing

//展示大图浏览view
+(void)showViewWithArray:(NSMutableArray *)array andSelectedIndex:(NSUInteger)index{
    
    BigPictureBrowsing * view = [[BigPictureBrowsing alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT) andArray:array andSelectedIndex:index];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

@end
