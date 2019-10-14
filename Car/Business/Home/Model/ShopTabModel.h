//
//  ShopTabModel.h
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  机油门店页签模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopTabModel : NSObject

@property (nonatomic,assign) NSUInteger tabId;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,assign) NSUInteger sort;
@property (nonatomic,assign) NSUInteger position_id;
@property (nonatomic,strong) NSString * createtime;

@end

NS_ASSUME_NONNULL_END
