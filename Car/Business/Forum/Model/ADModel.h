//
//  ADModel.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情广告模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADModel : NSObject

@property (nonatomic , assign) NSInteger              ADID;
@property (nonatomic , assign) NSInteger              position_id;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              showswitch;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , copy) NSString              * type_text;

//图片宽高
@property (nonatomic,assign) float imageWidth;
@property (nonatomic,assign) float imageHeight;

@end

NS_ASSUME_NONNULL_END
