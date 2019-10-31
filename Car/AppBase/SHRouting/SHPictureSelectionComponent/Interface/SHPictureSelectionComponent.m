//
//  SHPictureSelectionComponent.m
//  SHPictureSelectionComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHPictureSelectionComponent.h"
#import "SHPictureSelectionController.h"


@implementation SHPictureSelectionComponent


#pragma mark  ----  自定义函数
+(void)getImagesWithInitModel:(SHPictureSelectionComponentInitModel *)initModel callBack:(void(^)(NSMutableArray * dataArray))result{
    
    
    SHPictureSelectionComponentInitModel * configurationModel;
    if (initModel) {
        
        configurationModel = initModel;
    }
    else{
        
        configurationModel = [[SHPictureSelectionComponentInitModel alloc] init];
    }
    
    [SHPictureSelectionController sharedManager].configurationModel = configurationModel;
    
    //权限判断
    if ([[SHPictureSelectionController sharedManager] getAlbumAuthority] == AlbumStatusAuthorized) {
        
        SHPictureSelectionViewController * imagePickerVC = [[SHPictureSelectionViewController alloc] initWithTitle:@"照片选择" andIsShowBackBtn:YES];
        imagePickerVC.block = ^(NSMutableArray<SHAssetBaseModel *> * selectModelArray){
            
            SHAssetBaseModel * firstModel = selectModelArray.firstObject;
            if ([firstModel isKindOfClass:[SHAssetImageModel class]]) {
                
                NSMutableArray * selectedImageArray = [[NSMutableArray alloc] init];
                for (NSUInteger i = 0; i < selectModelArray.count; i++) {
                    
                    SHAssetImageModel * imageModel = (SHAssetImageModel *)selectModelArray[i];
                    UIImage * thumbnails = imageModel.thumbnails;
                    UIImage * originalImage = imageModel.originalImage;
                    UIImage * screenSizeImage = imageModel.screenSizeImage;
                    NSDictionary * selectedImageDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:thumbnails,@"thumbnails",originalImage,@"originalImage",screenSizeImage,@"screenSizeImage", nil];
                    [selectedImageArray addObject:selectedImageDic];
                }
                result(selectedImageArray);
            }
            else if ([firstModel isKindOfClass:[SHAssetVideoModel class]]){
                
                NSMutableArray * selectedVideoArray = [[NSMutableArray alloc] init];
                for (NSUInteger i = 0; i < selectModelArray.count; i++) {
                    
                    SHAssetVideoModel * videoModel = (SHAssetVideoModel *)selectModelArray[i];
                    
                    double size = videoModel.size / 1000.0;
                    NSNumber * sizeNumber = [NSNumber numberWithDouble:size];
                    UIImage * thumbnails = videoModel.thumbnails;
                    NSString * filename = videoModel.filename;
                    NSURL * videoUrl = videoModel.videoUrl;
                    
                    NSDictionary * selectedVideoDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:thumbnails,@"thumbnails",sizeNumber,@"size",filename,@"filename",videoUrl,@"videoUrl", nil];
                    [selectedVideoArray addObject:selectedVideoDic];
                }
                result(selectedVideoArray);
            }
            
        };
       
            
        [[UIViewController topMostController]  presentViewController:imagePickerVC animated:NO completion:^{
            
        }];
    }
    else if([[SHPictureSelectionController sharedManager] getAlbumAuthority] == AlbumStatusDenied || [[SHPictureSelectionController sharedManager] getAlbumAuthority] == AlbumStatusRestricted){
        
        NSDictionary * inforDic = [NSBundle mainBundle].infoDictionary;
        NSString * message = [[NSString alloc] initWithFormat:@"请进入iPhone的“设置-隐私-照片”选项，允许%@访问您的手机相册。",inforDic[@"CFBundleDisplayName"]];
        //无权限
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAction];
        
        [[UIViewController topMostController]  presentViewController:alert animated:NO completion:nil];
    }
    else if ([[SHPictureSelectionController sharedManager] getAlbumAuthority] == AlbumStatusNotDetermined){
        
        //用户未作出选择
    }
}


@end
