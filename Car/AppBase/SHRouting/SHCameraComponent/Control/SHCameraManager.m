//
//  SHCameraManager.m
//  Car
//
//  Created by xianjun wang on 2019/9/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCameraManager.h"
#import <Photos/Photos.h>
#import "JHSmartCamareViewController.h"
#import "JHCameraForLicenceViewController.h"

static SHCameraManager * manager = nil;

@interface SHCameraManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SHCameraManager

#pragma mark  ----  生命周期函数

+(SHCameraManager *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
    });
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHCameraManager"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    
    return manager;
}

//重写创建对象空间的方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    //防止子类重载调用使用
    NSString * classStr = NSStringFromClass([self class]);
    if (![classStr isEqualToString:@"SHCameraManager"]) {
        
        NSParameterAssert(nil);//填nil会导致程序崩溃
    }
    return [self sharedManager];
}

//重写copy
-(id)copy{
    
    return [self.class sharedManager];
}

//重写mutableCopy
-(id)mutableCopy{
    
    return [self.class sharedManager];
}

#pragma mark  ----  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self finishedTakeImage:image];
}

#pragma mark  ----  自定义函数

//判断有无照相机使用权限
-(SHCameraState)getCameraAuthority{
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusAuthorized){
        
        return SHCameraState_Authorized;
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined){
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            
        }];
        return SHCameraState_NotDetermined;
    }
    else if (authStatus == AVAuthorizationStatusRestricted){
        
        return SHCameraState_Restricted;
    }
    else{
        
        return SHCameraState_Denied;
    }
}

//去拍照
-(void)takePhoto{
    
    __weak typeof(self) weakSelf = self;
    if (self.cameraType == SHCamareType_System) {
        
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate = weakSelf;
        picker.sourceType=sourceType;
        picker.allowsEditing= YES;
       
        [[UIViewController topMostController]  presentViewController:picker animated:YES completion:nil];
    }
    else if (self.cameraType == SHCamareType_SmartLicense){
        
        JHSmartCamareViewController * secVC = [[JHSmartCamareViewController alloc] initWithType:CameraGetPictureType_Licence];
        GetClearImage callback = ^(UIImage *image){
            
            [weakSelf finishedTakeImage:image];
        };
        ShowSystemCamareViewCtroller showSysCamareCallBack = ^(){
            //去拍照
            UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            }
            UIImagePickerController *picker=[[UIImagePickerController alloc]init];
            picker.delegate=weakSelf;
            picker.sourceType=sourceType;
            picker.allowsEditing= NO;
            [[UIViewController topMostController]  presentViewController:picker animated:YES completion:nil];
        };
        secVC.showSysCamare = [showSysCamareCallBack copy];
        secVC.getImageCallBack = [callback copy];
        [[UIViewController topMostController]  presentViewController:secVC animated:NO completion:nil];
    }
    else if (self.cameraType == SHCamareType_SmartIDCard){
        
        JHSmartCamareViewController * secVC = [[JHSmartCamareViewController alloc] initWithType:CameraGetPictureType_IDCard];
        GetClearImage callback = ^(UIImage *image){
            
            [weakSelf finishedTakeImage:image];
        };
        ShowSystemCamareViewCtroller showSysCamareCallBack = ^(){
            //去拍照
            UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            }
            UIImagePickerController *picker=[[UIImagePickerController alloc]init];
            picker.delegate=weakSelf;
            picker.sourceType=sourceType;
            picker.allowsEditing= NO;
            [[UIViewController topMostController]  presentViewController:picker animated:YES completion:nil];
        };
        secVC.showSysCamare = [showSysCamareCallBack copy];
        secVC.getImageCallBack = [callback copy];
        [[UIViewController topMostController]  presentViewController:secVC animated:NO completion:nil];
    }
    else if (self.cameraType == SHCamareType_HorizontalScreen){
        
        JHCameraForLicenceViewController * secVC = [[JHCameraForLicenceViewController alloc] init];
        secVC.imageCallBack = ^(UIImage * _Nonnull cutImage) {
            
            [weakSelf finishedTakeImage:cutImage];
        };
        [[UIViewController topMostController]  presentViewController:secVC animated:NO completion:nil];
    }
}


- (void)finishedTakeImage:(UIImage *)image{
    
    if (image && self.callBack) {
        
        self.callBack(@{@"image":image});
    }
}

@end
