//
//  CarTestCell.h
//  Car
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarTestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *markIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end

NS_ASSUME_NONNULL_END
