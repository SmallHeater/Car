//
//  JobModel.h
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  招聘模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobModel : NSObject

@property (nonatomic,strong) NSString * jobModelId;
//工资
@property (nonatomic,strong) NSString * monthly_salary;
//标签
@property (nonatomic,strong) NSString * benefit_ids;
@property (nonatomic,strong) NSNumber * job_id;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSNumber * education_id;
@property (nonatomic,strong) NSNumber * experience_id;
@property (nonatomic,strong) NSNumber * workplace_id;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * tab_ids;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * user_id;
//职位描述
@property (nonatomic,strong) NSString * jobDescription;
//商户名称
@property (nonatomic,strong) NSString * shop_name;
//商户电话
@property (nonatomic,strong) NSString * shop_phone;
// 商户头像
@property (nonatomic,strong) NSString * shop_avatar;
//商户信用值
@property (nonatomic,strong) NSString * shop_credit;
//标签项（福利）
@property (nonatomic,strong) NSArray<NSDictionary *> * benefits;

@end

NS_ASSUME_NONNULL_END
