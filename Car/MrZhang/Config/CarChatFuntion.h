//
//  CarChatFuntion.h
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

typedef void(^InterfaceHandler)(NSDictionary *info,InterfaceStatusModel *infoModel);
@interface CarChatFuntion : NSObject
@property (nonatomic,strong) AFHTTPSessionManager *httpManager;
+(instancetype)shareInterface;
-(void)chatLogin;
-(void)requetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler;
-(void)requetPostInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler;
+(UIColor *)GradualChangeColor:(NSArray *)colors ViewSize:(CGSize)ViewSize gradientType:(GradientType)gradientType;
@end

NS_ASSUME_NONNULL_END
