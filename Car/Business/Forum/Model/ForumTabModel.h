//
//  ForumTabModel.h
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛头部数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForumTabModel : NSObject

@property(nonatomic,assign) NSUInteger count;
@property(nonatomic,strong) NSString * createtime;
@property(nonatomic,strong) NSString * ForumID;
@property(nonatomic,strong) NSString * image;
@property(nonatomic,assign) NSUInteger sort;
@property(nonatomic,strong) NSString * title;

//是否选中
@property (nonatomic,assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
