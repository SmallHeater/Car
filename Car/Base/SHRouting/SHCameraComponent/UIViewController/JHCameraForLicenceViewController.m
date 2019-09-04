//
//  JHCameraForLicenceViewController.m
//  TestWebView
//
//  Created by pk on 2018/10/15.
//  Copyright © 2018年 pk. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "JHCameraForLicenceViewController.h"
#import "JHCameraResultView.h"


@interface JHCameraForLicenceViewController ()
{
    
    CGRect cameraRect;
    
    CGRect cameraOutPhotoViewRect;
}
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic,strong)JHCameraResultView * cameraResultView;

@property (nonatomic,strong)UIButton * cameraLightBtn;
@property (nonatomic,strong)UIButton * takePhotoBtn;
@property (nonatomic,strong)UIButton * cancelBtn;
//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
//拍照图片
@property (nonatomic,strong) UIImage * keepImageAlive;

@property (nonatomic,strong)UIImageView * imageView;

@end

@implementation JHCameraForLicenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cameraRect = CGRectMake(0, 90, MAINWIDTH, MAINHEIGHT - 180);
    
    CGFloat height = (MAINWIDTH - 60)*4/3;
    cameraOutPhotoViewRect = CGRectMake(30, (cameraRect.size.height - height)/2, MAINWIDTH - 60, height);
    
    [self cameraDistrict];
    
    [self.view addSubview:self.cameraLightBtn];
    [self.view addSubview:self.takePhotoBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.finishBtn];

    self.view.backgroundColor = [UIColor blackColor];
}

- (void)cameraDistrict
{
    self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    // 这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    self.imageOutput.outputSettings = outputSettings;
    self.session = [[AVCaptureSession alloc] init];
    // 拿到的图像的大小可以自行设定
    // AVCaptureSessionPreset320x240
    // AVCaptureSessionPreset352x288
    // AVCaptureSessionPreset640x480
    // AVCaptureSessionPreset960x540
    // AVCaptureSessionPreset1280x720
    // AVCaptureSessionPreset1920x1080
    // AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = cameraRect;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.previewLayer.backgroundColor = [UIColor colorWithRed:0.4 green:0.15 blue:0.66 alpha:0.4].CGColor;
    
    [self.view.layer addSublayer:self.previewLayer];
    [self addlayerWhichMiddleIs];
    //设备取景开始
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
        NSNumber * flash = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERCAMERAFLASHMODELKEY"];
        if (flash == nil) {
            if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
                [_device setFlashMode:AVCaptureFlashModeOff];
            }
        }else{
            [_device setFlashMode:flash.integerValue];
        }
        
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
    
    [self.view addSubview:self.cameraResultView];
    
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

- (void)addlayerWhichMiddleIs{
    
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.previewLayer.bounds cornerRadius:0];
    //镂空
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:cameraOutPhotoViewRect];
    rectanglePath.lineWidth = 2.5;
    rectanglePath.lineJoinStyle = kCGLineJoinRound;
    [rectanglePath setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [path appendPath:rectanglePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空的关键点 填充规则
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.previewLayer addSublayer:fillLayer];
    
}

- (JHCameraResultView *)cameraResultView{
    if (_cameraResultView == nil) {
        _cameraResultView = [[JHCameraResultView alloc] initWithFrame:CGRectMake(cameraOutPhotoViewRect.origin.x, cameraOutPhotoViewRect.origin.y + cameraRect.origin.y, cameraOutPhotoViewRect.size.width, cameraOutPhotoViewRect.size.height)];
        _cameraResultView.backgroundColor = [UIColor clearColor];
    }
    return _cameraResultView;
}

#pragma mark - set buttons
- (UIButton *)cameraLightBtn{
    if (_cameraLightBtn == nil) {
        _cameraLightBtn = [[UIButton alloc] initWithFrame:CGRectMake((MAINWIDTH - 80)/2, 23 + [UIScreenControl liuHaiHeight], 80, 44)];
        _cameraLightBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
        _cameraLightBtn.layer.cornerRadius = 22.0;
        _cameraLightBtn.clipsToBounds = YES;
        [_cameraLightBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 13, 10, 52)];
        [_cameraLightBtn setTitleEdgeInsets:UIEdgeInsetsMake(14, -20, 14, 13)];
        [_cameraLightBtn addTarget:self action:@selector(cameraLightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self setCameraLightBtnImage];
    }
    return _cameraLightBtn;
}

- (void)setCameraLightBtnImage{
    //自动闪光灯，
    if (self.device.flashMode == AVCaptureFlashModeOn) {
        [_cameraLightBtn setTitle:@"打开" forState:UIControlStateNormal];
        [_cameraLightBtn setImage:[UIImage imageNamed:@"JHLiveCommonImages.bundle/openLight.tiff"] forState:UIControlStateNormal];
    }
    if (self.device.flashMode == AVCaptureFlashModeOff) {
         [_cameraLightBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_cameraLightBtn setImage:[UIImage imageNamed:@"JHLiveCommonImages.bundle/closeLight.tiff"] forState:UIControlStateNormal];
    }
}

