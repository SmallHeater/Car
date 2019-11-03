//
//  PostListCell.h
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  帖子列表cell

#import "SHBaseTableViewCell.h"



NS_ASSUME_NONNULL_BEGIN

@interface PostListCell : SHBaseTableViewCell

//imageUrl,图片地址;title,标题;pv,NSNumber,浏览量;section_title,来源;
-(void)show:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
