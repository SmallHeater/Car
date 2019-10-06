//
//  JobRecruitmentCell.h
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  求职招聘cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobRecruitmentCell : SHBaseTableViewCell

//title,标题;recommend,推荐;wage,工资;workType,工作类型;company,公司;address,位置;tabs,标签数组;
-(void)showDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
