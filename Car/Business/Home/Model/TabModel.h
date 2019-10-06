//
//  TabModel.h
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  切换项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabModel : NSObject

//tab项ID
@property (nonatomic,strong) NSString * tabID;
//标题
@property (nonatomic,strong) NSString * name;
//排序
@property (nonatomic,strong) NSString * sort;
//
@property (nonatomic,strong) NSString * position_id;
@property (nonatomic,strong) NSString * createtime;

@end

NS_ASSUME_NONNULL_END
