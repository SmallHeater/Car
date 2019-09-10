//
//  UnpaidCell.m
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "UnpaidCell.h"

@interface UnpaidCell ()

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
//内容
@property (nonatomic,strong) UILabel * contentLabel;
//分割线
@property (nonatomic,strong) UILabel * firstLineLabel;

//应收
@property (nonatomic,strong) UILabel * receivableLabel;
//应收金额
@property (nonatomic,strong) UILabel * receivableContentLabel;
//实收
@property (nonatomic,strong) UILabel * actualHarvestLabel;
//实收金额
@property (nonatomic,strong) UILabel * actualHarvestContentLabel;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;
//欠款
@property (nonatomic,strong) UILabel * arrearsLabel;
//欠款金额
@property (nonatomic,strong) UILabel * arrearsContentLabel;
//立即回款按钮
@property (nonatomic,strong) UIButton * payBackBtn;

@end

@implementation UnpaidCell

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
        
        [_bgView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(self.dottedLineImageView).offset(14);
            make.height.offset(36);
        }];
        
        [_bgView addSubview:self.firstLineLabel];
        [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(16);
            make.height.offset(1);
        }];
        
        [_bgView addSubview:self.receivableLabel];
        [self.receivableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.equalTo(self.firstLineLabel.mas_bottom).offset(15);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.receivableContentLabel];
        [self.receivableContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-17);
            make.top.equalTo(self.receivableLabel.mas_top);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.actualHarvestLabel];
        [self.actualHarvestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.equalTo(self.receivableLabel.mas_bottom).offset(15);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.actualHarvestContentLabel];
        [self.actualHarvestContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-17);
            make.top.equalTo(self.actualHarvestLabel.mas_top);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.right.offset(-16);
            make.height.offset(1);
            make.top.equalTo(self.actualHarvestLabel.mas_bottom).offset(15);
        }];
        
        [_bgView addSubview:self.arrearsLabel];
        [self.arrearsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.lineLabel.mas_bottom).offset(15);
            make.width.offset(100);
            make.height.offset(18);
        }];
        
        [_bgView addSubview:self.arrearsContentLabel];
        [self.arrearsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-17);
            make.top.equalTo(self.arrearsLabel.mas_top);
            make.width.offset(100);
            make.height.offset(18);
        }];
        
        [_bgView addSubview:self.payBackBtn];
        [self.payBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-16);
            make.bottom.offset(-15);
            make.width.offset(76);
            make.height.offset(30);
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

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT14;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)receivableLabel{
    
    if (!_receivableLabel) {
        
        _receivableLabel = [[UILabel alloc] init];
        _receivableLabel.font = FONT16;
        _receivableLabel.textColor = Color_333333;
        _receivableLabel.text = @"应收";
    }
    return _receivableLabel;
}

-(UILabel *)receivableContentLabel{
    
    if (!_receivableContentLabel) {
        
        _receivableContentLabel = [[UILabel alloc] init];
        _receivableContentLabel.font = FONT16;
        _receivableContentLabel.textColor = Color_333333;
        _receivableContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _receivableContentLabel;
}

-(UILabel *)actualHarvestLabel{
    
    if (!_actualHarvestLabel) {
        
        _actualHarvestLabel = [[UILabel alloc] init];
        _actualHarvestLabel.font = FONT16;
        _actualHarvestLabel.textColor = Color_333333;
        _actualHarvestLabel.text = @"实收";
    }
    return _actualHarvestLabel;
}

-(UILabel *)actualHarvestContentLabel{
    
    if (!_actualHarvestContentLabel) {
        
        _actualHarvestContentLabel = [[UILabel alloc] init];
        _actualHarvestContentLabel.font = FONT16;
        _actualHarvestContentLabel.textColor = Color_333333;
        _actualHarvestContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _actualHarvestContentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DEDEDE;
    }
    return _lineLabel;
}

-(UILabel *)arrearsLabel{
    
    if (!_arrearsLabel) {
        
        _arrearsLabel = [[UILabel alloc] init];
        _arrearsLabel.textColor = Color_60A37D;
        _arrearsLabel.font = FONT16;
        _arrearsLabel.text = @"欠款";
    }
    return _arrearsLabel;
}

-(UILabel *)arrearsContentLabel{
    
    if (!_arrearsContentLabel) {
        
        _arrearsContentLabel = [[UILabel alloc] init];
        _arrearsContentLabel.textColor = Color_60A37D;
        _arrearsContentLabel.font = FONT16;
        _arrearsContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _arrearsContentLabel;
}

-(UIButton *)payBackBtn{
    
    if (!_payBackBtn) {
        
        _payBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBackBtn.backgroundColor = Color_0272FF;
        [_payBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBackBtn.titleLabel.font = FONT14;
        _payBackBtn.layer.cornerRadius = 15;
        [_payBackBtn setTitle:@"立即回款" forState:UIControlStateNormal];
        [_payBackBtn addTarget:self action:@selector(payBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBackBtn;
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

+(float)cellHeight{
    
    return 333;
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

-(void)payBackBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    
    if (self.btnClickCallBack) {
        
        self.btnClickCallBack();
    }
    
    btn.userInteractionEnabled = YES;
}


-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
        self.contentLabel.text = dic[@"content"];
        NSNumber * receivableNumber = dic[@"receivable"];
        self.receivableContentLabel.text = [[NSString alloc] initWithFormat:@"%.2f",receivableNumber.floatValue];
        NSNumber * actualHarvestNumber = dic[@"actualHarvest"];
        self.actualHarvestContentLabel.text = [[NSString alloc] initWithFormat:@"%.2f",actualHarvestNumber.floatValue];
        NSNumber * arrearsNumber = dic[@"arrears"];
        self.arrearsContentLabel.text = [[NSString alloc] initWithFormat:@"%.2f",arrearsNumber.floatValue];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805",@"MaintenanceContent":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"receivable":@"2400",@"cost":@"1000",@"profit":@"1400",@"content":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"receivable":@"2400.00",@"actualHarvest":@"1000.00",@"arrears":@"1400.00"}];
}
@end
