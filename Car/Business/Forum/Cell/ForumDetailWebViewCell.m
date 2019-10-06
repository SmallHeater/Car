//
//  ForumDetailWebViewCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailWebViewCell.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface ForumDetailWebViewCell ()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,assign) float webViewHeight;

@end

@implementation ForumDetailWebViewCell

#pragma mark  ----  懒加载

-(WKWebView *)webView{
    
    if (!_webView) {
        
        WKWebViewConfiguration * congiguration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:congiguration];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    __weak typeof(self) weakSelf = self;
    // 隔一段时间再取高度，好让WebView渲染完取的高度更准确
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *jsTxt = @"document.body.offsetHeight;";
        [weakSelf.webView evaluateJavaScript:jsTxt completionHandler:^(id val, NSError *error) {
            
            if(val != nil){
                
                CGSize fittingSize = [weakSelf.webView sizeThatFits:CGSizeZero];
                CGFloat offsetHeight = [val floatValue];
                // 设置展示的UI相关高度
                weakSelf.webViewHeight = offsetHeight;
            }
        }];
    });
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithModel:(ForumArticleModel *)model{
    
    float cellHeight = 100;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.url]]]];
}

@end
