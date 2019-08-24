//
//  GetVerificationCodeBtn.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  获取验证码按钮，点击后有倒计时

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetVerificationCodeBtn : UIButton

//实例化方法;normalTitle:标题;time:计时时间;
-(instancetype)initWithConfigurationDic:(NSDictionary *)configurationDic;

@end

NS_ASSUME_NONNULL_END
