//
//  InterfaceStatusModel.h
//  GYInterfaceManager
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceStatusModel : NSObject
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, assign) NSInteger status;
@end
