//
//  VehicleFileForDetailVCCell.m
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleFileForDetailVCCell.h"

@interface VehicleFileForDetailVCCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * bgImageView;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
//车主姓名
@property (nonatomic,strong) UILabel * nameLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
//联系电话
@property (nonatomic,strong) UILabel * phoneNumberLabel;


@end

@implementation VehicleFileForDetailVCCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT17;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"车辆档案";
    }
    return _titleLabel;
}

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VehicleFileForDetailVCCellImage"]];
    }
    return _bgImageView;
}

-(UILabel *)numberPlateLabel{
    
    if (!_numberPlateLabel) {
        
        _numberPlateLabel = [[UILabel alloc] init];
        _numberPlateLabel.font = BOLDFONT20;
        _numberPlateLabel.textColor = [UIColor whiteColor];
//        _numberPlateLabel.backgroundColor = [UIColor greenColor];
    }
    return _numberPlateLabel;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = BOLDFONT16;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

-(UILabel *)carModelLabel{
    
    if (!_carModelLabel) {
        
        _carModelLabel = [[UILabel alloc] init];
        _carModelLabel.font = FONT14;
        _carModelLabel.textColor = [UIColor whiteColor];
//        _carModelLabel.backgroundColor = [UIColor greenColor];
    }
    return _carModelLabel;
}

-(UILabel *)phoneNumberLabel{
    
    if (!_phoneNumberLabel) {
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = FONT14;
        _phoneNumberLabel.textColor = [UIColor whiteColor];
        _phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _phoneNumberLabel;
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

+(float)cellHeight{
    
    return 61 + (MAINWIDTH - 16) / 359.0 * 103.0;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(18);
        make.top.offset(29);
        make.width.offset(100);
        make.height.offset(17);
    }];
    
    [self addSubview:self.bgImageView];
    float imageHeight = (MAINWIDTH - 16) / 359.0 * 103.0;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(8);
        make.right.offset(-8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.offset(imageHeight);
    }];
    
    [self.bgImageView addSubview:self.numberPlateLabel];
    [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(23);
        make.top.offset(26);
        make.width.offset(150);
        make.height.offset(20);
    }];
    
    [self.bgImageView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-27);
        make.top.offset(27);
        make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
        make.height.offset(16);
    }];
    
    [self.bgImageView addSubview:self.carModelLabel];
    [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(23);
        make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(17);
        make.width.offset(MAINWIDTH - 32 - 100 - 36);
        make.height.offset(14);
    }];
    
    [self addSubview:self.phoneNumberLabel];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
        make.right.offset(-36);
        make.height.offset(14);
    }];
}

-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805"}];
}

@end
