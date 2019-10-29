//
//  VideoCollectionViewCell.h
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  小视频cell

#import <UIKit/UIKit.h>
#import "VideoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface VideoCollectionViewCell : UICollectionViewCell

-(void)show:(VideoModel *)model;

@end

NS_ASSUME_NONNULL_END
