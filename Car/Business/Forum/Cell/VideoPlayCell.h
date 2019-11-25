//
//  VideoPlayCell.h
//  Car
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  视频播放cell

#import "SHBaseTableViewCell.h"
#import "VideoModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayCell : SHBaseTableViewCell

-(void)playVideo:(VideoModel *)video;

@end

NS_ASSUME_NONNULL_END
