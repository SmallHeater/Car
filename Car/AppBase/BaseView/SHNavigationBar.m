//
//  SHNavigationBar.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//

#import "SHNavigationBar.h"

@interface SHNavigationBar ()

@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UILabel * titleLabel;
//是否显示返回按钮
@property (nonatomic,assign) BOOL isShowBackBtn;

@end

@implementation SHNavigationBar

#pragma mark  ----  懒加载
-(UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(11.5, 15, 11.5, 15)];
    }
    return _backBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT18;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

#pragma mark  ----  SET

-(void)setNavTitle:(NSString *)navTitle{
    
    _navTitle = navTitle;
    self.titleLabel.text = [NSString repleaseNilOrNull:navTitle];
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowBackBtn:(BOOL)isShowBackBtn{
    
    self = [super init];
    if (self) {
        
        self.isShowBackBtn = isShowBackBtn;
        self.navTitle = title;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)drawUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:0.23].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 9;
    
    
    if (self.isShowBackBtn) {
        
        [self addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(0);
            make.bottom.offset(0);
            make.width.height.offset(44);
        }];
    }
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(32);
        make.right.offset(-32);
        make.height.offset(18);
        make.bottom.offset(-15);
    }];
}

-(void)addbackbtnTarget:(id)target andAction:(SEL)action{
    
    if (target && action) {
        
        [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

//更新返回按钮图片
-(void)refreshBackBTnImage:(NSString *)imageName{
    
    [self.backBtn setImage:[UIImage imageNamed:[NSString repleaseNilOrNull:imageName]] forState:UIControlStateNormal];
}

@end
