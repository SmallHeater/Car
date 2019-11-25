//
//  SHCameraComponent.m
//  Car
//
//  Created by mac on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCameraComponent.h"
#import "SHCameraManager.h"


@implementation SHCameraComponent

//去拍照
+(void)takePhotoWithDic:(NSDictionary *)dic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    //权限判断
    if ([[SHCameraManager sharedManager] getCameraAuthority] == SHCameraState_Authorized) {
        
        SHCameraManager * manager = [SHCameraManager sharedManager];
        NSNumber * type = dic[@"cameraType"];
        manager.cameraType = type.integerValue;
        manager.callBack = callBack;
        [[SHCameraManager sharedManager] takePhoto];
    }
    else if([[SHCameraManager sharedManager] getCameraAuthority] == SHCameraState_Restricted || [[SHCameraManager sharedManager] getCameraAuthority] == SHCameraState_Denied){
        
        NSDictionary * inforDic = [NSBundle mainBundle].infoDictionary;
        NSString * message = [[NSString alloc] initWithFormat:@"请进入iPhone的“设置-隐私-相机”选项，允许%@访问您的手机相册。",inforDic[@"CFBundleDisplayName"]];
        //无权限
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAction];
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
        [[UIViewController topMostController] presentViewController:alert animated:YES completion:nil];
        callBack(@{@"error":@"无权限"});
    }
}


@end
