//
//  SearchBarCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  工作台页面，搜索框cell

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearchCallBack)(NSString * searchText);
typedef void(^ScanningCallBack)();


@interface SearchBarCell : SHBaseTableViewCell

//搜索的回调
@property (nonatomic,copy) SearchCallBack searchCallBack;
//扫描识别的回调
@property (nonatomic,copy) ScanningCallBack scanningCallBack;

@end

NS_ASSUME_NONNULL_END
