//
//  SHPictureSelectionMiddleware.m
//  SHMiddlewareComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHPictureSelectionMiddleware.h"
#import "SHPictureSelectionComponent.h"


@implementation SHPictureSelectionMiddleware

+(void)getImage:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    SHPictureSelectionComponentInitModel * model = [[SHPictureSelectionComponentInitModel alloc] init];
    if (initDic && [initDic.allKeys containsObject:@"tkCamareType"]) {
        
        NSNumber * value = initDic[@"tkCamareType"];
        model.tkCamareType = value.integerValue;
    }
    else{
        
        model.tkCamareType = 0;
    }
    
    if (initDic && [initDic.allKeys containsObject:@"canSelectImageCount"]) {
        
        NSNumber * value = initDic[@"canSelectImageCount"];
        model.canSelectImageCount = value.integerValue;
    }
    else{
        
        model.canSelectImageCount = 1;
    }
    
    if (initDic && [initDic.allKeys containsObject:@"sourceType"]) {
        
        NSNumber * value = initDic[@"sourceType"];
        model.sourceType = value.integerValue;
    }
    else{
        
        model.sourceType = 0;
    }
    
    [SHPictureSelectionComponent getImagesWithInitModel:model callBack:^(NSMutableArray *dataArray) {
        
        callBack(@{@"data":dataArray});
    }];
}

@end
