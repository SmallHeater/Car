//
//  SearchConfigurationModel.h
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  搜索配置模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchConfigurationModel : NSObject

//未添加搜索属性的请求参字典
@property (nonatomic,nullable,strong) NSDictionary * baseBodyParameters;
//请求地址
@property (nonatomic,nullable,strong) NSString * requestUrlStr;
//返回数据模型类名
@property (nonatomic,nullable,strong) NSString * modelName;
//cell高度
@property (nonatomic,assign) float cellHeight;

@end

NS_ASSUME_NONNULL_END
