//
//  JHPictureSelectionComponent.h
//  JHPictureSelectionComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  图片选择组件

#import "SHPictureSelectionComponentInitModel.h"

@interface SHPictureSelectionComponent : NSObject

/*
 参数字典:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:8],@"sourceType":[NSNumber numberWithInteger:0],@"UIViewController":self}
 tkCamareType,相机类型，0:系统相机;1:自动抓拍;2:带身份证大小的边框;3:横屏带框.canSelectImageCount:可以选择的照片个数。sourceType,资源类型。0:图片，1:视频,2:媒体。UIViewController:父视图指针。
 回调数组：@{@"data":@[@"thumbnails":@"缩略图",@"selected":@"是否选中",@"identifier":@"唯一标识符",@"asset":@"PHAsset *",@"originalImage":@"原图",@"previewImage":@"预览图"]}
 */


+(void)getImagesWithInitModel:(SHPictureSelectionComponentInitModel *)initModel callBack:(void(^)(NSMutableArray * dataArray))result;

@end
