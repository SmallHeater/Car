//
//  WelfareTreatmentView.m
//  Car
//
//  Created by xianjun wang on 2019/10/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "WelfareTreatmentView.h"

@interface WelfareTreatmentView ()

@property (nonatomic,strong) UIView * topView;
//关闭按钮
@property (nonatomic,strong) UIButton * closeBtn;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
@property (nonatomic,strong) UIView * bottomView;

@end

@implementation WelfareTreatmentView

#pragma mark  ----  懒加载

-(UIView *)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return _topView;
}

-(UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_999999;
        _titleLabel.text = @"福利待遇（可多选）";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)finishBtn{
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setTitleColor:Color_2E78FF forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = FONT16;
        [_finishBtn addTarget:self action:@selector(finishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = Color_F9FAFC;
        
        [_bottomView addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16 - 5);
            make.top.offset(20 - 5);
            make.width.height.offset(20 + 10);
        }];
        
        [_bottomView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(17);
            make.height.offset(22);
            make.width.offset(150);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_bottomView addSubview:self.finishBtn];
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(17);
            make.right.offset(15);
            make.width.offset(42);
            make.height.offset(22);
        }];
    }
    return _bottomView;
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
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset([UIScreenControl bottomSafeHeight] + 260);
    }];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

-(void)show:(NSArray<NSDictionary *> *)array{
    
    if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
     
        float btnX = 16;
        float btnY = 62;
        float btnHeight = 32;
        for (NSUInteger i = 0; i < array.count; i++) {
            
            NSDictionary * dic = array[i];
            NSString * title = dic[@"name"];
            float btnWidth = [title widthWithFont:FONT14 andHeight:btnHeight] + 50;
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = FONT14;
            [btn setTitleColor:Color_333333 forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 4;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            if (btnX + btnWidth + 16 > MAINWIDTH) {
                
                //换行
                btnX = 16;
                btnY += btnHeight + 12;
            }
            
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.offset(btnX);
                make.top.offset(btnY);
                make.width.offset(btnWidth);
                make.height.offset(btnHeight);
            }];
        }
    }
}

-(void)btnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
    
    [self removeFromSuperview];
}

-(void)finishBtnClicked{
    
    [self removeFromSuperview];
}

@end
