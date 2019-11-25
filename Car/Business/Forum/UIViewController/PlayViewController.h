//
//  PushAndPlayViewController.h
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  播放页面

#import "SHBaseTableViewController.h"
#import "VideoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlayViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andDataArray:(NSMutableArray<VideoModel *> *)dataArray andSelectIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
