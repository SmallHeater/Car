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
        
    }
    return _releaseBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
}

//扫描按钮的响应
-(void)sacnningBtnClicked:(UIButton *)btn{
    
}

@end
