//
//  FromUserModel.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FromUserModel : NSObject

@property (nonatomic,assign) NSUInteger userId;
@property (nonatomic,assign) NSUInteger lat;
@property (nonatomic,assign) NSUInteger lng;
@property (nonatomic,strong) NSString * shop_name;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSString * province;
@property (nonatomic,strong) NSString * city;
@property (nonatomic,strong) NSString * district;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * nick_name;
@property (nonatomic,strong) NSString * ip;
@property (nonatomic,assign) NSUInteger red_packet_num;
@property (nonatomic,assign) NSUInteger sms_num;

@end

NS_ASSUME_NONNULL_END
