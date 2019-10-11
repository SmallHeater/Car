//
//  JobRecruitmenDescriptionCell.h
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  招聘详情页描述cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobRecruitmenDescriptionCell : SHBaseTableViewCell

+(float)cellHeightWithContent:(NSString *)content;

//工作经验要求，学历要求，内容
-(void)showWorkExperienceRequirements:(NSString *)workExper academicRequirements:(NSString *)acadeStr content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
