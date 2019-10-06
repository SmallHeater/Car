//
//  ResidualTransactionMerchantCell.h
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  残值交易详情商家信息cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResidualTransactionMerchantCell : SHBaseTableViewCell

//shop_avatar,图片;shop_name,名;shop_phone,号码;shop_credit,信用;
-(void)showDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
