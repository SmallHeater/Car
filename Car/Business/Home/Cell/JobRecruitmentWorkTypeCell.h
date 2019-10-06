//
//  JobRecruitmentWorkTypeCell.h
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  招聘详情页工种cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobRecruitmentWorkTypeCell : SHBaseTableViewCell

//title,标题;wage,工资;workType,工作类型;tabs,标签数组;
-(void)showDic:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
