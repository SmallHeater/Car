//
//  SHQRCodeMiddleware.m
//  Car
//
//  Created by mac on 2019/9/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHQRCodeMiddleware.h"
#import "SHQRCodeLibrary.h"


@implementation SHQRCodeMiddleware

+(void)scanCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    [SHQRCodeLibrary scanBlock:^(NSString * result) {
        
        callBack(@{@"result":result});
    }];
}

@end
