//
//  SHBaseWKWebViewController.m
//  Car
//
//  Created by mac on 2019/9/13.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaseWKWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface SHBaseWKWebViewController ()

//地址
@property (nonatomic,strong) NSString * urlStr;

@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView * progressView;//进度条

@end

@implementation SHBaseWKWebViewController

#pragma mark  ----  懒加载

-(WKWebView *)webView{
    
    if (!_webView) {
        
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];

        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    }
    return _webView;
}

-(UIProgressView *)progressView{
    
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc] init];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andURLStr:(NSString *)urlStr{
    
    self = [super initWithTitle:title andIsShowBackBtn:isShowBackBtn];
    if (self) {
        
        NSString * tempUrlStr = [NSString repleaseNilOrNull:urlStr];
        if ([tempUrlStr hasPrefix:@"http:"] || [tempUrlStr hasPrefix:@"https:"]) {
            
            self.urlStr = tempUrlStr;
        }
        else{
            
            self.urlStr = @"https://www.baidu.com";
            NSLog(@"异常：地址不合规");
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self addKVO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
    }];
    
    [self.navigationbar addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(2);
        make.height.offset(2);
    }];
    
    [self.view bringSubviewToFront:self.navigationbar];
}

//增加kvo监听，获得页面title和加载进度值
- (void)addKVO{
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark ----  KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"]){
        
        if (object == self.webView){
            
            self.progressView.alpha = 1;
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.progressView.alpha = 0;
                } completion:^(BOOL finished) {
                    
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }else{
            
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){//网页title
        
        if (object == self.webView){
            
            self.navTitle = self.webView.title;
        }else{
            
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
