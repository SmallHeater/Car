//
//  FromUserModel.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情版主模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FromUserModel : NSObject

@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , assign) CGFloat              lat;
@property (nonatomic , assign) CGFloat              lng;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , assign) NSInteger              red_packet_num;
@property (nonatomic , assign) NSInteger              sms_num;
@property (nonatomic , copy) NSString              * nick_name;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , assign) NSInteger              credit;
@property (nonatomic , copy) NSString              * tab_ids;
@property (nonatomic , copy) NSString              * litestore_category_ids;
@property (nonatomic , assign) NSInteger              createtime;

@end

NS_ASSUME_NONNULL_END
