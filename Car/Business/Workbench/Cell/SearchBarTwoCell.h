//
//  SearchBarTwoCell.h
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车辆档案列表,搜索cell

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearchCallBack)(NSString * searchText);

@interface SearchBarTwoCell : SHBaseTableViewCell

@property (nonatomic,copy) SearchCallBack searchCallBack;

@end

NS_ASSUME_NONNULL_END
