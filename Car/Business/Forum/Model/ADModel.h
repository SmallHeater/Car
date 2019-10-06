//
//  ADModel.h
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADModel : NSObject

@property (nonatomic,assign) NSUInteger ADID;
@property (nonatomic,assign) NSUInteger position_id;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,assign) BOOL showswitch;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) NSString * createtime;
@property (nonatomic,strong) NSString * type_text;

@end

NS_ASSUME_NONNULL_END
