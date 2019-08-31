//
//  AnnouncementCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  公告cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AnnouncementModel;

@interface AnnouncementCell : UITableViewCell

-(void)showData:(NSArray<AnnouncementModel *> *)array;

@end

NS_ASSUME_NONNULL_END
