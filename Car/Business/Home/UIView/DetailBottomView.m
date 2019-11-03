//
//  DetailBottomView.m
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "DetailBottomView.h"
#import "SHImageAndTitleBtn.h"

@interface DetailBottomView ()

@property (nonatomic,strong) UIButton * collectBtn;
@property (nonatomic,strong) SHImageAndTitleBtn * phoneBtn;

@end

@implementation DetailBottomView

#pragma mark  ----  懒加载

-(UIButton *)collectBtn{
    
    if (!_collectBtn) {
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"shoucangxuanzhong"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(collectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

-(SHImageAndTitleBtn *)phoneBtn{
    
    if (!_phoneBtn) {
        
        float collectBtnWidth = MAINWIDTH * 84.0 / 375.0;
        float phoneBtnWidth = MAINWIDTH - collectBtnWidth;
        
        _phoneBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(collectBtnWidth, 0, phoneBtnWidth, 50) andImageFrame:CGRectMake(113, 14, 22, 22) andTitleFrame:CGRectMake(143, 0, 40, 50) andImageName:@"dianhua" andSelectedImageName:@"" andTitle:@"电话"];
        [_phoneBtn refreshFont:BOLDFONT18];
        _phoneBtn.backgroundColor = Color_38AC68;
        [_phoneBtn refreshColor:[UIColor whiteColor]];
        [_phoneBtn addTarget:self action:@selector(phoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    float collectBtnWidth = MAINWIDTH * 84.0 / 375.0;
    [self addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.offset(0);
        make.width.offset(collectBtnWidth);
    }];
    [self addSubview:self.phoneBtn];
}

-(void)refreshCollectinState:(BOOL)isCollected{
    
    [self.collectBtn setSelected:isCollected];
}

-(void)collectBtnClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
}

-(void)phoneBtnClicked:(SHImageAndTitleBtn *)btn{
    
}

@end
