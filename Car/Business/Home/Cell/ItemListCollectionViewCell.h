//
//  ItemListCollectionViewCell.h
//  Car
//
//  Created by xianjun wang on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  菜单项的新闻列表的一个列表的cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemListCollectionViewCell : UICollectionViewCell

//请求数据
-(void)requestWithTabID:(NSString *)tabID;

@end

NS_ASSUME_NONNULL_END
