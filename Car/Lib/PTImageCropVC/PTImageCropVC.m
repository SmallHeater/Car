//
//  ImageCropViewController.m
//  ptcommon
//
//  Created by 李超 on 16/6/8.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import "PTImageCropVC.h"
#import "UIImage+Helper.h"

//箭头的宽度
#define ARROWWIDTH 44
//箭头的高度
#define ARROWHEIGHT 44
//两个相邻箭头之间的最短距离
#define ARROWMINIMUMSPACE 30
//箭头单边的宽度
#define ARROWBORDERWIDTH 5

@interface PTImageCropVC () {
    //蒙版
    UIView* m_bgView;
    //图片
    UIImageView* m_bgImage;
    //透明区域的视图
    UIView* m_cropView;
    
    UIImageView* m_pointImage1;
    UIImageView* m_pointImage2;
    UIImageView* m_pointImage3;
    UIImageView* m_pointImage4;
    
    CGPoint m_startPoint1;
    CGPoint m_startPoint2;
    CGPoint m_startPoint3;
    CGPoint m_startPoint4;
    CGPoint m_startPointCropView;
    CGFloat m_imageScale;
    
    UIPanGestureRecognizer* m_panView;
}
@property (nonatomic, strong) UIImage* image;
@property (nonatomic) CGFloat cropScale;
@property (nonatomic, copy) void (^completeBlock)(UIImage* image);
@property (nonatomic, copy) void (^cancelBlock)(id sender);
@end

@implementation PTImageCropVC

#pragma mark-- 生命周期函数

/**
 *  @author fangbmian, 16-06-12 09:06:49
 *
 *  初始化
 *
 *  @param image         被裁剪照片
 *  @param cropScale     裁剪比例（高/宽）
 *  @param complentBlock 完成回调
 *  @param cancelBlock   取消回调
 *
 *  @return self
 */

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andImage:(UIImage*)image withCropScale:(CGFloat)cropScale complentBlock:(void (^)(UIImage* image))complentBlock cancelBlock:(void (^)(id sender))cancelBlock{
    
    self = [super initWithTitle:title andIsShowBackBtn:isShowBackBtn];
    if (self) {
        
        self.image = [image fixOrientation]; // 注意该处
        self.cropScale = cropScale;
        self.completeBlock = complentBlock;
        self.cancelBlock = cancelBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLayout];
    [self loadImage];
    [self updateCropViewFrame];
}

- (void)dealloc
{
    [m_cropView removeGestureRecognizer:m_panView];
}

#pragma mark  ----  自定义函数

- (void)initLayout
{
    m_bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, [SHUIScreenControl navigationBarHeight], MAINWIDTH, MAINHEIGHT - 64 - [SHUIScreenControl bottomSafeHeight])];
    [m_bgImage setImage:self.image];
    [self.view addSubview:m_bgImage];
    
    m_bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [SHUIScreenControl navigationBarHeight], MAINWIDTH, MAINHEIGHT - 64 - [SHUIScreenControl bottomSafeHeight])];
    [m_bgView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [self.view addSubview:m_bgView];
    
    m_cropView = [[UIView alloc] init];
    m_panView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCropView:)];
    [m_cropView addGestureRecognizer:m_panView];
    [m_bgView addSubview:m_cropView];
    
    
    m_pointImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROWWIDTH, ARROWHEIGHT)];
    [m_pointImage1 setImage:[UIImage imageNamed:@"JHLivePlayBundle.bundle/ic_left_top_point.png"]];
    [m_bgView addSubview:m_pointImage1];
    
    
    m_pointImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROWWIDTH, ARROWHEIGHT)];
    [m_pointImage2 setImage:[UIImage imageNamed:@"JHLivePlayBundle.bundle/ic_right_top_point.png"]];
    [m_bgView addSubview:m_pointImage2];
    
    
    m_pointImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROWWIDTH, ARROWHEIGHT)];
    [m_pointImage3 setImage:[UIImage imageNamed:@"JHLivePlayBundle.bundle/ic_right_top_point.png"]];
    m_pointImage3.transform = CGAffineTransformMakeRotation(M_PI);
    [m_bgView addSubview:m_pointImage3];
    
    
    m_pointImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROWWIDTH, ARROWHEIGHT)];
    [m_pointImage4 setImage:[UIImage imageNamed:@"JHLivePlayBundle.bundle/ic_left_top_point.png"]];
    m_pointImage4.transform = CGAffineTransformMakeRotation(M_PI);
    [m_bgView addSubview:m_pointImage4];
    
    UIButton* comBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 112, 20 + [SHUIScreenControl liuHaiHeight], 100, 44)];
    [comBtn setTitle:@"完成" forState:UIControlStateNormal];
    [comBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [comBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationbar addSubview:comBtn];
}

- (void)loadImage
{
    CGRect frame = m_bgImage.frame;
    CGPoint center = CGPointMake(MAINWIDTH / 2.0, (MAINHEIGHT - 64) / 2.0 + 64);
    CGFloat wscale = self.image.size.width / CGRectGetWidth(m_bgImage.frame);
    CGFloat hscale = self.image.size.height / CGRectGetHeight(m_bgImage.frame);
    
    frame.size.height = self.image.size.height / MAX(wscale, hscale);
    frame.size.width = self.image.size.width / MAX(wscale, hscale);
    
    m_imageScale = MAX(wscale, hscale);
    m_bgImage.frame = frame;
    m_bgImage.center = center;
    m_bgImage.contentMode = UIViewContentModeScaleToFill;
    [m_bgImage setNeedsUpdateConstraints];
}

