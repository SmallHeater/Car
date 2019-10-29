//
//  PushAndPlayViewController.m
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PushAndPlayViewController.h"
#import "SHImageAndTitleBtn.h"

@interface PushAndPlayViewController ()

@property (nonatomic,strong) UIImageView * bgImageView;
//关闭按钮
@property (nonatomic,strong) UIButton * clostBtn;
//发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * publishBtn;
//我发布的
@property (nonatomic,strong) SHImageAndTitleBtn * myPublish;
//头像
@property (nonatomic,strong) UIImageView * avaterImageView;
//收藏
@property (nonatomic,strong) SHImageAndTitleBtn * collectBtn;
//点赞
@property (nonatomic,strong) SHImageAndTitleBtn * praiseBtn;
//分享
@property (nonatomic,strong) SHImageAndTitleBtn * shareBtn;
//昵称
@property (nonatomic,strong) UILabel * nickNameLabel;
//标题
@property (nonatomic,strong) UILabel * titleLabel;

@end

@implementation PushAndPlayViewController

#pragma mark  ----  懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.backgroundColor = [UIColor grayColor];
        
        [_bgImageView addSubview:self.clostBtn];
        [self.clostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(10);
            make.top.offset(28 + [SHUIScreenControl liuHaiHeight]);
            make.width.height.offset(28);
        }];
        
        [_bgImageView addSubview:self.myPublish];
        [self.myPublish mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(27 + [SHUIScreenControl liuHaiHeight]);
            make.right.offset(-11);
            make.width.offset(60);
            make.height.offset(34);
        }];
        
        [_bgImageView addSubview:self.publishBtn];
        [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.myPublish.mas_top);
            make.right.equalTo(self.myPublish.mas_left).offset(-20);
            make.width.offset(30);
            make.height.equalTo(self.myPublish.mas_height);
        }];
        
        [_bgImageView addSubview:self.shareBtn];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.offset(-30 - [SHUIScreenControl bottomSafeHeight]);
            make.right.offset(-20);
            make.width.offset(26);
            make.height.offset(45);
        }];
        
        [_bgImageView addSubview:self.praiseBtn];
        [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.shareBtn.mas_top).offset(-20);
            make.right.equalTo(self.shareBtn.mas_right);
            make.width.equalTo(self.shareBtn.mas_width);
            make.height.equalTo(self.shareBtn.mas_height);
        }];
        
        [_bgImageView addSubview:self.collectBtn];
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.praiseBtn.mas_top).offset(-20);
            make.right.equalTo(self.praiseBtn.mas_right);
            make.width.equalTo(self.praiseBtn.mas_width);
            make.height.equalTo(self.praiseBtn.mas_height);
        }];
        
        [_bgImageView addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.collectBtn.mas_top).offset(-36);
            make.right.offset(-10);
            make.width.height.offset(48);
        }];
        
        [_bgImageView addSubview:self.titleLabel];
        [_bgImageView addSubview:self.nickNameLabel];
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.bottom.offset(-74);
            make.height.offset(20);
            make.width.offset(200);
        }];
    }
    return _bgImageView;
}

-(UIButton *)clostBtn{
    
    if (!_clostBtn) {
        
        _clostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clostBtn setImage:[UIImage imageNamed:@"guanbibaise"] forState:UIControlStateNormal];
        _clostBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        __weak typeof(self) weakSelf = self;
        [[_clostBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _clostBtn;
}

-(SHImageAndTitleBtn *)publishBtn{
    
    if (!_publishBtn) {
        
        NSUInteger btnWidth = 30;
        _publishBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"fabubaise" andSelectedImageName:@"fabubaise" andTitle:@"发布"];
    }
    return _publishBtn;
}

-(SHImageAndTitleBtn *)myPublish{
    
    if (!_myPublish) {
        
        NSUInteger btnWidth = 60;
        _myPublish = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"wofabude" andSelectedImageName:@"wofabude" andTitle:@"我发布的"];
    }
    return _myPublish;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 24;
    }
    return _avaterImageView;
}

-(SHImageAndTitleBtn *)collectBtn{
    
    if (!_collectBtn) {
        
        NSUInteger btnWidth = 26;
        _collectBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"shoucangbaise" andSelectedImageName:@"shoucangbaise" andTitle:@"0"];
    }
    return _collectBtn;
}

-(SHImageAndTitleBtn *)praiseBtn{
    
    if (!_praiseBtn) {
        
        NSUInteger btnWidth = 26;
        _praiseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"zan" andSelectedImageName:@"zan" andTitle:@"0"];
    }
    return _praiseBtn;
}

-(SHImageAndTitleBtn *)shareBtn{
    
    if (!_shareBtn) {
        
        NSUInteger btnWidth = 26;
        _shareBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"fenxiangbaise" andSelectedImageName:@"fenxiangbaise" andTitle:@"0"];
    }
    return _shareBtn;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = BOLDFONT16;
        _nickNameLabel.textColor = [UIColor whiteColor];
    }
    return _nickNameLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT15;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}


@end
