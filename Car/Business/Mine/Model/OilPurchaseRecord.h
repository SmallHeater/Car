//
//  OilPurchaseRecord.h
//  Car
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油采购记录模型

#import <Foundation/Foundation.h>
#import "GoodsItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface OilPurchaseRecord : NSObject

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * order_no;
@property (nonatomic , copy) NSString              * total_price;
@property (nonatomic , copy) NSString              * pay_price;
@property (nonatomic , copy) NSString              * pay_type;
@property (nonatomic , copy) NSString              * pay_status;
@property (nonatomic , assign) NSInteger              pay_time;
@property (nonatomic , copy) NSString              * express_price;
@property (nonatomic , copy) NSString              * express_company;
@property (nonatomic , copy) NSString              * express_no;
@property (nonatomic , copy) NSString              * freight_status;
@property (nonatomic , assign) NSInteger              freight_time;
@property (nonatomic , copy) NSString              * receipt_status;
@property (nonatomic , assign) NSInteger              receipt_time;
@property (nonatomic , copy) NSString              * order_status;
@property (nonatomic , copy) NSString              * transaction_id;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , assign) NSInteger              updatetime;
@property (nonatomic , strong) NSArray <GoodsItem *>              * goods;
@property (nonatomic , copy) NSString              * pay_status_text;
@property (nonatomic , copy) NSString              * pay_time_text;
@property (nonatomic , copy) NSString              * freight_status_text;
@property (nonatomic , copy) NSString              * freight_time_text;
@property (nonatomic , copy) NSString              * receipt_status_text;
@property (nonatomic , copy) NSString              * receipt_time_text;
@property (nonatomic , copy) NSString              * order_status_text;

@end

NS_ASSUME_NONNULL_END
