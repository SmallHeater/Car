//
//  HomeNavgationBar.m
//  Car
//
//  Created by xianjun wang on 2019/9/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeNavgationBar.h"
#import "SHSearchTF.h"
#import "SHImageAndTitleBtn.h"

@interface HomeNavgationBar ()<UITextFieldDelegate>

//左侧扫一扫按钮
@property (nonatomic,strong) SHImageAndTitleBtn * scanningBtn;
//中间标题
@property (nonatomic,strong) UILabel * titleLabel;
//右侧发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * releaseBtn;


@end

@implementation HomeNavgationBar

#pragma mark  ----  懒加载

-(SHImageAndTitleBtn *)scanningBtn{
    
    if (!_scanningBtn) {
        
        _scanningBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(15, 0, 36, 40) andImageFrame:CGRectMake(10, 0, 20, 20) andTitleFrame:CGRectMake(0, 25, 40, 10) andImageName:@"saomiao" andSelectedImageName:@"saomiao" andTitle:@"机油"];
        [_scanningBtn addTarget:self action:@selector(sacnningBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanningBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT18;
        _titleLabel.textColor = Color_333333;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        NSDictionary * infoDic = [NSBundle mainBundle].infoDictionary;
        _titleLabel.text = infoDic[@"CFBundleDisplayName"];
    }
    return _titleLabel;
}

-(SHImageAndTitleBtn *)releaseBtn{
    
    if (!_releaseBtn) {
        
        _releaseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 36 - 19, 0, 36, 40) andImageFrame:CGRectMake(10, 0, 20, 20) andTitleFrame:CGRectMake(0, 25, 40, 10) andImageName:@"fabuone" andSelectedImageName:@"" andTitle:@"发布"];
        [_releaseBtn addTarget:self action:@selector(releaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.scanningBtn];
    [self.scanningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.offset(8);
        make.width.offset(40);
        make.height.offset(35);
    }];

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(100);
        make.right.offset(-100);
        make.top.bottom.offset(0);
    }];
    
    [self addSubview:self.releaseBtn];
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.right.offset(-19);
        make.width.offset(40);
        make.height.offset(35);
    }];
}

//扫描按钮的响应
-(void)sacnningBtnClicked:(UIButton *)btn{
}

//发布按钮的响应
-(void)releaseBtnClicked:(UIButton *)btn{
}

@end
