//
//  PostJobRequestModel.h
//  Car
//
//  Created by mac on 2019/10/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布招聘信息接口请求模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostJobRequestModel : NSObject

@property (nonatomic,strong) NSString * user_id;
//标题
@property (nonatomic,strong) NSString * name;
//月薪（传值：1、区间传3000-5000，2、面议）
@property (nonatomic,strong) NSString * monthly_salary;
//福利待遇：多值：逗号分隔
@property (nonatomic,strong) NSString * benefit_ids;
//工作Id
@property (nonatomic,strong) NSString * job_id;
//工作描述
@property (nonatomic,strong) NSString * jobDescription;
//学历ID
@property (nonatomic,strong) NSString * education_id;
//工作年限ID
@property (nonatomic,strong) NSString * experience_id;
//工作场所ID
@property (nonatomic,strong) NSString * workplace_id;
//电话
@property (nonatomic,strong) NSString * phone;

@end

NS_ASSUME_NONNULL_END
