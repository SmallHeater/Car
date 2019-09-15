//
//  PublicRequest.h
//  Car
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  公共的网络请求控制器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VehicleFileModel;

@interface PublicRequest : NSObject

+(PublicRequest *)sharedManager;

//请求接口，判断车牌档案是否已存在
-(void)requestIsExistedLicenseNumber:(NSString *)license_number callBack:(void(^)(BOOL isExisted,VehicleFileModel * model,NSString * msg))callBack;


@end

NS_ASSUME_NONNULL_END
