//
//  UnpaidCell.m
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RemindedCell.h"


@interface RemindedCell ()

//背景view
@property (nonatomic,strong) UIView * bgView;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
//车主姓名
@property (nonatomic,strong) UILabel * nameLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
//联系电话
@property (nonatomic,strong) UILabel * phoneNumberLabel;
//虚线分割线
@property (nonatomic,strong) UIImageView * dottedLineImageView;
//已提醒时间标题，时间
@property (nonatomic,strong) UILabel * remindedTimeTitleLabel;
@property (nonatomic,strong) UILabel * remindedTimeContentLabel;

@end

@implementation RemindedCell

#pragma mark  ----  懒加载

-(UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _bgView.layer.cornerRadius = 13;
        _bgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,2);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 10;
        
        [_bgView addSubview:self.numberPlateLabel];
        [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.offset(21);
            make.width.offset(150);
            make.height.offset(20);
        }];
        
        [_bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-16);
            make.top.offset(23);
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.height.offset(16);
        }];
        
        [_bgView addSubview:self.carModelLabel];
        [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(7);
            make.width.offset(MAINWIDTH - 32 - 100 - 36);
            make.height.offset(14);
        }];
        
        [_bgView addSubview:self.phoneNumberLabel];
        [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
            make.right.offset(-17);
            make.height.offset(14);
        }];
        
        [_bgView addSubview:self.dottedLineImageView];
        [self.dottedLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(self.carModelLabel.mas_bottom).offset(13);
            make.height.offset(1);
        }];
        
        [_bgView addSubview:self.remindedTimeTitleLabel];
        [self.remindedTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.dottedLineImageView).offset(15);
            make.width.offset(112);
            make.height.offset(22);
        }];
        
        [_bgView addSubview:self.remindedTimeContentLabel];
        [self.remindedTimeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-16);
            make.bottom.offset(-18);
            make.width.offset(150);
            make.height.offset(18);
        }];
    }
    return _bgView;
}

-(UILabel *)numberPlateLabel{
    
    if (!_numberPlateLabel) {
        
        _numberPlateLabel = [[UILabel alloc] init];
        _numberPlateLabel.font = BOLDFONT20;
        _numberPlateLabel.textColor = Color_333333;
    }
    return _numberPlateLabel;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = BOLDFONT16;
        _nameLabel.textColor = Color_666666;
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

-(UILabel *)carModelLabel{
    
    if (!_carModelLabel) {
        
        _carModelLabel = [[UILabel alloc] init];
        _carModelLabel.font = FONT14;
        _carModelLabel.textColor = Color_999999;
    }
    return _carModelLabel;
}

-(UILabel *)phoneNumberLabel{
    
    if (!_phoneNumberLabel) {
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = FONT14;
        _phoneNumberLabel.textColor = Color_999999;
        _phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _phoneNumberLabel;
}

-(UIImageView *)dottedLineImageView{
    
    if (!_dottedLineImageView) {
        
        _dottedLineImageView = [[UIImageView alloc] init];
        _dottedLineImageView.image = [UIImage imageNamed:@"fengexian"];
    }
    return _dottedLineImageView;
}

-(UILabel *)remindedTimeTitleLabel{
    
    if (!_remindedTimeTitleLabel) {
        
        _remindedTimeTitleLabel = [[UILabel alloc] init];
        _remindedTimeTitleLabel.font = FONT16;
        _remindedTimeTitleLabel.textColor = Color_484848;
        _remindedTimeTitleLabel.text = @"已提醒时间";
    }
    return _remindedTimeTitleLabel;
}

-(UILabel *)remindedTimeContentLabel{
    
    if (!_remindedTimeContentLabel) {
        
        _remindedTimeContentLabel = [[UILabel alloc] init];
        _remindedTimeContentLabel.font = FONT14;
        _remindedTimeContentLabel.textColor = Color_444444;
        _remindedTimeContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _remindedTimeContentLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithContent:(NSString *)content{
    
    return 131 + 15;
}

-(void)drawUI{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(15);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
    }];
}

-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
        self.remindedTimeContentLabel.text = dic[@"remindedTime"];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
        self.remindedTimeContentLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805",@"remindedTime":@"2019.01.01"}];
}
@end