//
//  ShopBtomCell.h
//  Car
//
//  Created by Mrzhang on 2019/12/18.
//  Copyright © 2019年 SmallHeat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopBtomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UILabel *equalLab;
@property (weak, nonatomic) IBOutlet UILabel *seviceLab;
@property (weak, nonatomic) IBOutlet UILabel *sendLab;
@property (weak, nonatomic) IBOutlet UIImageView *equalIV;
@property (weak, nonatomic) IBOutlet UIImageView *serviceIV;
@property (weak, nonatomic) IBOutlet UIImageView *sendIV;

@end

NS_ASSUME_NONNULL_END
