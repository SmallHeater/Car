//
//  VideoRecordingView.m
//  Car
//
//  Created by xianjun wang on 2019/11/7.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VideoRecordingView.h"
#import "VideoCompress.h"


@interface VideoRecordingView ()<AVCaptureFileOutputRecordingDelegate>

@property (strong, nonatomic) AVCaptureSession * captureSession;  //负责输入和输出设备之间的连接会话
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput; // 输入源
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * previewLayer;//捕获到的视频呈现的layer
@property (strong, nonatomic) AVCaptureDeviceInput * audioMicInput;//麦克风输入
@property (strong, nonatomic) AVCaptureConnection * videoConnection;//视频录制连接
@property (strong,nonatomic) AVCaptureMovieFileOutput * captureMovieFileOutput;//视频输出流
@property (nonatomic, assign) AVCaptureFlashMode mode;//设置聚焦曝光
@property (nonatomic, strong) AVCaptureDevice *captureDevice;   // 输入设备
@property (nonatomic, assign) AVCaptureDevicePosition position;//设置焦点
//录制计时显示
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) dispatch_source_t timer;

@end

@implementation VideoRecordingView

#pragma mark  ----  懒加载

//设置相机画布
-(AVCaptureVideoPreviewLayer *)previewLayer{
    
    if (!_previewLayer) {
        
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}


//创建会话
-(AVCaptureSession *)captureSession{
    
    if (!_captureSession) {
        
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = AVCaptureSessionPreset1280x720; // 画质
        // 5. 连接输入与会话
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput:self.captureDeviceInput];
        }
        // 6. 连接输出与会话
        if ([_captureSession canAddOutput:self.captureMovieFileOutput]) {
            [_captureSession addOutput:self.captureMovieFileOutput];
        }
    }
    return _captureSession;
}

//创建输入源
-(AVCaptureDeviceInput *)captureDeviceInput{
    
    if (!_captureDeviceInput) {
        
        _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    }
    return _captureDeviceInput;
}

//麦克风输入
- (AVCaptureDeviceInput *)audioMicInput {
    
    if (_audioMicInput == nil) {
        
        AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        NSError *error;
        _audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
        if (error) {
            //  NSLog(@"获取麦克风失败~%d",[self isAvailableWithMic]);
        }
    }
    return _audioMicInput;
}

//初始化设备输出对象，用于获得输出数据
- (AVCaptureMovieFileOutput *)captureMovieFileOutput
{
    if(_captureMovieFileOutput == nil)
    {
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    }
    return _captureMovieFileOutput;
}

//创建输入设备
-(AVCaptureDevice *)captureDevice{
    
    if (!_captureDevice) {
        
        //        设置默认前置摄像头
        _captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    }
    return _captureDevice;
}


//视频连接
- (AVCaptureConnection *)videoConnection {
    
    _videoConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([_videoConnection isVideoStabilizationSupported ]) {
        _videoConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
    }
    return _videoConnection;
}

//获取焦点
-(AVCaptureDevicePosition)position{
    
    if (!_position) {
        
        _position = AVCaptureDevicePositionFront;
    }
    return _position;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [SHUIScreenControl liuHaiHeight], MAINWIDTH, 80)];
        _timeLabel.font = FONT16;
        _timeLabel.textColor = Color_FF4C4B;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

#pragma mark  ----  生命周期函数

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer insertSublayer:self.previewLayer atIndex:0];
        __weak typeof(self)weakSelf = self;
        //    监听屏幕方向
        [[NSNotificationCenter   defaultCenter]addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            weakSelf.previewLayer.connection.videoOrientation = [self getCaptureVideoOrientation];
        }];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.previewLayer.frame = self.bounds;
    [self startRunning];
}

#pragma mark  ----  自定义函数

//开始运行
-(void)startRunning{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.captureSession startRunning];
    });
}

//停止运行
-(void)stopRunning{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.captureSession stopRunning];
    });
}

//获取视频方向
- (AVCaptureVideoOrientation)getCaptureVideoOrientation {
    
    AVCaptureVideoOrientation result;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown，则视频方向和拍摄时的方向是相反的。
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            result = AVCaptureVideoOrientationPortrait;
            break;
    }
    return result;
}

//开始录制
- (void)startCapture
{
    if(self.captureMovieFileOutput.isRecording){
        return;
    }
    
    [self addSubview:self.timeLabel];
    __block NSUInteger time = 0;
    __weak typeof(self) weakSelf = self;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        
        NSUInteger hour = 0;
        NSUInteger minute = 0;
        NSUInteger seconds = 0;
        hour = time / 3600;
        minute = time / 60;
        seconds = time % 60;
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"录制中  %ld:%ld:%ld",hour,minute,seconds];
        time++;
    });
    dispatch_resume(self.timer);
    
    NSString *defultPath = [self getVideoPathCache];
    NSString *outputFielPath=[ defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mp4"]];
    NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
    //设置录制视频流输出的路径
    [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
}

//停止录制
- (void) stopCapture
{
    [self.timeLabel removeFromSuperview];
    if ([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];//停止录制
    }
}

//闪光灯开关
-(void)lightAction{
    
    if (self.mode == AVCaptureFlashModeOn) {
        [self setMode:AVCaptureFlashModeOff];
    } else {
        [self setMode:AVCaptureFlashModeOn];
    }
}

//切换前后摄像头
- (void)cameraPosition:(NSString *)camera{
    
    if ([camera isEqualToString:@"前置"]) {
        
        if (self.captureDevice.position != AVCaptureDevicePositionFront) {
            self.position = AVCaptureDevicePositionFront;
        }
    }
    else if ([camera isEqualToString:@"后置"]){
        
        if (self.captureDevice.position != AVCaptureDevicePositionBack) {
            self.position = AVCaptureDevicePositionBack;
        }
    }
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:self.position];
    if (device) {
        self.captureDevice = device;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:self.captureDeviceInput];
        if ([self.captureSession canAddInput:input]) {
            [self.captureSession addInput:input];
            self.captureDeviceInput = input;
            [self.captureSession commitConfiguration];
        }
    }
}

//视频输出代理开始录制
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    //    SHOWMESSAGE(@"开始录制");
}

//录制完成回调
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    [MBProgressHUD wj_showActivityLoading:@"处理中" toView:[UIApplication sharedApplication].keyWindow];
    [VideoCompress compressVideoWithVideoUrl:outputFileURL withBiteRate:nil withFrameRate:nil withVideoWidth:[NSNumber numberWithInteger:1080] withVideoHeight:[NSNumber numberWithInteger:1920] compressComplete:^(id  _Nonnull responseObjc) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [MBProgressHUD wj_hideHUDForView:[UIApplication sharedApplication].keyWindow];
        });
        NSDictionary * dic = (NSDictionary *)responseObjc;
        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic.allKeys containsObject:@"urlStr"]) {
            
            if (self.pathCallBack) {
                
                self.pathCallBack(dic[@"urlStr"]);
            }
        }
    }];
}

//视频地址
- (NSString *)getVideoPathCache
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}

//拼接视频文件名称
- (NSString *)getVideoNameWithType:(NSString *)fileType
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@",timeStr,fileType];
    return fileName;
}

@end
