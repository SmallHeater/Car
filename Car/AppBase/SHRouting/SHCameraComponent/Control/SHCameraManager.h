//
//  SHCameraManager.h
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  相机控制器

#import <Foundation/Foundation.h>

//相机权限
typedef NS_ENUM(NSUInteger,SHCameraState){
    
    SHCameraState_NotDetermined = 0,  //用户尚未做出有关此应用程序的选择
    SHCameraState_Restricted,        //此应用程序未被授权访问照片数据,用户无法更改此应用程序的状态，可能是由于主动限制,正在实施家长控制等。
    SHCameraState_Denied,            //用户已明确拒绝此应用程序访问照片数据。
    SHCameraState_Authorized         //用户已授权此应用程序访问照片数据。
};

//相机类型
typedef NS_OPTIONS(NSUInteger, SHCamareType) {
    
    SHCamareType_System = 0,//系统相机
    SHCamareType_SmartLicense = 1,//自动抓拍
    SHCamareType_SmartIDCard = 2,//带身份证大小的边框
    SHCamareType_HorizontalScreen = 3,//横屏带框
    SHCamareType_CarMaster = 4 //车店大师UI
};



NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(NSDictionary * retultDic);

@interface SHCameraManager : NSObject

//相机类型
@property (nonatomic,assign) SHCamareType cameraType;
//回调
@property (nonatomic,copy) CallBack callBack;

+(SHCameraManager *)sharedManager;

//去拍照
-(void)takePhoto;

//判断有无照相机使用权限
-(SHCameraState)getCameraAuthority;
//清理内存(本模块生命周期结束时调用)
-(void)clearMemary;

@end

NS_ASSUME_NONNULL_END
