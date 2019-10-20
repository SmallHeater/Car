//
//  MineHeadCell.m
//  Car
//
//  Created by mac on 2019/10/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MineHeadCell.h"
#import "SHLabelAndLabelView.h"
#import "SHImageAndTitleBtn.h"

@interface MineHeadCell ()

//头部背景
@property (nonatomic,strong) UIImageView * topImageView;
@property (nonatomic,strong) UIImageView * avaterImageView;
@property (nonatomic,strong) UILabel * shopNameLabel;
@property (nonatomic,strong) UILabel * phoneLabel;
@property (nonatomic,strong) UIImageView * arrowImageView;
//信用
@property (nonatomic,strong) UIView * creditView;
@property (nonatomic,strong) UIImageView * creditImageView;
@property (nonatomic,strong) UILabel * creditLabel;
//中间白底view
@property (nonatomic,strong) UIView * middleWhiteView;
//红包
@property (nonatomic,strong) SHLabelAndLabelView * redEnvelopeView;
@property (nonatomic,strong) UILabel * firstLine;
//短信
@property (nonatomic,strong) SHLabelAndLabelView * smsView;
@property (nonatomic,strong) UILabel * secondLine;
//每日任务
@property (nonatomic,strong) SHImageAndTitleBtn * dailyTaskBtn;
//每日奖励
@property (nonatomic,strong) SHImageAndTitleBtn * dailyRewardBtn;
//签到抽大奖
@property (nonatomic,strong) SHImageAndTitleBtn * signInBtn;
//底部灰条
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation MineHeadCell

#pragma mark  ----  懒加载

-(UIImageView *)topImageView{
    
    if (!_topImageView) {
        
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodebeijingtu"]];
        
        [_topImageView addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.top.offset(45);
            make.width.height.offset(72);
        }];
        
        [_topImageView addSubview:self.shopNameLabel];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.topImageView.mas_right).offset(18);
            make.top.equalTo(self.topImageView.mas_top).offset(14);
            make.height.offset(20);
            make.right.offset(-37);
        }];
        
        [_topImageView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.shopNameLabel.mas_left);
            make.top.equalTo(self.shopNameLabel.mas_bottom).offset(14);
            make.width.offset(120);
        }];
        
        [_topImageView addSubview:self.creditView];
        [self.creditView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.phoneLabel.mas_right);
            make.top.equalTo(self.shopNameLabel.mas_bottom).offset(9);
            make.width.offset(66);
            make.height.offset(20);
        }];
        
        [_topImageView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(73);
            make.right.offset(15);
            make.width.height.offset(22);
        }];
    }
    return _topImageView;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.masksToBounds = YES;
        _avaterImageView.layer.cornerRadius = 36;
        _avaterImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _avaterImageView;
}

-(UILabel *)shopNameLabel{
    
    if (!_shopNameLabel) {
        
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = BOLDFONT20;
        _shopNameLabel.textColor = [UIColor whiteColor];
    }
    return _shopNameLabel;
}

-(UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = FONT14;
        _phoneLabel.textColor = Color_FFFEFE;
    }
    return _phoneLabel;
}

-(UIImageView *)arrowImageView{
    
    if (!_arrowImageView) {
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youjiantou"]];
    }
    return _arrowImageView;
}

-(UIView *)creditView{
    
    if (!_creditView) {
        
        _creditView = [[UIView alloc] init];
        _creditView.layer.masksToBounds = YES;
        _creditView.layer.cornerRadius = 9.75;
        _creditView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [_creditView addSubview:self.creditImageView];
        [self.creditImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(7.5);
            make.top.offset(5);
            make.width.offset(9);
            make.height.offset(10);
        }];
        
        [_creditView addSubview:self.creditLabel];
        [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.creditImageView.mas_right).offset(5);
            make.top.bottom.right.offset(0);
        }];
    }
    return _creditView;
}

-(UIImageView *)creditImageView{
    
    if (!_creditImageView) {
        
        _creditImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xinyong"]];
    }
    return _creditImageView;
}

-(UILabel *)creditLabel{
    
    if (!_creditLabel) {
        
        _creditLabel = [[UILabel alloc] init];
        _creditLabel.font = FONT10;
        _creditLabel.textColor = Color_FFFEFE;
        _creditLabel.text = @"信用";
    }
    return _creditLabel;
}

