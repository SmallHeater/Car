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
@property (nonatomic,strong) UIButton * scanningBtn;
//中间搜索view
@property (nonatomic,strong) SHSearchTF * searchTF;
//右侧发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * releaseBtn;


@end

@implementation HomeNavgationBar

#pragma mark  ----  懒加载

-(UIButton *)scanningBtn{
    
    if (!_scanningBtn) {
        
        _scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanningBtn setImage:[UIImage imageNamed:@"saomiao"] forState:UIControlStateNormal];
        [_scanningBtn setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
        [_scanningBtn addTarget:self action:@selector(sacnningBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanningBtn;
}

-(SHSearchTF *)searchTF{
    
    if (!_searchTF) {
        
        _searchTF = [[SHSearchTF alloc] initWithRightImageName:@"xiangji"];
        _searchTF.delegate = self;
        _searchTF.placeholder = @"请输入需要搜索的内容";
        _searchTF.rightViewCallback = ^{
            
        };
    }
    return _searchTF;
}

-(SHImageAndTitleBtn *)releaseBtn{
    
    if (!_releaseBtn) {
        
        _releaseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 36 - 19, 0, 36, 40) andImageFrame:CGRectMake(3, 0, 30, 30) andTitleFrame:CGRectMake(0, 30, 36, 10) andImageName:@"fabu" andSelectedImageName:@"" andTitle:@"发布" andTarget:self andAction:@selector(releaseBtnClicked:)];
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
        make.width.height.offset(40);
    }];
    
    [self addSubview:self.searchTF];
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(57);
        make.top.bottom.offset(0);
        make.right.offset(-68);
    }];
    
    [self addSubview:self.releaseBtn];
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.offset(0);
        make.right.offset(-19);
        make.width.offset(40);
    }];
}

//扫描按钮的响应
-(void)sacnningBtnClicked:(UIButton *)btn{
    
}

//发布按钮的响应
-(void)releaseBtnClicked:(UIButton *)btn{
    
    
}

@end
