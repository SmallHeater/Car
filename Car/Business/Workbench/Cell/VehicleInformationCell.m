//
//  VehicleInformationCell.m
//  Car
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleInformationCell.h"

@interface VehicleInformationCell ()

//标题
@property (nonatomic,strong) UILabel * titleLabel;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
@property (nonatomic,strong) UILabel * firstLineLabel;
//车架号
@property (nonatomic,strong) UILabel * frameNumberLabel;
@property (nonatomic,strong) UILabel * secondLineLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
@property (nonatomic,strong) UILabel * thirdLineLabel;
//发动机号
@property (nonatomic,strong) UILabel * engineNumberLabel;

@end

@implementation VehicleInformationCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = Color_F3F3F3;
        _titleLabel.text = @"  车辆信息";
        _titleLabel.font = FONT14;
        _titleLabel.textColor = Color_999999;
    }
    return _titleLabel;
}

-(UILabel *)numberPlateLabel{
    
    if (!_numberPlateLabel) {
        
        _numberPlateLabel = [[UILabel alloc] init];
        _numberPlateLabel.font = FONT16;
    }
    return _numberPlateLabel;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)frameNumberLabel{
    
    if (!_frameNumberLabel) {
        
        _frameNumberLabel = [[UILabel alloc] init];
        _frameNumberLabel.font = FONT16;
    }
    return _frameNumberLabel;
}

-(UILabel *)secondLineLabel{
    
    if (!_secondLineLabel) {
        
        _secondLineLabel = [[UILabel alloc] init];
        _secondLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _secondLineLabel;
}

-(UILabel *)carModelLabel{
    
    if (!_carModelLabel) {
        
        _carModelLabel = [[UILabel alloc] init];
        _carModelLabel.font = FONT16;
    }
    return _carModelLabel;
}

-(UILabel *)thirdLineLabel{
    
    if (!_thirdLineLabel) {
        
        _thirdLineLabel = [[UILabel alloc] init];
        _thirdLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _thirdLineLabel;
}

-(UILabel *)engineNumberLabel{
    
    if (!_engineNumberLabel) {
        
        _engineNumberLabel = [[UILabel alloc] init];
        _engineNumberLabel.font = FONT16;
    }
    return _engineNumberLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(42);
    }];
    
    [self addSubview:self.numberPlateLabel];
    [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(19);
        make.right.offset(0);
        make.height.offset(16);
    }];
    
    [self addSubview:self.firstLineLabel];
    [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.frameNumberLabel];
    [self.frameNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(33);
        make.top.equalTo(self.firstLineLabel.mas_bottom).offset(19);
        make.right.offset(0);
        make.height.offset(16);
    }];
    
    [self addSubview:self.secondLineLabel];
    [self.secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.frameNumberLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.carModelLabel];
    [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(33);
        make.top.equalTo(self.secondLineLabel.mas_bottom).offset(19);
        make.right.offset(0);
        make.height.offset(16);
    }];
    
    [self addSubview:self.thirdLineLabel];
    [self.thirdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.carModelLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.engineNumberLabel];
    [self.engineNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(18);
        make.top.equalTo(self.thirdLineLabel.mas_bottom).offset(19);
        make.right.offset(0);
        make.height.offset(16);
    }];
}

-(void)showData:(NSDictionary *)dic{
    
    NSString * numberPlate = dic[@"numberPlate"];
    NSString * showNumberPlate = [[NSString alloc] initWithFormat:@"车牌号   %@",numberPlate];
    NSMutableAttributedString * showNumberPlateAttStr = [[NSMutableAttributedString alloc] initWithString:showNumberPlate];
    [showNumberPlateAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showNumberPlateAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, numberPlate.length)];
    self.numberPlateLabel.attributedText = showNumberPlateAttStr;
    
    NSString * frameNumber = dic[@"frameNumber"];
    NSString * showFrameNumber = [[NSString alloc] initWithFormat:@"车架号   %@",frameNumber];
    NSMutableAttributedString * showFrameNumberAttStr = [[NSMutableAttributedString alloc] initWithString:showFrameNumber];
    [showFrameNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showFrameNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, frameNumber.length)];
    self.frameNumberLabel.attributedText = showFrameNumberAttStr;
    
    NSString * carModel = dic[@"carModel"];
    NSString * showCarModel = [[NSString alloc] initWithFormat:@"车型号   %@",carModel];
    NSMutableAttributedString * showCarModelAttStr = [[NSMutableAttributedString alloc] initWithString:showCarModel];
    [showCarModelAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 3)];
    [showCarModelAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(3, carModel.length)];
    self.carModelLabel.attributedText = showCarModelAttStr;
    
    NSString * engineNumber = dic[@"engineNumber"];
    NSString * showEngineNumber = [[NSString alloc] initWithFormat:@"发动机号   %@",engineNumber];
    NSMutableAttributedString * showEngineNumberAttStr = [[NSMutableAttributedString alloc] initWithString:showEngineNumber];
    [showEngineNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_666666} range:NSMakeRange(0, 4)];
    [showEngineNumberAttStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(4, engineNumber.length)];
    self.engineNumberLabel.attributedText = showEngineNumberAttStr;
}

-(void)test{
    
    [self showData:@{@"numberPlate":@"粤A7985D",@"frameNumber":@"WP1AB2959GL065973",@"carModel":@"奥德赛牌HG6481BBAN",@"engineNumber":@"AF9K54605"}];
}

@end
