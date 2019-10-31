//
//  JHBigPictureBrowsing.h
//  JHBigPictureBrowsing
//
//  Created by xianjunwang on 2018/3/30.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  大图浏览器


@interface SHBigPictureBrowsing : NSObject

/*
array,大图浏览的图片数组，可以是image的数组，也可是是图片链接的数组。index,当前显示的图片位于数组中的索引
 */

//展示大图浏览view
+(void)showViewWithArray:(NSMutableArray *)array andSelectedIndex:(NSUInteger)index;

@end
