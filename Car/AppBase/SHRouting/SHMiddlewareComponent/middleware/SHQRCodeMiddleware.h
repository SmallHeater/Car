//
//  SHQRCodeMiddleware.h
//  Car
//
//  Created by mac on 2019/9/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  扫一扫中间件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHQRCodeMiddleware : NSObject

+(void)scanCallBack:(void(^)(NSDictionary *retultDic))callBack;

@end

NS_ASSUME_NONNULL_END
