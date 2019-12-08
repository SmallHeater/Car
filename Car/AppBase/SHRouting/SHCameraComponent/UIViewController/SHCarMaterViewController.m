//
//  SHCarMaterViewController.m
//  Car
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHCarMaterViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SHCarMaterViewController (){
    
    CGRect cameraOutPhotoViewRect;
}

@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UILabel * titleLabel;
//相框view
@property (nonatomic,strong) UIImageView * circleImageView;
//提示label
@property (nonatomic,strong) UILabel * promptLabel;
//去相册按钮
@property (nonatomic,strong) UIButton * albumBtn;
//拍照按钮
@property (nonatomic,strong) UIButton * takePhotoBtn;
//闪光灯按钮
@property (nonatomic,strong) UIButton * flashBtn;

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


@end

@implementation SHCarMaterViewController

#pragma mark  ----  懒加载

-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (weakSelf.navigationController) {
                
                if (weakSelf.navigationController.viewControllers.count == 1) {
                    
                    [weakSelf.navigationController dismissViewControllerAnimated:NO completion:nil];
                }else{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
    return _backBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT18;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"行驶证识别";
    }
    return _titleLabel;
}

-(UIImageView *)circleImageView{
    
    if (!_circleImageView) {
        
        _circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
    }
    return _circleImageView;
}

-(UILabel *)promptLabel{
    
    if (!_promptLabel) {
        
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.font = FONT16;
        _promptLabel.textColor = [UIColor whiteColor];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.text = @"将行驶证放入框内拍照识别";
    }
    return _promptLabel;
}

-(UIButton *)albumBtn{
    
    if (!_albumBtn) {
        
        _albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_albumBtn setImage:[UIImage imageNamed:@"album"] forState:UIControlStateNormal];
    }
    return _albumBtn;
}

-(UIButton *)takePhotoBtn{
    
    if (!_takePhotoBtn) {
        
        _takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePhotoBtn setImage:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
    }
    return _takePhotoBtn;
}

-(UIButton *)flashBtn{
    
    if (!_flashBtn) {
        
        _flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashBtn setImage:[UIImage imageNamed:@"flash"] forState:UIControlStateNormal];
    }
    return _flashBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    cameraOutPhotoViewRect = CGRectMake(16, 208, MAINWIDTH - 16 * 2, 260.0 / 343.0 * (MAINWIDTH - 16 * 2));
    [self cameraDistrict];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.view.backgroundColor =  [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(31 + [SHUIScreenControl liuHaiHeight]);
        make.width.height.offset(22);
    }];
    
    float titleWidth = 150;
    float leftInterval = (MAINWIDTH - titleWidth) / 2;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(leftInterval);
        make.top.offset(31 + [SHUIScreenControl liuHaiHeight]);
        make.width.offset(titleWidth);
        make.height.offset(25);
    }];
    
    [self.view addSubview:self.circleImageView];
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(208);
        make.right.offset(-16);
        make.height.offset(260.0 / 343.0 * (MAINWIDTH - 16 * 2));
    }];
    
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.circleImageView.mas_bottom).offset(20);
        make.height.offset(23);
    }];
    
    [self.view addSubview:self.albumBtn];
    [self.albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(22);
        make.left.offset(71);
        make.top.equalTo(self.promptLabel.mas_bottom).offset(120);
    }];
    
    [self.view addSubview:self.takePhotoBtn];
    [self.takePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(60);
        make.top.equalTo(self.promptLabel.mas_bottom).offset(100);
        make.left.offset((MAINWIDTH - 60) / 2);
    }];
    
    [self.view addSubview:self.flashBtn];
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-88);
        make.top.equalTo(self.promptLabel.mas_bottom).offset(120);
        make.width.offset(13);
        make.height.offset(24);
    }];
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
    self.previewLayer.frame = cameraOutPhotoViewRect;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
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
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

@end
