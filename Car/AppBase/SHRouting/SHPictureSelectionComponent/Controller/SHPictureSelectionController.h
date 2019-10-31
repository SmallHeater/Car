//
//  SHUIImagePickerController.h
//  SHUIImagePickerController
//
//  Created by xianjunwang on 2017/10/24.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  控制器

#import "SHPictureSelectionComponentInitModel.h"
#import "SHPictureSelectionViewController.h"

@interface SHPictureSelectionController : NSObject


+(SHPictureSelectionController *)sharedManager;
//配置模型
@property (nonatomic,strong) SHPictureSelectionComponentInitModel * configurationModel;


//返回包含所有模型的数组
- (void)loadAllPhoto:(void(^)(NSMutableArray *arr))result;
//判断有无使用相册权限
-(AlbumState)getAlbumAuthority;
//判断有无照相机使用权限
-(CameraState)getCameraAuthority;
//清理内存(本模块生命周期结束时调用)
-(void)clearMemary;
@end
