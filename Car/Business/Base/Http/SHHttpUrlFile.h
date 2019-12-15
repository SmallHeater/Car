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
#define CARDOMAIN @"https://cdds.app.zyxczs.com"
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
//营收列表
#define Revenuelist  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/revenuelist",CARDOMAIN]

//发送保养推荐接口
#define SendRecommendSms  [[NSString alloc] initWithFormat:@"%@/api/sms/sendRecommendSms",CARDOMAIN]
 

//利润统计
#define Profitstatistics  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/profitstatistics",CARDOMAIN]
//利润排名接口
#define Profitranking  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/profitranking",CARDOMAIN]
//发送回访短信接口
#define SendVisitSms  [[NSString alloc] initWithFormat:@"%@/api/sms/sendVisitSms",CARDOMAIN]
//业务回访接口
#define BusinessVisit  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/businessVisit",CARDOMAIN]
//保养推荐接口
#define MaintainRecommend  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/maintainRecommend",CARDOMAIN]


//首页接口
#define Home  [[NSString alloc] initWithFormat:@"%@/api/Home/index",CARDOMAIN]
//获取用户信息
#define GetUserInfo  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/getUserInfo",CARDOMAIN]
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
//评论点赞
#define CommentThumb  [[NSString alloc] initWithFormat:@"%@/api/Home/commentThumb",CARDOMAIN]
//发表评论接口
#define PostComment  [[NSString alloc] initWithFormat:@"%@/api/Home/postComment",CARDOMAIN]




//论坛页获取顶部选项卡列表接口
#define TabList  [[NSString alloc] initWithFormat:@"%@/api/Home/getTabList",CARDOMAIN]
//论坛页获取板块列表接口
#define SectionList  [[NSString alloc] initWithFormat:@"%@/api/Home/getSectionList",CARDOMAIN]
//论坛页获取帖子列表接口
#define ForumList  [[NSString alloc] initWithFormat:@"%@/api/Home/getForumList",CARDOMAIN]
//获取评论接口，当前评论为盖楼式评论，评论的回复会作为新的评论显示（同时显示出其回复的对象和评论）
#define Comments  [[NSString alloc] initWithFormat:@"%@/api/Home/getComments",CARDOMAIN]
//获取小视频列表接口
#define GetVideos  [[NSString alloc] initWithFormat:@"%@/api/Home/getVideos",CARDOMAIN]
//发布小视频列表接口
#define PostVideo  [[NSString alloc] initWithFormat:@"%@/api/Home/postVideo",CARDOMAIN]
//举报接口
#define Inform  [[NSString alloc] initWithFormat:@"%@/api/Home/inform",CARDOMAIN]
//文章详情接口
#define GetArticleDetail  [[NSString alloc] initWithFormat:@"%@/api/Home/getArticleDetail",CARDOMAIN]
//文章/论坛收藏接口
#define ArticleMarkered  [[NSString alloc] initWithFormat:@"%@/api/Home/articleMarkered",CARDOMAIN]
//视频点赞接口
#define VideoThumb  [[NSString alloc] initWithFormat:@"%@/api/Home/videoThumb",CARDOMAIN]

//招聘参数
#define JobOption  [[NSString alloc] initWithFormat:@"%@/api/Home/getJobOption",CARDOMAIN]
//招聘列表
#define JobList  [[NSString alloc] initWithFormat:@"%@/api/Home/jobList",CARDOMAIN]
//发布招聘
#define PostJob  [[NSString alloc] initWithFormat:@"%@/api/Home/postJob",CARDOMAIN]
//招聘相关-收藏接口
#define EmploymentMarkered  [[NSString alloc] initWithFormat:@"%@/api/Home/employmentMarkered",CARDOMAIN]

//残值相关-发布残值物品接口
#define PostHandedGood  [[NSString alloc] initWithFormat:@"%@/api/Home/postHandedGood",CARDOMAIN]
//残值相关-残值列表接口
#define HandedGoodList  [[NSString alloc] initWithFormat:@"%@/api/Home/handedGoodList",CARDOMAIN]
//残值相关-收藏接口
#define HandedGoodMarkered  [[NSString alloc] initWithFormat:@"%@/api/Home/handedGoodMarkered",CARDOMAIN]


//机油采购--点击首页机油采购调用，返回最近的代理商店铺
#define GetAgentShop  [[NSString alloc] initWithFormat:@"%@/api/Shop/getAgentShop",CARDOMAIN]
//机油采购--获取分类商品列表接口
#define GetTypeGoodsList  [[NSString alloc] initWithFormat:@"%@/api/Shop/getTypeGoodsList",CARDOMAIN]
//机油采购 商铺获取评论接口
#define GetShopComments  [[NSString alloc] initWithFormat:@"%@/api/Shop/getShopComments",CARDOMAIN]
//机油采购记录（订单）接口
#define GetOrders  [[NSString alloc] initWithFormat:@"%@/api/Shop/getOrders",CARDOMAIN]
//机油采购-订单创建接口
#define OrderCreate  [[NSString alloc] initWithFormat:@"%@/api/Shop/orderCreate",CARDOMAIN]

//个人中心
//个人中心--获取我的帖子接口
#define GetMyForums  [[NSString alloc] initWithFormat:@"%@/api/Home/getMyForums",CARDOMAIN]
//获取我的回帖和回复我的
#define GetMyComments  [[NSString alloc] initWithFormat:@"%@/api/Home/getMyComments",CARDOMAIN]
//用户文章列表接口
#define GetUserArticles  [[NSString alloc] initWithFormat:@"%@/api/Home/getUserArticles",CARDOMAIN]
//修改用户信息
#define UpdateUserInfo  [[NSString alloc] initWithFormat:@"%@/api/ShopStaff/updateUserInfo",CARDOMAIN]

#endif /* HttpUrlFile_h */
