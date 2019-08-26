//
//  CommandDemoList.h
//  JHRouting
//
//  Created by xianjun wang on 2019/1/8.
//  Copyright © 2019 xianjunwang. All rights reserved.
//  命令使用Demo文件

#ifndef CommandDemoList_h
#define CommandDemoList_h

#pragma mark  ----  大图浏览组件命令集合

/*
 //大图浏览
 dataArray,要大图浏览的图片数组，可以是image也可以是图片链接，字符串或者NSURL都可以，可图片，地址等混合，数组类型；selectedIndex，首先展示的图片索引，NSNumber类型。
[JHRoutingComponent openURL:BIGPICTUREBROWSING withParameter:@{@"dataArray":@[],@"selectedIndex":[NSNumber numberWithInteger:0]}];
*/

#pragma mark  ----  大图浏览组件命令集合

#pragma mark  ----  加密组件命令集合

/*
 //水印加密图片命令
 image是要加密的图片对象，text是要显示的水印文字
 UIImage * encryptionImage = [JHEncryptionComponent watermarkEncryptionImage:image andText:text];
 
 */

#pragma mark  ----  加密组件命令集合

#pragma mark  ----  数据采集组件命令集合

/*
 //初始化数据采集组件命令,type是要使用的数据采集类型，ALL是使用所有类型；BUGLY:是腾讯bugly;UM:是友盟;
 [JHRoutingComponent openURL:INITDATASTATISTICSCOMPONENT withParameter:@{@"type":@"ALL"}];
 */

/*
 //上报异常命令,reason为上报异常的描述，字符串类型
 [JHRoutingComponent openURL:REPORTEXCEPTION withParameter:@{@"reason":[[NSString alloc] initWithFormat:@"当前命令异常，分割的字典中businessName或commandStr对应的值为空，命令为：%@",url]}];
 */

/*
 //记录事件命令,使用本功能时首先要在友盟添加自定义事件，eventId为自定义事件ID，className为当前类或当前页面，name为当前页面名或类名，operating为具体操作，userAccount为当前用户账号
 [JHRoutingComponent openURL:RECORDINGEVENT withParameter:@{@"eventId":@"Dishes",@"className":@"JHDishesManagementVC",@"name":self.className,@"operating":[[NSString alloc] initWithFormat:@"%@初始化",self.className],@"userAccount":[[LoginAndRegister sharedLoginAndRegister] getUserAccount]}];
 */

/*
 //记录展示页面命令,pageName为展示页面类名
 [JHRoutingComponent openURL:SHOWPAGEVIEW withParameter:@{@"pageName":className}];
 */

/*
 //记录退出页面命令,pageName为退出页面类名
 [JHRoutingComponent openURL:GOAWAYPAGEVIEW withParameter:@{@"pageName":className}];
 */

/*
 //开启内存泄漏弹窗提示
 [JHRoutingComponent openURL:SHOWMEMORYLEAKALERT];
 */


#pragma mark  ----  数据采集组件命令集合

#pragma mark  ----  相册浏览组件命令集合

/*
 //去相册命令, tkCamareType,相机类型，0:系统相机;1:自动抓拍;2:带身份证大小的边框;3:横屏带框.canSelectImageCount:可以选择的照片个数。sourceType,资源类型。0:图片，1:视频,2:媒体。UIViewController:父视图指针。
 回调字典：@{@"data":@[@"thumbnails":@"缩略图",@"selected":@"是否选中",@"identifier":@"唯一标识符",@"asset":@"PHAsset *",@"originalImage":@"原图",@"previewImage":@"预览图"]}
 [JHRoutingComponent openURL:GETIMAGE withParameter:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:8],@"sourceType":[NSNumber numberWithInteger:0],@"UIViewController":self} callBack:^(NSDictionary *resultDic) {
 }];
 
 */

#pragma mark  ----  相册浏览组件命令集合

#pragma mark  ----  账户体系组件命令集合

/*
 //得到用户ID命令,返回@{@"userId":@"123456"}
 [JHRoutingComponent openURL:GETUSERIDCALLBACK callBack:^(NSDictionary *resultDic) {
 }];
 */

#pragma mark  ----  账户体系组件命令集合

#pragma mark  ----  新上传组件命令集合

