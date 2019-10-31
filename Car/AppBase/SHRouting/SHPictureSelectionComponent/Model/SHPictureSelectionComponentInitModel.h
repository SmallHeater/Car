//
//  SHPictureSelectionComponentInitModel.h
//  SHPictureSelectionComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  图片浏览组件配置模型

#import <UIKit/UIKit.h>

//相机类型
typedef NS_OPTIONS(NSUInteger, CamareType) {
    
    CamareTypeSystem = 0,
    CamareTypeSmartLicense = 1,
    CamareTypeSmartIDCard = 2,
    CamareTypeHorizontalScreen = 3//横屏带框
};

//相机权限
typedef NS_ENUM(NSUInteger,CameraState){
    
    CameraStatusNotDetermined = 0,  //用户尚未做出有关此应用程序的选择
    CameraStatusRestricted,        //此应用程序未被授权访问照片数据,用户无法更改此应用程序的状态，可能是由于主动限制,正在实施家长控制等。
    CameraStatusDenied,            //用户已明确拒绝此应用程序访问照片数据。
    CameraStatusAuthorized         //用户已授权此应用程序访问照片数据。
};

//相册权限
typedef NS_ENUM(NSUInteger,AlbumState){
    
    AlbumStatusNotDetermined = 0,  //用户尚未做出有关此应用程序的选择
    AlbumStatusRestricted,        //此应用程序未被授权访问照片数据,用户无法更改此应用程序的状态，可能是由于主动限制,正在实施家长控制等。
    AlbumStatusDenied,            //用户已明确拒绝此应用程序访问照片数据。
    AlbumStatusAuthorized         //用户已授权此应用程序访问照片数据。
};


//资源类型
typedef NS_ENUM(NSInteger, SourceType) {
    
    SourceImage   = 0,
    SourceVideo   = 1,
    SourceAudio   = 2,
};

@interface SHPictureSelectionComponentInitModel : NSObject

//相机类型
@property (nonatomic,assign) CamareType tkCamareType;
//剩余选择照片数
@property (nonatomic,assign) NSUInteger canSelectImageCount;
//资源类型
@property (nonatomic,assign) SourceType sourceType;


@end
