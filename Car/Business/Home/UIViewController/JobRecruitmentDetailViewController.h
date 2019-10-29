//
//  JobRecruitmentDetailViewController.h
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  求职招聘详情页

#import "SHBaseTableViewController.h"
#import "JobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobRecruitmentDetailViewController : SHBaseTableViewController

//招聘参数字典,jobOptionDic;招聘信息模型，jobModel;
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andJobOptionDic:(NSDictionary *)JobOptionDic andJobModel:(JobModel *)jobModel;

@end

NS_ASSUME_NONNULL_END
