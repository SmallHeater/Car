//
//  SHBaseTableViewCell.h
//  Car
//
//  Created by xianjun wang on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  cell的base类，默认去掉选中效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHBaseTableViewCell : UITableViewCell

//默认样式
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
