//
//  CarItemNewModel.h
//  Car
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  首页新闻模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface CarItemNewModel : NSObject

@property (nonatomic,strong) NSString * articleID;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSNumber * sort;
@property (nonatomic,strong) NSNumber * position_id;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSNumber * section_id;
//栏目
@property (nonatomic,strong) NSString * section_title;
//目前只有三种类型：single:单图、three:三图、video:视频
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSNumber * pv;
@property (nonatomic,strong) NSString * tab_ids;
@property (nonatomic,strong) NSNumber * topswitch;
//content富文本网页形式呈现
@property (nonatomic,strong) NSString * url;

@end

NS_ASSUME_NONNULL_END
