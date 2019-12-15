//
//  UnpaidCell.m
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "NotRemindedCell.h"

@interface NotRemindedCell ()

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
//上次保养时间
@property (nonatomic,strong) UILabel * lastMaintenanceTimeTitleLabel;
@property (nonatomic,strong) UILabel * lastMaintenanceTimeContentLabel;
//上次维修内容
@property (nonatomic,strong) UILabel * lastMaintenanceContentTitleLabel;
@property (nonatomic,strong) UILabel * lastMaintenanceContentLabel;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;
//发送保养提醒标题
@property (nonatomic,strong) UILabel * sendMessageLabel;
//发送保养提醒按钮
@property (nonatomic,strong) UIButton * sendMessageBtn;

@end

@implementation NotRemindedCell

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
        
        [_bgView addSubview:self.lastMaintenanceTimeTitleLabel];
        [self.lastMaintenanceTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.dottedLineImageView.mas_bottom).offset(15);
            make.width.offset(112);
            make.height.offset(22);
        }];
        
        [_bgView addSubview:self.lastMaintenanceTimeContentLabel];
        [self.lastMaintenanceTimeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-16);
            make.top.equalTo(self.lastMaintenanceTimeTitleLabel.mas_top).offset(0);
            make.width.offset(150);
            make.height.offset(22);
        }];
        
        [_bgView addSubview:self.lastMaintenanceContentTitleLabel];
        [self.lastMaintenanceContentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.lastMaintenanceTimeTitleLabel.mas_bottom).offset(15);
            make.width.offset(112);
            make.height.offset(22);
        }];
        
        [_bgView addSubview:self.lastMaintenanceContentLabel];
        [self.lastMaintenanceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-16);
            make.top.equalTo(self.lastMaintenanceContentTitleLabel.mas_top).offset(3);
            make.left.equalTo(self.lastMaintenanceContentTitleLabel.mas_right).offset(15);
            make.height.offset(36);
        }];
        
        [_bgView addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(191);
            make.height.offset(1);
        }];
        
        [_bgView addSubview:self.sendMessageLabel];
        [self.sendMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.lineLabel.mas_bottom).offset(17);
            make.width.offset(120);
            make.height.offset(22);
        }];
        
        [_bgView addSubview:self.sendMessageBtn];
        [self.sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-16);
            make.bottom.offset(-18);
            make.width.offset(52);
            make.height.offset(27);
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

-(UILabel *)lastMaintenanceTimeTitleLabel{
    
    if (!_lastMaintenanceTimeTitleLabel) {
        
        _lastMaintenanceTimeTitleLabel = [[UILabel alloc] init];
        _lastMaintenanceTimeTitleLabel.font = FONT16;
        _lastMaintenanceTimeTitleLabel.textColor = Color_484848;
        _lastMaintenanceTimeTitleLabel.text = @"上次保养时间";
    }
    return _lastMaintenanceTimeTitleLabel;
}

-(UILabel *)lastMaintenanceTimeContentLabel{
    
    if (!_lastMaintenanceTimeContentLabel) {
        
        _lastMaintenanceTimeContentLabel = [[UILabel alloc] init];
        _lastMaintenanceTimeContentLabel.font = FONT14;
        _lastMaintenanceTimeContentLabel.textColor = Color_444444;
        _lastMaintenanceTimeContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _lastMaintenanceTimeContentLabel;
}

-(UILabel *)lastMaintenanceContentTitleLabel{
    
    if (!_lastMaintenanceContentTitleLabel) {
        
        _lastMaintenanceContentTitleLabel = [[UILabel alloc] init];
        _lastMaintenanceContentTitleLabel.font = FONT16;
        _lastMaintenanceContentTitleLabel.textColor = Color_484848;
        _lastMaintenanceContentTitleLabel.text = @"上次维修内容";
    }
    return _lastMaintenanceContentTitleLabel;
}

-(UILabel *)lastMaintenanceContentLabel{
    
    if (!_lastMaintenanceContentLabel) {
        
        _lastMaintenanceContentLabel = [[UILabel alloc] init];
        _lastMaintenanceContentLabel.font = FONT14;
        _lastMaintenanceContentLabel.textColor = Color_444444;
        _lastMaintenanceContentLabel.numberOfLines = 0;
    }
    return _lastMaintenanceContentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.font = FONT14;
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
}

-(UILabel *)sendMessageLabel{
    
    if (!_sendMessageLabel) {
        
        _sendMessageLabel = [[UILabel alloc] init];
        _sendMessageLabel.font = FONT16;
        _sendMessageLabel.textColor = Color_484848;
        _sendMessageLabel.text = @"发送保养提醒";
    }
    return _sendMessageLabel;
}

-(UIButton *)sendMessageBtn{
    
    if (!_sendMessageBtn) {
        
        _sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendMessageBtn.backgroundColor = Color_0272FF;
        [_sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendMessageBtn.titleLabel.font = FONT14;
        _sendMessageBtn.layer.cornerRadius = 6;
        [_sendMessageBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendMessageBtn addTarget:self action:@selector(payBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMessageBtn;
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
    
    return 252 + 15;
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
        self.lastMaintenanceTimeContentLabel.text = dic[@"lastMaintenanceTime"];
        NSString * content = dic[@"lastMaintenanceContent"];
        float height = [content heightWithFont:FONT14 andWidth:MAINWIDTH - 192];
        [self.lastMaintenanceContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.right.offset(-16);
            make.top.equalTo(self.lastMaintenanceContentTitleLabel.mas_top).offset(3);
            make.left.equalTo(self.lastMaintenanceContentTitleLabel.mas_right).offset(15);
            make.height.offset(height);
        }];
        self.lastMaintenanceContentLabel.text = content;
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
        self.lastMaintenanceTimeContentLabel.text = @"";
        self.lastMaintenanceContentLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805",@"lastMaintenanceContent":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"lastMaintenanceTime":@"2019.09.06"}];
}
@end