-(UIView *)middleWhiteView{
    
    if (!_middleWhiteView) {
        
        _middleWhiteView = [[UIView alloc] init];
        _middleWhiteView.backgroundColor = [UIColor whiteColor];
        _middleWhiteView.layer.masksToBounds = YES;
        _middleWhiteView.layer.cornerRadius = 10;
        _middleWhiteView.layer.shadowColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:0.23].CGColor;
        _middleWhiteView.layer.shadowOffset = CGSizeMake(0,1);
        _middleWhiteView.layer.shadowOpacity = 1;
        _middleWhiteView.layer.shadowRadius = 9;
        _middleWhiteView.layer.cornerRadius = 10;
        
        
        //每块宽度
        float oneWidth = (MAINWIDTH - 15 * 2 - 3) / 3;
        [_middleWhiteView addSubview:self.redEnvelopeView];
        [self.redEnvelopeView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(0);
            make.top.offset(25);
            make.width.offset(oneWidth);
            make.height.offset(41);
        }];
        
        [_middleWhiteView addSubview:self.firstLine];
        [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.redEnvelopeView.mas_right);
            make.top.offset(40);
            make.width.offset(1.5);
            make.height.offset(13);
        }];
    }
    return _middleWhiteView;
}

-(SHLabelAndLabelView *)redEnvelopeView{
    
    if (!_redEnvelopeView) {
        
        _redEnvelopeView = [[SHLabelAndLabelView alloc] initWithTopStr:@"0" andTopLabelHeight:16 andBottomStr:@"红包" andBottomHeight:12];
        [_redEnvelopeView setTopLabelFont:BOLDFONT20 bottomLabelFont:FONT12];
        [_redEnvelopeView setTopLabelTextColor:Color_333333 bottomLabelTextColor:Color_333333];
        [_redEnvelopeView setTopLabelTextAlignment:NSTextAlignmentCenter bottomLabelTextAlignment:NSTextAlignmentCenter];
    }
    return _redEnvelopeView;
}

-(UILabel *)firstLine{
    
    if (!_firstLine) {
        
        _firstLine = [[UILabel alloc] init];
        _firstLine.backgroundColor = Color_E6E6E6;
    }
    return _firstLine;
}

-(SHLabelAndLabelView *)smsView{
    
    if (!_smsView) {
        
        _smsView = [[SHLabelAndLabelView alloc] initWithTopStr:@"0" andTopLabelHeight:16 andBottomStr:@"短信数" andBottomHeight:12];
        [_smsView setTopLabelFont:BOLDFONT20 bottomLabelFont:FONT12];
        [_smsView setTopLabelTextColor:Color_333333 bottomLabelTextColor:Color_333333];
        [_smsView setTopLabelTextAlignment:NSTextAlignmentCenter bottomLabelTextAlignment:NSTextAlignmentCenter];
    }
    return _smsView;
}

-(UILabel *)secondLine{
    
    if (!_secondLine) {
        
        _secondLine = [[UILabel alloc] init];
        _secondLine.backgroundColor = Color_E6E6E6;
    }
    return _secondLine;
}

-(SHImageAndTitleBtn *)dailyTaskBtn{
    
    if (!_dailyTaskBtn) {
        
        _dailyTaskBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake(14, 0, 21, 20) andTitleFrame:CGRectMake(0, 30, 49, 12) andImageName:@"meirirenwu" andSelectedImageName:@"meirirenwu" andTitle:@"每日任务"];
    }
    return _dailyTaskBtn;
}

-(SHImageAndTitleBtn *)dailyRewardBtn{
    
    if (!_dailyRewardBtn) {
        
        _dailyRewardBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake(0, 0, 39, 31) andTitleFrame:CGRectMake(49, 0, 67, 31) andImageName:@"meirijiangli" andSelectedImageName:@"meirijiangli" andTitle:@"每日奖励"];
    }
    return _dailyTaskBtn;
}

-(SHImageAndTitleBtn *)signInBtn{
    
    if (!_signInBtn) {
        
        _signInBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake(0, 0, 39, 31) andTitleFrame:CGRectMake(49, 0, 67, 31) andImageName:@"qiandao" andSelectedImageName:@"qiandao" andTitle:@"签到抽大奖"];
    }
    return _dailyTaskBtn;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLineLabel;
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
    
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(176);
    }];
}



@end