- (void)cameraLightBtnClick{
    if ([_device lockForConfiguration:nil]) {
        if (self.device.flashMode == AVCaptureFlashModeOn) {
            self.device.flashMode = AVCaptureFlashModeOff;
        }else{
            self.device.flashMode = AVCaptureFlashModeOn;
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.device.flashMode] forKey:@"USERCAMERAFLASHMODELKEY"];
        [self setCameraLightBtnImage];
        [_device unlockForConfiguration];
    }
}

- (UIButton *)takePhotoBtn{
    if (_takePhotoBtn == nil) {
        _takePhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake((MAINWIDTH - 62)/2, MAINHEIGHT - 14 - 62, 62, 62)];
        [_takePhotoBtn setImage:[UIImage imageNamed:@"JHLiveCommonImages.bundle/takeCamera.tiff"] forState:UIControlStateNormal];
        [_takePhotoBtn setImage:[UIImage imageNamed:@"JHLiveCommonImages.bundle/takeCamera.tiff"] forState:UIControlStateHighlighted];
        [_takePhotoBtn addTarget:self action:@selector(takePhtoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoBtn;
}

//finish the photograph
- (void)finishBtnClicked:(UIButton *)sender{
    if (self.imageCallBack) {
        [self cancelClick];
        self.imageCallBack(self.keepImageAlive);
    }
}
- (void)takePhtoClick{
    AVCaptureConnection *videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection == nil) {
        return;
    }
    __weak typeof(self) _wks = self;
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (imageDataSampleBuffer == NULL || error) {
                return;
            }
            [_wks.session stopRunning];
            
            NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
//            NSLog(@"imagedata = %@",imageData);
            UIImage * image = [UIImage imageWithData:imageData];
//            NSLog(@"图片方向 = %d",image.imageOrientation);
//            [_wks judgeImageOrientation:image];
//            NSLog(@"image = %@",image);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = image;
//
//                [self imageByCroppingWithImage:image];
//            });
            
//            CFDictionaryRef myAttachments = CMGetAttachment(imageDataSampleBuffer, kCGImagePropertyExifDictionary, NULL);
//            NSLog(@"影像属性: %@", myAttachments);
            _wks.keepImageAlive = [_wks imageByCroppingWithImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.keepImageAlive) {
                    self.finishBtn.hidden = NO;
                }
            });
            
            //callback image
//            if (_wks.imageCallBack) {
//                _wks.imageCallBack([_wks imageByCroppingWithImage:image]);
//            }
            //cancel current page
//            [_wks cancelClick];
        });
        
    }];
}

- (void)judgeImageOrientation:(UIImage *)image{
    switch (image.imageOrientation) {
        case UIImageOrientationUp:
            NSLog(@"%@",@"UIImageOrientationUp");
            break;
        case UIImageOrientationDown:
            NSLog(@"%@",@"UIImageOrientationDown");
            break;
        case UIImageOrientationLeft:
            NSLog(@"%@",@"UIImageOrientationLeft");
            break;
        case UIImageOrientationRight:
            NSLog(@"%@",@"UIImageOrientationRight");
            break;
        case UIImageOrientationUpMirrored:
            NSLog(@"%@",@"UIImageOrientationUpMirrored");
            break;
        case UIImageOrientationDownMirrored:
            NSLog(@"%@",@"UIImageOrientationDownMirrored");
            break;
        case UIImageOrientationLeftMirrored:
            NSLog(@"%@",@"UIImageOrientationLeftMirrored");
            break;
        case UIImageOrientationRightMirrored:
            NSLog(@"%@",@"UIImageOrientationRightMirrored");
            break;
        default:
            break;
    }
}

- (UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINWIDTH - 80, MAINHEIGHT - 90 + 25, 80, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [[UIButton alloc] initWithFrame:CGRectMake( 10, MAINHEIGHT - 90 + 25, 60, 40)];
        [_finishBtn setTitle:@"完 成" forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _finishBtn.hidden = YES;
    }
    return _finishBtn;
}
- (void)cancelClick{
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



//剪裁图片
-(UIImage*)imageByCroppingWithImage:(UIImage*)myImage
{

    CGRect rect = CGRectMake(0, 0, myImage.size.height, myImage.size.width);
    CGImageRef imageRef = myImage.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage * cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
//    self.imageView.image = cropImage;
    
    CGFloat xifu = cropImage.size.width/cameraRect.size.height;
    CGFloat width = xifu*cameraOutPhotoViewRect.size.height;
    CGFloat height = xifu*cameraOutPhotoViewRect.size.width;
    CGRect cutRect = CGRectMake((cropImage.size.width - width)/2, (cropImage.size.height - height)/2, width, height);
    CGRect rect2 = cutRect;
    CGImageRef imageRef2 = cropImage.CGImage;
    CGImageRef imagePartRef2 = CGImageCreateWithImageInRect(imageRef2,rect2);
    UIImage * cropImage2 = [UIImage imageWithCGImage:imagePartRef2];
    CGImageRelease(imagePartRef2);
//    self.imageView.image = cropImage2;
    
    return cropImage2;
}

- (void)dealloc{
    self.imageCallBack = nil;
}

@end


