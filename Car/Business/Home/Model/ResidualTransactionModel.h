//
//  ResidualTransactionModel.h
//  Car
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  残值交易列表数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResidualTransactionModel : NSObject

@property (nonatomic,strong) NSString * RTId;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * money;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * RTDescription;
@property (nonatomic,strong) NSString * images;
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSDate * createtime;
@property (nonatomic,strong) NSString * shop_name;
@property (nonatomic,strong) NSString * shop_phone;
@property (nonatomic,strong) NSString * shop_avatar;
@property (nonatomic,strong) NSString * shop_credit;
@property (nonatomic,strong) NSString * address;
//是否收藏
@property (nonatomic,assign) BOOL markered;
@end

NS_ASSUME_NONNULL_END