/*
 //传参： @{@"datasArray":@[@{@"uploadData":uploadImage,@"uploadDataName":imageName,@"uploadDataPath":@"",@"uploadDataType":@"image,@"uploadDataId":uploadDataId"}],@"serverUrlStr":@"http://testfileserver.iuoooo.com/Jinher.JAP.BaseApp.FileServer.SV.FileSV.svc/UploadMobileFile",@"isSingleReturn":[NSNumber numberWithBool:YES],@"isCompression":[NSNumber numberWithBool:YES],@"isSingleThread":[NSNumber numberWithBool:NO],@"isShowLoading":[NSNumber numberWithBool:YES],@"isAddUploadList":[NSNumber numberWithBool:YES],@"isCallBackSchedule":[NSNumber numberWithBool:NO]}
 datasArray存储要上传的图片，视频数据的数组，uploadData，可以是UIImage,可以是NSData,可以为空.uploadDataName,要上传的图片，视频,音频，文件名字。uploadDataPath，要上传的资源的路径，可不传；uploadDataType，上传的数据类型，Image,图片，Video,视频,Audio,音频，File，文件。uploadDataId,上传数据的唯一标识，如果有暂停，继续上传等功能，必传；isCompression，是否压缩；isSingleReturn是否单张图片上传完都回调；isSingleThread，是否单线程上传;isShowLoading,是否显示默认上传效果;isAddUploadList,是否添加到上传列表;isCallBackSchedule,是否回传进度，默认NO。
 //回调：resultDic，@{@"FilePath":路径,@"":时间}
[JHRoutingComponent openURL:UPLOADDATA withParameter:@{@"datasArray":datasArray,@"isSingleReturn":[NSNumber numberWithBool:NO]} callBack:^(NSDictionary *resultDic) {
    
    if ([resultDic.allKeys containsObject:@"schedule"]) {
        
        NSLog(@"进度：%@",resultDic[@"schedule"]);
    }
    else if ([resultDic.allKeys containsObject:@"error"]) {
        
        NSLog(@"失败：%@",resultDic[@"error"]);
    }
    else{
        
        //成功
    }
}];
*/

#pragma mark  ----  新上传组件命令集合

#pragma mark  ----  直播命令集合

//开始直播命令


#pragma mark  ----  直播命令集合


#pragma mark  ----  播放命令集合

//开始播放命令
/*
 //liveType,直播类型，1阿里，2腾讯；pushUrlStr,推流地址；preview，预览view,不传用默认的.controlView,控制view。
 传参：@{@"pushUrlStr":@"rtmp://video10.iuoooo.com/openlive/201902280930_1",@"preview":self.recordingView,@"controlView":self.recordingView,@"liveType":[NSNumber numberWithInteger:1]
 */

#pragma mark  ----  播放命令集合

#pragma mark  ----  网络请求组件命令集合

//获取网络状态命令
/*

 回调的：networkType,对应返回值，@"未知",@"无网络",@"2G",@"3G",@"4G"
 [JHRoutingComponent openURL:GETNETWORKTYPE callBack:^(NSDictionary *resultDic) {
 
     if ([resultDic.allKeys containsObject:@"networkType"]) {
 
         NSString * networkType = resultDic[@"networkType"];
     }
 }];
 
 */

//发起网络请求的命令
/*
 传参:
 NSDictionary * parameter =@{@"requestUrlStr":@"请求地址,必填",@"requestType":@"请求类型，传NSNumber,0,POST,1,GET,可不传，默认POST",@"headerParameters":@"添加到请求头中的参数,可不传",@"bodyParameters":@“添加到请求体中的参数，可不传”,@"businessType":@"请求业务，Number类型，0是普通请求，1是下载请求，2是上传请求，可不传，默认是普通请求",@“priority”:@“优先级，Number类型，0是默认优先级，1是高优先级，2是低优先级，可不传，默认是默认优先级",@“isShowLoading”:@“是否展示Loading,NSNumber类型，YES是展示，NO是不展示，默认是YES”,@"isCallBackInMainQueue":@"是否在主工程回调，NSNumber类型，默认是YES",@"timeoutInterval":@"超时时间，NSNumber类型，默认是5秒",@"taskIdentifier":@"唯一标识，NSNumber类型，可不填，无默认值，若要使用暂停，重新开始等功能，则必填",@"uploadData":[NSData data],上传的Data数据;@"uploadDataFile":@"上传资源路径",上传时uploadData，uploadDataFile必须有一个有数据;}
 回调：
 普通请求回调：
 正常回调，NSDictionary * resultDic = @{@"internet":@"网络状态，未知,无网络,2G,3G,4G",@"data":@"NSData,数据",@"response":@"NSURLResponse"};
 异常常回调，NSDictionary * resultDic = @{@"internet":@"网络状态，未知,无网络,2G,3G,4G",@"data":@"NSData,数据",@"response":@"NSURLResponse",@"error":error};
 下载请求回调：
 下载进度回调：NSDictionary * resultDic = @{@"schedule":[NSNumber numberWithFloat:schedule]};
 下载完成回调：NSDictionary * resultDic = @{@"internet":internetState,@"isDownloadFinish":[NSNumber numberWithBool:YES],@"location":@"下载的数据存储路径"}
 [JHRoutingComponent openURL:REQUESTDATA withParameter:parameter callBack:^(NSDictionary *resultDic) {
 
 }];
 
*/

#pragma mark  ----  网络请求组件命令集合






#endif /* CommandDemoList_h */