- (void)updateCropViewFrame{
    
    m_cropView.frame = CGRectMake(0, 0, CGRectGetWidth(m_bgImage.frame), CGRectGetWidth(m_bgImage.frame) * _cropScale);
    
    m_cropView.center = m_bgImage.center;
    [self resetAllArrows];
    [self resetCropMask];
}

/**
 *  @author fangbmian, 16-06-12 13:06:42
 *
 *  根据当前裁剪区域的位置和尺寸将黑色蒙板的相应区域抠成透明
 */
- (void)resetCropMask
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:m_bgView.bounds];
    UIBezierPath* clearPath = [[UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(m_cropView.frame), CGRectGetMinY(m_cropView.frame), CGRectGetWidth(m_cropView.frame), CGRectGetHeight(m_cropView.frame))] bezierPathByReversingPath];
    [path appendPath:clearPath];
    
    CAShapeLayer* shapeLayer = (CAShapeLayer*)m_bgView.layer.mask;
    if (!shapeLayer) {
        shapeLayer = [CAShapeLayer layer];
        [m_bgView.layer setMask:shapeLayer];
    }
    shapeLayer.path = path.CGPath;
}


/**
 *  @author fangbmian, 16-06-12 13:06:33
 *
 *  根据当前裁剪区域的位置重新设置所有角的位置
 */
- (void)resetAllArrows
{
    m_pointImage1.center = CGPointMake(CGRectGetMinX(m_cropView.frame) - ARROWBORDERWIDTH + ARROWWIDTH / 2.0, CGRectGetMinY(m_cropView.frame) - ARROWBORDERWIDTH + ARROWHEIGHT / 2.0);
    m_pointImage2.center = CGPointMake(CGRectGetMaxX(m_cropView.frame) + ARROWBORDERWIDTH - ARROWWIDTH / 2.0, CGRectGetMinY(m_cropView.frame) - ARROWBORDERWIDTH + ARROWHEIGHT / 2.0);
    m_pointImage3.center = CGPointMake(CGRectGetMinX(m_cropView.frame) - ARROWBORDERWIDTH + ARROWWIDTH / 2.0, CGRectGetMaxY(m_cropView.frame) + ARROWBORDERWIDTH - ARROWHEIGHT / 2.0);
    m_pointImage4.center = CGPointMake(CGRectGetMaxX(m_cropView.frame) + ARROWBORDERWIDTH - ARROWWIDTH / 2.0, CGRectGetMaxY(m_cropView.frame) + ARROWBORDERWIDTH - ARROWHEIGHT / 2.0);
    [self.view layoutIfNeeded];
}


#pragma mark-- Gesture --
/**
 *  @author fangbmian, 16-06-12 13:06:59
 *
 *  移动裁剪区域的手势处理
 *
 *  @param panGesture panGesture
 */
- (void)moveCropView:(UIPanGestureRecognizer*)panGesture
{
    CGFloat minX = CGRectGetMinX(m_bgImage.frame);
    CGFloat maxX = CGRectGetMaxX(m_bgImage.frame) - CGRectGetWidth(m_cropView.frame);
    CGFloat minY = 0;
    CGFloat maxY = CGRectGetMaxY(m_bgImage.frame) - CGRectGetHeight(m_cropView.frame) - 64;
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        m_startPointCropView = [panGesture locationInView:m_bgView];
        m_pointImage1.userInteractionEnabled = NO;
        m_pointImage2.userInteractionEnabled = NO;
        m_pointImage3.userInteractionEnabled = NO;
        m_pointImage4.userInteractionEnabled = NO;
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        m_pointImage1.userInteractionEnabled = YES;
        m_pointImage2.userInteractionEnabled = YES;
        m_pointImage3.userInteractionEnabled = YES;
        m_pointImage4.userInteractionEnabled = YES;
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint endPoint = [panGesture locationInView:m_bgView];
        CGRect frame = panGesture.view.frame;
        frame.origin.x += endPoint.x - m_startPointCropView.x;
        frame.origin.y += endPoint.y - m_startPointCropView.y;
        frame.origin.x = MIN(maxX, MAX(frame.origin.x, minX));
        frame.origin.y = MIN(maxY, MAX(frame.origin.y, minY));
        panGesture.view.frame = frame;
        m_startPointCropView = endPoint;
    }
    [self resetCropMask];
    [self resetAllArrows];
}

- (void)completeBtnClick:(id)sender
{
    if (self.completeBlock) {
        CGRect cropAreaInImageView = [m_bgView convertRect:m_cropView.frame toView:m_bgImage];
        CGRect cropAreaInImage;
        cropAreaInImage.origin.x = cropAreaInImageView.origin.x * m_imageScale;
        cropAreaInImage.origin.y = cropAreaInImageView.origin.y * m_imageScale;
        cropAreaInImage.size.width = cropAreaInImageView.size.width * m_imageScale;
        cropAreaInImage.size.height = cropAreaInImageView.size.height * m_imageScale;
        
        UIImage* cropImage = [self.image imageAtRect:cropAreaInImage];
        self.completeBlock(cropImage);
        [self backBtnClicked:nil];
    }
}

@end
