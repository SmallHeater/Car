//
//  ForumListViewController.h
//  Car
//
//  Created by mac on 2019/12/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛列表页面

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForumListViewController : SHBaseTableViewController

-(void)requestSectionListWithTabID:(NSString *)tabId;

@end

NS_ASSUME_NONNULL_END
