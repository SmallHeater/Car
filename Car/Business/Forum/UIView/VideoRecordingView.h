//
//  VideoRecordingView.h
//  Car
//
//  Created by xianjun wang on 2019/11/7.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  视频录制view

#import "SHBaseView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VideoPathCallBack)(NSString * path);

@interface VideoRecordingView : SHBaseView

//视频路径回调
@property (nonatomic,copy) VideoPathCallBack pathCallBack;

// 闪光灯开关
-(void)lightAction;
//停止运行
-(void)stopRunning;
//开始运行
-(void)startRunning;
//开始录制
- (void) startCapture;
//停止录制
- (void) stopCapture;
/**
 切换前后摄像头
 @param camera 前置、后置
 */
- (void)cameraPosition:(NSString *)camera;

@end

NS_ASSUME_NONNULL_END
