//
//  SHUIImagePickerViewController.h
//  SHUIImagePickerController
//
//  Created by xianjunwang on 2017/10/24.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//  照片选择页面

#import "BaseUIViewController.h"
#import "SHAssetImageModel.h"
#import "SHAssetVideoModel.h"



typedef void(^resultBlock)(NSMutableArray<SHAssetBaseModel *> * selectModelArray);

@protocol SHUIImagePickerProtocol <NSObject>

-(void)finiSHSelectedWithArray:(NSMutableArray *)array;

@end

@interface SHPictureSelectionViewController : BaseUIViewController

//代理和Block两种回调二选一
@property (nonatomic,copy) resultBlock block;

@property (nonatomic,weak) id<SHUIImagePickerProtocol>delegate;

@end
