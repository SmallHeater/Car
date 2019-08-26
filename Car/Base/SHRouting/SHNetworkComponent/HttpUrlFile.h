//
//  HttpUrlFile.h
//  Car
//
//  Created by xianjun wang on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  地址宏文件

#ifndef HttpUrlFile_h
#define HttpUrlFile_h

//域名
#define CARDOMAIN @"https://garage.jnmsywl.com"
//获取验证码地址
#define GetVerificationCode [[NSString alloc] initWithFormat:@"%@/api/sms/send",CARDOMAIN]


#endif /* HttpUrlFile_h */
