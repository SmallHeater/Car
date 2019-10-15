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
//删除维修记录
#define Maintaindelete [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/maintaindelete",CARDOMAIN]
//立即回款
#define Nowrepay [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/nowrepay",CARDOMAIN]
//营业汇总
#define Businesssummarytop  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/businesssummarytop",CARDOMAIN]

//利润统计
#define Profitstatistics  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/profitstatistics",CARDOMAIN]
//利润排名接口
#define Profitranking  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/profitranking",CARDOMAIN]

//首页接口
#define Home  [[NSString alloc] initWithFormat:@"%@/api/Home/index",CARDOMAIN]

//文章列表接口
#define GetArticles  [[NSString alloc] initWithFormat:@"%@/api/Home/getArticles",CARDOMAIN]
//浏览量添加接口
#define ArticlePV  [[NSString alloc] initWithFormat:@"%@/api/Home/articlePV",CARDOMAIN]
//获取板块列表接口
#define PostSectionList  [[NSString alloc] initWithFormat:@"%@/api/Home/getPostSectionList",CARDOMAIN]
//发帖接口
#define PostArticle  [[NSString alloc] initWithFormat:@"%@/api/Home/postArticle",CARDOMAIN]


//文章点赞接口
#define ArticleThumb  [[NSString alloc] initWithFormat:@"%@/api/Home/articleThumb",CARDOMAIN]
//评论点赞接口
#define CommentThumb  [[NSString alloc] initWithFormat:@"%@/api/Home/commentThumb",CARDOMAIN]




//论坛页获取顶部选项卡列表接口
#define TabList  [[NSString alloc] initWithFormat:@"%@/api/Home/getTabList",CARDOMAIN]
//论坛页获取板块列表接口
#define SectionList  [[NSString alloc] initWithFormat:@"%@/api/Home/getSectionList",CARDOMAIN]
//论坛页获取帖子列表接口
#define ForumList  [[NSString alloc] initWithFormat:@"%@/api/Home/getForumList",CARDOMAIN]
//获取评论
#define Comments  [[NSString alloc] initWithFormat:@"%@/api/Home/getComments",CARDOMAIN]



//招聘参数
#define JobOption  [[NSString alloc] initWithFormat:@"%@/api/Home/getJobOption",CARDOMAIN]
//招聘列表
#define JobList  [[NSString alloc] initWithFormat:@"%@/api/Home/jobList",CARDOMAIN]
//发布招聘
#define PostJob  [[NSString alloc] initWithFormat:@"%@/api/Home/postJob",CARDOMAIN]

//残值相关-发布残值物品接口
#define PostHandedGood  [[NSString alloc] initWithFormat:@"%@/api/Home/postHandedGood",CARDOMAIN]
//残值相关-残值列表接口
#define HandedGoodList  [[NSString alloc] initWithFormat:@"%@/api/Home/handedGoodList",CARDOMAIN]


//机油采购--点击首页机油采购调用，返回最近的代理商店铺
#define GetAgentShop  [[NSString alloc] initWithFormat:@"%@/api/Shop/getAgentShop",CARDOMAIN]
//机油采购--获取分类商品列表接口
#define GetTypeGoodsList  [[NSString alloc] initWithFormat:@"%@/api/Shop/getTypeGoodsList",CARDOMAIN]


#endif /* HttpUrlFile_h */
