//
//  ExampleModel.h
//  Car
//
//  Created by xianjun wang on 2019/11/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  未回访数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExampleModel : NSObject

//车牌号
@property (nonatomic , copy) NSString              * license_number;
@property (nonatomic , copy) NSString              * type;
//联系人
@property (nonatomic , copy) NSString              * contacts;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , assign) NSInteger              maintain_Id;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              car_id;
@property (nonatomic , copy) NSString              * maintain_day;
@property (nonatomic , assign) NSInteger              mileage;
@property (nonatomic , copy) NSString              * related_service;
@property (nonatomic , copy) NSString              * receivable;
@property (nonatomic , copy) NSString              * received;
@property (nonatomic , copy) NSString              * cost;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , assign) NSInteger              business_visit;
@property (nonatomic , assign) NSInteger              createtime;

@end

NS_ASSUME_NONNULL_END
