//
//  AboutViewController.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  图片是1080*1920分辨率

#import "AboutViewController.h"

@interface AboutViewController ()

//图片高
@property (nonatomic,assign) float imageHeight;

@property (nonatomic,strong) UIScrollView * bgScrollView;
@property (nonatomic,strong) UIImageView * aboutImageView;

@end

@implementation AboutViewController

#pragma mark  ----  懒加载

-(float)imageHeight{
    
    return 1920.0 / 1080.0 * MAINWIDTH;
}

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
        float showHeight = MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - [SHUIScreenControl bottomSafeHeight];
        _bgScrollView.contentSize = CGSizeMake(MAINWIDTH, self.imageHeight > showHeight?showHeight:self.imageHeight);
        
        [_bgScrollView addSubview:self.aboutImageView];
        __weak typeof(self) weakSelf = self;
        [self.aboutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.offset(0);
            make.width.offset(MAINWIDTH);
            make.height.offset(weakSelf.imageHeight);
        }];
    }
    return _bgScrollView;
}

-(UIImageView *)aboutImageView{
    
    if (!_aboutImageView) {
        
        _aboutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guanyushuoming"]];
    }
    return _aboutImageView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    float showHeight = MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - [SHUIScreenControl bottomSafeHeight];
    float bgViewHeight = self.imageHeight > showHeight?showHeight:self.imageHeight;
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.height.offset(bgViewHeight);
    }];
}

@end
