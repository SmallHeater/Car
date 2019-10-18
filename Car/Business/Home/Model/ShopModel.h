//
//  ShopModel.h
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油专卖门店模型

#import <Foundation/Foundation.h>
#import "ShopTabModel.h"
#import "ShopCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject

@property (nonatomic,assign) NSUInteger shopId;
@property (nonatomic,strong) NSString * shopIdStr;
//店铺描述
@property (nonatomic,strong) NSString * shopDescription;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSArray<NSString *> * images;
//"117.061004,36.694254"经纬度
@property (nonatomic,strong) NSString * coordinate;
@property (nonatomic,assign) NSUInteger scope;
@property (nonatomic,assign) NSUInteger province;
@property (nonatomic,assign) NSUInteger city;
@property (nonatomic,assign) NSUInteger district;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * balance;
//开始营业时间戳
@property (nonatomic,assign) NSUInteger opentime;
//停止营业时间戳
@property (nonatomic,assign) NSUInteger closetime;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * uts_price;
@property (nonatomic,assign) NSUInteger score;
@property (nonatomic,assign) NSUInteger createtime;
@property (nonatomic,strong) NSString * status;
@property (nonatomic,assign) NSUInteger salesnum;
@property (nonatomic,strong) NSString * operating_state;
@property (nonatomic,strong) NSString * notice;
@property (nonatomic,strong) NSString * delivery_type;
@property (nonatomic,strong) NSString * del;
@property (nonatomic,assign) NSUInteger tuijian_switch;
@property (nonatomic,strong) NSString * turnover;
@property (nonatomic,strong) NSString * litestore_category_ids;
@property (nonatomic,strong) NSString * tab_ids;
@property (nonatomic,assign) NSUInteger order_switch;
@property (nonatomic,strong) NSArray<ShopTabModel *> * tabs;
@property (nonatomic,strong) NSArray<ShopCategoryModel *> * categorys;
@property (nonatomic,strong) NSString * opentime_text;
@property (nonatomic,strong) NSString * closetime_text;
@property (nonatomic,strong) NSString * status_text;
@property (nonatomic,strong) NSString * operating_state_text;
@property (nonatomic,strong) NSString * delivery_type_text;
@property (nonatomic,strong) NSString * del_text;

//法律声明
@property (nonatomic,strong) NSString * declaration_law;
//产品声明
@property (nonatomic,strong) NSString * declaration_production;


@end

NS_ASSUME_NONNULL_END
