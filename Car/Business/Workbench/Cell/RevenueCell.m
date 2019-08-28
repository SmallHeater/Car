//
//  RevenueCell.m
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RevenueCell.h"

@interface RevenueCell ()

@property (nonatomic,strong) UIView * bgView;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
//车主姓名
@property (nonatomic,strong) UILabel * nameLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
//联系电话
@property (nonatomic,strong) UILabel * phoneNumberLabel;

//应收
@property (nonatomic,strong) UILabel * receivableLabel;
//应收金额
@property (nonatomic,strong) UILabel * receivableContentLabel;
//成本
@property (nonatomic,strong) UILabel * costLabel;
//成本金额
@property (nonatomic,strong) UILabel * costContentLabel;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;
//利润
@property (nonatomic,strong) UILabel * profitLabel;
//利润金额
@property (nonatomic,strong) UILabel * profitContentLabel;

@end

@implementation RevenueCell

#pragma mark  ----  懒加载

-(UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,2);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 10;
        _bgView.layer.cornerRadius = 13;

        
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
        
        [_bgView addSubview:self.receivableLabel];
        [self.receivableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.carModelLabel.mas_bottom).offset(35);
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
        [_bgView addSubview:self.costLabel];
        [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.equalTo(self.receivableLabel.mas_bottom).offset(17);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.costContentLabel];
        [self.costContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-17);
            make.top.equalTo(self.costLabel.mas_top);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.right.offset(-16);
            make.height.offset(1);
            make.top.equalTo(self.costLabel.mas_bottom).offset(15);
        }];
        [_bgView addSubview:self.profitLabel];
        [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.lineLabel.mas_bottom).offset(16);
            make.width.offset(100);
            make.height.offset(16);
        }];
        [_bgView addSubview:self.profitContentLabel];
        [self.profitContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-17);
            make.top.equalTo(self.profitLabel.mas_top);
            make.width.offset(100);
            make.height.offset(16);
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

-(UILabel *)costLabel{
    
    if (!_costLabel) {
        
        _costLabel = [[UILabel alloc] init];
        _costLabel.font = FONT16;
        _costLabel.textColor = Color_333333;
        _costLabel.text = @"成本";
    }
    return _costLabel;
}

-(UILabel *)costContentLabel{
    
    if (!_costContentLabel) {
        
        _costContentLabel = [[UILabel alloc] init];
        _costContentLabel.font = FONT16;
        _costContentLabel.textColor = Color_333333;
        _costContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _costContentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DEDEDE;
    }
    return _lineLabel;
}

-(UILabel *)profitLabel{
    
    if (!_profitLabel) {
        
        _profitLabel = [[UILabel alloc] init];
        _profitLabel.font = FONT16;
        _profitLabel.textColor = Color_E1534A;
        _profitLabel.text = @"利润";
    }
    return _profitLabel;
}

-(UILabel *)profitContentLabel{
    
    if (!_profitContentLabel) {
        
        _profitContentLabel = [[UILabel alloc] init];
        _profitContentLabel.font = FONT16;
        _profitContentLabel.textColor = Color_E1534A;
        _profitContentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _profitContentLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(16);
        make.bottom.offset(0);
    }];
}

-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
        self.receivableContentLabel.text = dic[@"receivable"];
        self.costContentLabel.text = dic[@"cost"];
        self.profitContentLabel.text = dic[@"profit"];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805",@"MaintenanceContent":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"receivable":@"2400",@"cost":@"1000",@"profit":@"1400"}];
}

@end
