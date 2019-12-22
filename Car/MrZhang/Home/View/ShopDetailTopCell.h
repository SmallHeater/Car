//
//  ShopDetailTopCell.h
//  Car
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;

@property (weak, nonatomic) IBOutlet UIImageView *markLeftIV;
@property (weak, nonatomic) IBOutlet UIImageView *markRightIV;
@end

NS_ASSUME_NONNULL_END
