//
//  PostResidualTransactionRequestModel.h
//  Car
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布残值交易请求模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostResidualTransactionRequestModel : NSObject

@property (nonatomic,strong) NSString * user_id;
//标题
@property (nonatomic,strong) NSString * name;
//    金额（传字符串：1、数字，2、面议）
@property (nonatomic,strong) NSString * money;
//工作描述
@property (nonatomic,strong) NSString * RTdescription;
//图片：逗号隔开
@property (nonatomic,strong) NSString * images;
//电话
@property (nonatomic,strong) NSString * phone;


@end

NS_ASSUME_NONNULL_END
