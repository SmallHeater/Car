//
//  JHPictureSelectionMiddleware.h
//  JHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  照片选择组件中间件

#import <Foundation/Foundation.h>

@interface SHPictureSelectionMiddleware : NSObject

+(void)getImage:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack;

@end
