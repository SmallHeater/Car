//
//  UserInforModel.h
//  Car
//
//  Created by xianjun wang on 2019/8/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  用户信息模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInforModel : NSObject

@property (nonatomic,strong) NSString * id;
//店铺名称
@property (nonatomic,strong) NSString * shop_name;
//手机号
@property (nonatomic,strong) NSString * phone;
//经度(保留六位小数
@property (nonatomic,strong) NSNumber * lng;
//纬度(保留六位小数
@property (nonatomic,strong) NSNumber * lat;
//省(带后缀省
@property (nonatomic,strong) NSString * province;
//市(带后缀市
@property (nonatomic,strong) NSString * city;
//区/县(带后缀区/县
@property (nonatomic,strong) NSString * district;
//红包数量
@property (nonatomic,strong) NSNumber * red_packet_num;
//短信数量
@property (nonatomic,strong) NSNumber * sms_num;
// 昵称
@property (nonatomic,strong) NSString * nick_name;
@property (nonatomic,strong) NSString * ip;
@property (nonatomic,strong) NSString * createtime;


@end

NS_ASSUME_NONNULL_END
