//
//  OilPurchaseRecordCell.h
//  Car
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油采购记录cell

#import "SHBaseTableViewCell.h"
#import "OilPurchaseRecord.h"


NS_ASSUME_NONNULL_BEGIN

@interface OilPurchaseRecordCell : SHBaseTableViewCell

+(float)cellHeightWithModel:(OilPurchaseRecord *)model;
-(void)show:(OilPurchaseRecord *)model;

@end

NS_ASSUME_NONNULL_END
