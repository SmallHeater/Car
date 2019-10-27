//
//  PayManager.h
//  GoodView
//
//  Created by xianjun wang on 2019/1/2.
//  Copyright © 2019 mac. All rights reserved.
//  支付控制器

#import <Foundation/Foundation.h>
#import "PayModel.h"

NS_ASSUME_NONNULL_BEGIN


//state:0,失败，1成功。
typedef void(^PayBlock)(NSDictionary * infoDic);

//支付方式
typedef NS_ENUM(NSUInteger,PayType){
    
    PayType_AlipayPay = 0,//支付宝支付
    PayType_WeChatPay = 1//微信支付
};


@interface PayManager : NSObject

@property (nonatomic,copy) PayBlock payBlock;

+(PayManager *)sharedManager;

//创建支付订单
-(void)createPaymentOrderWithPayType:(PayType)payType andPayModel:(PayModel *)payModel;
//支付宝支付
-(void)alipayPayWithPayModel:(PayModel *)payModel;


@end

NS_ASSUME_NONNULL_END
