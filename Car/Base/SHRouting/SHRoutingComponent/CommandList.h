//
//  CommandList.h
//  JHRoutingComponent
//
//  Created by xianjunwang on 2018/11/8.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  命令宏

#ifndef CommandList_h
#define CommandList_h

#pragma mark  ----  大图浏览组件命令集合
//大图浏览命令
#define BIGPICTUREBROWSING @"BusinessFoundation://BigPictureBrowsing:(bigPictureBrowsing:)"
#pragma mark  ----  大图浏览组件命令集合

#pragma mark  ----  加密组件命令集合
#pragma mark  ----  加密组件命令集合

#pragma mark  ----  数据采集组件命令集合
//初始化数据采集组件命令
#define INITDATASTATISTICSCOMPONENT @"BusinessFoundation://DataStatisticsComponent:(initDataStatisticsComponent:)"
//上报异常命令
#define REPORTEXCEPTION @"BusinessFoundation://DataStatisticsComponent:(reportException:)"
//记录事件命令
#define RECORDINGEVENT @"BusinessFoundation://DataStatisticsComponent:(recordingEvent:)"
//记录展示页面命令
#define SHOWPAGEVIEW @"BusinessFoundation://DataStatisticsComponent:(showPageView:)"
//记录退出页面命令
#define GOAWAYPAGEVIEW @"BusinessFoundation://DataStatisticsComponent:(goAwayPageView:)"
//开启内存泄漏提示的命令
#define SHOWMEMORYLEAKALERT @"BusinessFoundation://DataStatisticsComponent:(showMemoryLeakAlert)"

#pragma mark  ----  数据采集组件命令集合

#pragma mark  ----  相册浏览组件命令集合

//去相册命令
#define GETIMAGE @"BusinessFoundation://PictureSelection:(getImage:callBack:)"

#pragma mark  ----  相册浏览组件命令集合

#pragma mark  ----  账户体系组件命令集合
#pragma mark  ----  账户体系组件命令集合

#pragma mark  ----  上传组件命令集合
//上传命令
#define UPLOADDATA @"Technology://UploadComponent:(uploadDatas:callBack:)"
//暂停上传命令
#define SUSPENDUPLOADDATA @"Technology://UploadComponent:(suspendUploadDatas:callBack:)"
//继续上传命令
#define CONTINUEUPLOADDATA @"Technology://UploadComponent:(continueUploadDatas:callBack:)"
//停止上传命令
#define STOPUPLOADDATA @"Technology://UploadComponent:(stopUploadDatas:callBack:)"
//得到上传列表命令
#define GETUPLOADLIST @"Technology://UploadComponent:(getUploadTableViewControllerCallBack:)"
//上传未上传完的数据命令
#define UPLOADNOTFINISHDATA @"Technology://UploadComponent:(uploadNotFinishDatasCallBack:)"

#pragma mark  ----  上传组件命令集合



#pragma mark  ----  直播命令集合

#pragma mark  ----  直播命令集合


#pragma mark  ----  播放命令集合

#pragma mark  ----  播放命令集合

#pragma mark  ----  网络请求组件命令集合

//获取网络状态命令
#define GETNETWORKTYPE @"Technology://Network:(getConnectTypeCallBack:)"
//发起网络请求的命令
#define REQUESTDATA @"Technology://Network:(requestDataWithDic:callBack:)"

#pragma mark  ----  网络请求组件命令集合

#endif /* CommandList_h */
