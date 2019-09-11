//
//  ReturnRecordCell.h
//  Car
//
//  Created by mac on 2019/9/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  回款记录cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReturnRecordCell : UITableViewCell

-(void)showTime:(NSString *)time andMoney:(NSNumber *)money;

@end

NS_ASSUME_NONNULL_END
