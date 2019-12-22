//
//  CarCategoryModel.h
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarCategoryModel : NSObject
@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* initial;
@property(nonatomic,strong)NSString* parentid;
@property(nonatomic,strong)NSString* logo;
@property(nonatomic,strong)NSString* depth;
//"id": 1,
//"name": "奥迪",
//"initial": "A",
//"parentid": 0,
//"logo": "http://pic1.jisuapi.cn/car/static/images/logo/300/1.png",
//"depth": 1
@end

NS_ASSUME_NONNULL_END
