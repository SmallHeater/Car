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
        [_backBtn setImage:[UIImage imageNamed:@"IntimatePersonForOCSource.bundle/back.tiff"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT18;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowBackBtn:(BOOL)isShowBackBtn{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = Color_F74C32;
        self.isShowBackBtn = isShowBackBtn;
        [self setUI];
        self.titleLabel.text = [title repleaseNilOrNull];
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    if (self.isShowBackBtn) {
        
        [self addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.bottom.offset(-16);
            make.width.height.offset(16);
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

@end
