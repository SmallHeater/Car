//
//  SHAssetBaseModel.h
//  SHUIImagePickerController
//
//  Created by xianjunwang on 2018/7/20.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//


@interface SHAssetBaseModel : NSObject


/**
 *  缩略图（默认尺寸kThumbnailTargetSize)
 */
@property (nonatomic, strong) UIImage * thumbnails;
/**
 *  是否选中
 */
@property (nonatomic) BOOL selected;
/**
 *  唯一标识符
 */
@property (nonatomic, strong, readonly, nonnull) NSString *identifier;


@end
