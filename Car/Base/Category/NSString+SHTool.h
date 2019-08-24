//
//  NSString+SHTool.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 IP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SHTool)

/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty;

-(NSString *)repleaseNilOrNull;

//获取字符串宽度
-(float)widthWithFont:(UIFont *)font andHeight:(float)height;

@end

NS_ASSUME_NONNULL_END
