//
//  SmartCamareViewController.m
//  JHLivePlayLibrary
//
//  Created by pk on 2018/3/13.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "JHSmartCamareViewController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/imgcodecs/ios.h>



@interface JHSmartCamareViewController ()<CvVideoCameraDelegate>{
    
    cv::Mat keepMatImg;
    UITextField * TF;
    BOOL isNeedToCut;
    float IdeltaCount;
    NSTimer *timer;
    UIButton * finishBtn;
}

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)CvVideoCamera *videoCamera;

@property (nonatomic,strong)UIImageView *resultImageView;

@property (nonatomic,strong)UILabel * fuzzyText;
@property (nonatomic,strong)UIButton *repeatBtn;
@property (nonatomic,strong) UIImage * keepImageAlive;

@end

@implementation JHSmartCamareViewController

- (instancetype)initWithType:(CameraGetPictureType)getPictureType{
    self = [super init];
    if (self) {
        switch (getPictureType) {
            case CameraGetPictureType_Licence:
            {
                isNeedToCut = NO;
                IdeltaCount = 260;
            }
                break;
            case CameraGetPictureType_IDCard:
            {
                isNeedToCut = YES;
                IdeltaCount = 50;
            }
                break;
                
            default:{
                isNeedToCut = NO;
                IdeltaCount = 260;
            }
                break;
        }
    }
    return self;
}

- (void)createVideo {
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.delegate = self;
//    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1920x1080;
    //设置摄像头的方向
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    [self.videoCamera start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    self.imageView.center = self.view.center;
    
    [self.view bringSubviewToFront:self.repeatBtn];
    
    if (isNeedToCut == YES) {
        CGFloat mianW = UIScreen.mainScreen.bounds.size.width;
        CGFloat w = mianW ,h = mianW/130*82;
        TF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        TF.layer.borderColor = [UIColor whiteColor].CGColor;
        TF.layer.borderWidth = 1.0;
        TF.enabled = NO;
        [self.view addSubview:TF];
        TF.center = self.view.center;
    }
    
    [self createVideo];
    [self createBtns];
    
    [self addTimerInRunloop];
}

- (void)addTimerInRunloop{
    timer = [NSTimer timerWithTimeInterval:8.0 target:self selector:@selector(remindChooseTakeWay) userInfo:nil repeats:YES];
    NSRunLoop * runloop = [NSRunLoop mainRunLoop];
    [runloop  addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)remindChooseTakeWay{
    [timer invalidate];
    [self.videoCamera stop];
    UIAlertController * alertCtrl = [UIAlertController alertControllerWithTitle:@"拍照提示" message:@"请正上方对准证件，重新扫描拍照" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * continueAct = [UIAlertAction actionWithTitle:@"继续扫描拍照" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self addTimerInRunloop];
        [self.videoCamera start];
    }];
    
    UIAlertAction * tkSystemAct = [UIAlertAction actionWithTitle:@"手工拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (self.showSysCamare) {
            [self dismissViewControllerAnimated:NO completion:^{
                 self.showSysCamare();
            }];
           
        }
    }];
    
    [alertCtrl addAction:continueAct];
    [alertCtrl addAction:tkSystemAct];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

- (void)createBtns{
    
    UIView * btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, MAINHEIGHT - 80 - [UIScreenControl bottomSafeHeight], MAINWIDTH, 80)];
    btnBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:btnBgView];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 40)];
    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancalTakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btnBgView addSubview:cancelBtn];
    
    UIButton * retakeBtn = [[UIButton alloc] initWithFrame:CGRectMake((MAINWIDTH - 100)/2, 20, 100, 40)];
    [retakeBtn setTitle:@"重新抓取" forState:UIControlStateNormal];
    [retakeBtn addTarget:self action:@selector(reTakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btnBgView addSubview:retakeBtn];

    finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINWIDTH - 60, 20, 60, 40)];
    [finishBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    [btnBgView addSubview:finishBtn];
    finishBtn.hidden = YES;
    
}

- (void)cancalTakePhoto:(id)sender{
    self.getImageCallBack = nil;
    [self disposeCamare];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reTakePhoto:(id)sender{
    finishBtn.hidden = YES;
    self.keepImageAlive = nil;
    self.imageView.image = nil;
    [self.videoCamera start];
    [timer invalidate];
    [self addTimerInRunloop];
}

- (void)disposeCamare {
    [timer invalidate];
    [self.videoCamera stop];
    self.videoCamera.delegate = nil;
    self.videoCamera = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishTakePhoto{
    [self disposeCamare];
    if (self.getImageCallBack) {
        self.getImageCallBack(self.keepImageAlive);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processImage:(cv::Mat &)image
{
    cv::Mat outCopyImg;
    image.copyTo(outCopyImg);
    cv::cvtColor(outCopyImg, outCopyImg, CV_BGR2RGB);
    
    if ([self whetherTheImageBlurry:image]) {
        [timer invalidate];
        
        [self.videoCamera stop];
        keepMatImg = outCopyImg;
        if (isNeedToCut == YES) {
            CGFloat mianW = UIScreen.mainScreen.bounds.size.width;
            CGFloat  NH = mianW * 1920 / 1080;
            cv::Rect rect(0,(1920 - NH)/2,1080,NH);
            cv::Mat image_roi = outCopyImg(rect);
            self.keepImageAlive = MatToUIImage(image_roi);
        }else{
            self.keepImageAlive = MatToUIImage(outCopyImg);
        }
        
        NSLog(@"keepImageAlive.size = %@",NSStringFromCGSize(self.keepImageAlive.size));
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.keepImageAlive) {
                self.imageView.image = MatToUIImage(outCopyImg);
                finishBtn.hidden = NO;
                self.imageView.alpha = 0.0;
                [UIView animateWithDuration:0.5f animations:^{
                    self.imageView.alpha = 1.0;
                }];
            }
        });
    }else{
        
    }
    
}


- (BOOL)whetherTheImageBlurry:(cv::Mat)mat{
    
    unsigned char *data;
    int height,width,step;
    
    int Iij;
    
    double Iave = 0, Idelta = 0;
    
    if(!mat.empty()){
        cv::Mat gray;
        cv::Mat outGray;
        // 将图像转换为灰度显示
        cv::cvtColor(mat,gray,CV_RGB2GRAY);
        
        cv::Laplacian(gray, outGray, gray.depth());
        
       
        IplImage ipl_image(outGray);
        
        data   = (uchar*)ipl_image.imageData;
        height = ipl_image.height;
        width  = ipl_image.width;
        step   = ipl_image.widthStep;
        
        for(int i=0;i<height;i++)
        {
            for(int j=0;j<width;j++)
            {
                Iij    = (int) data
                [i*width+j];
                Idelta    = Idelta + (Iij-Iave)*(Iij-Iave);
            }
        }
        Idelta = Idelta/(width*height);
        
        std::cout<<"矩阵方差为："<<Idelta<<std::endl;
    }
    
    return (Idelta > IdeltaCount) ? YES : NO;
}

- (BOOL)isPhotoContainsFeature:(UIImage *)image{
    CIContext * context = [CIContext contextWithOptions:nil];
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    CIImage * ciimage = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray * detectResult = [faceDetector featuresInImage:ciimage];
    
    return detectResult.count;
}

@end
