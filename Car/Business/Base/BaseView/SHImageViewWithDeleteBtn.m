//
//  EvaImageView.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/5.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "SHImageViewWithDeleteBtn.h"

@interface SHImageViewWithDeleteBtn ()

@property (nonatomic,strong) UIButton * btn;

@end


@implementation SHImageViewWithDeleteBtn

#pragma mark  ----  懒加载
-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(UIButton *)btn{
    
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark  ----  生命周期函数
//实例化方法
-(instancetype)initWithImage:(UIImage *)image andButtonTag:(NSUInteger)btnTag{

    self = [super init];
    if (self) {
        
        [self drawUI];
        if (image) {
            
            self.imageView.image = image;
        }
        self.btn.tag = btnTag;
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
    
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.offset(0);
        make.width.height.offset(22);
    }];
}

-(void)btnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    if (self.deleteCallBack) {
        
        self.deleteCallBack(btn.tag);
    }
    
    btn.userInteractionEnabled = YES;
}

@end
