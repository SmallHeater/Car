//
//  HomeNavgationBar.m
//  Car
//
//  Created by xianjun wang on 2019/9/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeNavgationBar.h"
#import "SHSearchTF.h"


@interface HomeNavgationBar ()<UITextFieldDelegate>

//左侧扫一扫按钮
@property (nonatomic,strong) UIButton * scanningBtn;
//中间搜索view
@property (nonatomic,strong) SHSearchTF * searchTF;
//右侧发布按钮
@property (nonatomic,strong) UIButton * releaseBtn;


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
        _searchTF.rightViewCallback = ^{
            
        };
    }
    return _searchTF;
}

-(UIButton *)releaseBtn{
    
    if (!_releaseBtn) {
        
        _releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_releaseBtn setImage:[UIImage imageNamed:@"fabu"] forState:UIControlStateNormal];
        [_releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
        _releaseBtn.titleLabel.font = FONT10;
        [_releaseBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        [_releaseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        [_releaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
        [_releaseBtn addTarget:self action:@selector(releaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _releaseBtn.backgroundColor = [UIColor redColor];
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
