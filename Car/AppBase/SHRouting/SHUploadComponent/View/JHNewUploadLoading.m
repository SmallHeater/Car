//
//  JHNewUploadLoading.m
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/2/26.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "JHNewUploadLoading.h"



#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define kDuration 3.0

@interface JHNewUploadLoading ()

@property (nonatomic,strong) UIView * loadingBGView;

/**
 *进度条宽度
 */
@property (nonatomic,assign) CGFloat progressLineWidth;
/**
 *  背景线条宽度
 */
@property (nonatomic,assign) CGFloat backgroundLineWidth;

/**
 *  背景填充颜色
 */
@property (nonatomic,strong) UIColor * backgroundStrokeColor;
/**
 *  进度条填充颜色
 */
@property (nonatomic,strong) UIColor * progressStrokeColor;
/**
 *  距离边框边距偏移量
 */
@property (nonatomic,assign) CGFloat offset;

/**
 *  数字字体颜色
 */
@property (nonatomic,strong) UIColor * digitTintColor;

@property (nonatomic,strong) CAShapeLayer * backgroundLayer;
@property (nonatomic,strong) CAShapeLayer * progressLayer;
@property (nonatomic,strong) UILabel * progressLabel;



@end

@implementation JHNewUploadLoading

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    if (self) {
        
        [self addSubview:self.loadingBGView];
        [self setUp];
    
        self.backgroundLineWidth = kDuration;
        self.progressLineWidth = kDuration;
        self.progress = 0;
        self.offset = 0;
    }
    return self;
}

#pragma mark  ----  自定义函数
/**
 *  初始化创建图层
 */
- (void)setUp{
    
    self.progressLabel.text = @"0%";
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.font = [UIFont systemFontOfSize:12 weight:0.4];
    self.progressLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.progressLabel];
    
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.frame = CGRectMake(16, 16, 38, 38);
    _backgroundLayer.fillColor = nil;
    _backgroundLayer.strokeColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1].CGColor;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(16, 16, 38, 38);
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    [self.loadingBGView.layer addSublayer:_backgroundLayer];
    [self.loadingBGView.layer addSublayer:_progressLayer];
}


#pragma mark  ----  SET
-(void)setProgress:(CGFloat)progress{
    
    __weak JHNewUploadLoading * weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        weakSelf.progressLayer.strokeEnd = progress;

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = [NSNumber numberWithFloat:weakSelf.progress];
        animation.toValue = [NSNumber numberWithFloat:progress];
        animation.duration = kDuration;
        [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    });

    _progress = progress;
}

- (void)setBackgroundCircleLine{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.loadingBGView.center.x - self.loadingBGView.frame.origin.x - 16, self.loadingBGView.center.y - self.loadingBGView.frame.origin.y - 16)
                                          radius:(self.loadingBGView.frame.size.width -     _backgroundLineWidth - 16) / 2 - _offset
                                      startAngle:0
                                        endAngle:M_PI*2
                                       clockwise:YES];
    
    _backgroundLayer.path = path.CGPath;
}

- (void)setProgressCircleLine{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath     bezierPathWithArcCenter:CGPointMake(self.loadingBGView.center.x - self.loadingBGView.frame.origin.x - 16, self.loadingBGView.center.y - self.loadingBGView.frame.origin.y - 16)
                                              radius:(self.loadingBGView.frame.size.width - _progressLineWidth - 16)/2 - _offset
                                          startAngle:-M_PI_2
                                            endAngle:-M_PI_2 + M_PI *2
                                           clockwise:YES];
    _progressLayer.path = path.CGPath;
}

- (void)setDigitTintColor:(UIColor *)digitTintColor{
    
    _digitTintColor = digitTintColor;
    _progressLabel.textColor = _digitTintColor;
}

- (void)setBackgroundLineWidth:(CGFloat)backgroundLineWidth{
    
    _backgroundLineWidth = backgroundLineWidth;
    _backgroundLayer.lineWidth = _backgroundLineWidth;
    [self setBackgroundCircleLine];
}

- (void)setProgressLineWidth:(CGFloat)progressLineWidth{
    
    _progressLineWidth = progressLineWidth;
    _progressLayer.lineWidth = _progressLineWidth;
    [self setProgressCircleLine];
}


- (void)setBackgroundStrokeColor:(UIColor *)backgroundStrokeColor{
    
    _backgroundStrokeColor = backgroundStrokeColor;
    _backgroundLayer.strokeColor =     _backgroundStrokeColor.CGColor;
}

- (void)setProgressStrokeColor:(UIColor *)progressStrokeColor{
    
    _progressStrokeColor = progressStrokeColor;
    _progressLayer.strokeColor = _progressStrokeColor.CGColor;
}

#pragma mark  ----  懒加载
-(UIView *)loadingBGView{
    
    if (!_loadingBGView) {
        
        _loadingBGView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 70) / 2.0, (SCREENHEIGHT - 70) / 2.0, 70, 70)];
        _loadingBGView.layer.backgroundColor = [UIColor colorWithRed:70/255.0 green:73/255.0 blue:78/255.0 alpha:0.6].CGColor;
        _loadingBGView.layer.cornerRadius = 4;
    }
    return _loadingBGView;
}

- (UILabel *)progressLabel{
    
    if (!_progressLabel) {
        
        _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.bounds.size.width -100)/2, (self.bounds.size.height - 100)/2, 100, 100)];
    }
    return _progressLabel;
}

@end
