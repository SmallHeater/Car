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
//注册地址
#define Register [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/register",CARDOMAIN]
//工作台地址
#define Bench [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/bench",CARDOMAIN]
//快速接车
#define Receptioncar [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/receptioncar",CARDOMAIN]
//车牌查询
#define Checkcar [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/checkcar",CARDOMAIN]
//车辆档案
#define Carlist [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/carlist",CARDOMAIN]
//添加车辆维修记录
#define Maintainadd [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/maintainadd",CARDOMAIN]
//车辆维修记录
#define Maintainlist [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/maintainlist",CARDOMAIN]
//上传文件
#define Upload [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/upload",CARDOMAIN]
//回款管理
#define Payment [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/debtlist",CARDOMAIN]
//车辆档案修改
#define Caredit [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/caredit",CARDOMAIN]
//删除车牌
#define Deletecar [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/deletecar",CARDOMAIN]


#endif /* HttpUrlFile_h */
