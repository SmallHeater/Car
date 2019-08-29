//
//  MaintenanceLogCell.m
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MaintenanceLogCell.h"

@interface MaintenanceLogCell ()

@property (nonatomic,strong) UILabel * titleLabel;
//维修日期
@property (nonatomic,strong) UILabel * repairDateLabel;
@property (nonatomic,strong) UITextField * repairDateTF;
@property (nonatomic,strong) UILabel * firstLineLabel;
//公里数
@property (nonatomic,strong) UILabel * kilometersLabel;
@property (nonatomic,strong) UITextField * kilometersTF;
@property (nonatomic,strong) UILabel * secondLineLabel;
//关联项目
@property (nonatomic,strong) UILabel * associatedProjectLabel;
@property (nonatomic,strong) UITextField * associatedProjectTF;
@property (nonatomic,strong) UILabel * thirdLineLabel;
//总费用
@property (nonatomic,strong) UILabel * totalCostLabel;
//应收
@property (nonatomic,strong) UILabel * acceptableLabel;
@property (nonatomic,strong) UITextField * acceptableTF;
//实收
@property (nonatomic,strong) UILabel * receivedLabel;
@property (nonatomic,strong) UITextField * receivedTF;
//成本
@property (nonatomic,strong) UILabel * costLabel;
@property (nonatomic,strong) UITextField * costTF;

@end

@implementation MaintenanceLogCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT17;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"维修日志";
    }
    return _titleLabel;
}

-(UILabel *)repairDateLabel{
    
    if (!_repairDateLabel) {
        
        _repairDateLabel = [[UILabel alloc] init];
        _repairDateLabel.font = FONT16;
        _repairDateLabel.textColor = Color_666666;
        _repairDateLabel.textAlignment = NSTextAlignmentRight;
        _repairDateLabel.text = @"维修日期";
    }
    return _repairDateLabel;
}

-(UITextField *)repairDateTF{
    
    if (!_repairDateTF) {
        
        _repairDateTF = [[UITextField alloc] init];
        _repairDateTF.font = FONT16;
        _repairDateTF.textColor = Color_333333;
        _repairDateTF.placeholder = @"请选择维修日期";
    }
    return _repairDateTF;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)kilometersLabel{
    
    if (!_kilometersLabel) {
        
        _kilometersLabel = [[UILabel alloc] init];
        _kilometersLabel.font = FONT16;
        _kilometersLabel.textColor = Color_666666;
        _kilometersLabel.textAlignment = NSTextAlignmentRight;
        _kilometersLabel.text = @"公里数";
    }
    return _kilometersLabel;
}

-(UITextField *)kilometersTF{
    
    if (!_kilometersTF) {
        
        _kilometersTF = [[UITextField alloc] init];
        _kilometersTF.font = FONT16;
        _kilometersTF.textColor = Color_333333;
        _kilometersTF.placeholder = @"请输入公里数";
    }
    return _kilometersTF;
}

-(UILabel *)secondLineLabel{
    
    if (!_secondLineLabel) {
        
        _secondLineLabel = [[UILabel alloc] init];
        _secondLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _secondLineLabel;
}

-(UILabel *)associatedProjectLabel{
    
    if (!_associatedProjectLabel) {
        
        _associatedProjectLabel = [[UILabel alloc] init];
        _associatedProjectLabel.font = FONT16;
        _associatedProjectLabel.textColor = Color_666666;
        _associatedProjectLabel.textAlignment = NSTextAlignmentRight;
        _associatedProjectLabel.text = @"关联项目";
    }
    return _associatedProjectLabel;
}

-(UITextField *)associatedProjectTF{
    
    if (!_associatedProjectTF) {
        
        _associatedProjectTF = [[UITextField alloc] init];
        _associatedProjectTF.font = FONT16;
        _associatedProjectTF.textColor = Color_333333;
        _associatedProjectTF.placeholder = @"请选择关联项目";
    }
    return _associatedProjectTF;
}

-(UILabel *)thirdLineLabel{
    
    if (!_thirdLineLabel) {
        
        _thirdLineLabel = [[UILabel alloc] init];
        _thirdLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _thirdLineLabel;
}

-(UILabel *)totalCostLabel{
    
    if (!_totalCostLabel) {
        
        _totalCostLabel = [[UILabel alloc] init];
        _totalCostLabel.font = FONT16;
        _totalCostLabel.textColor = Color_666666;
        _totalCostLabel.text = @"总费用";
    }
    return _totalCostLabel;
}

-(UILabel *)acceptableLabel{
    
    if (!_acceptableLabel) {
        
        _acceptableLabel = [[UILabel alloc] init];
        _acceptableLabel.textAlignment = NSTextAlignmentCenter;
        _acceptableLabel.font = FONT14;
        _acceptableLabel.textColor = Color_999999;
        _acceptableLabel.text = @"应收";
    }
    return _acceptableLabel;
}

-(UITextField *)acceptableTF{
    
    if (!_acceptableTF) {
        
        _acceptableTF = [[UITextField alloc] init];
        _acceptableTF.placeholder = @"请输入应收金额";
        _acceptableTF.textColor = Color_333333;
        _acceptableTF.font = FONT16;
        _acceptableTF.textAlignment = NSTextAlignmentCenter;
    }
    return _acceptableTF;
}

-(UILabel *)receivedLabel{
    
    if (!_receivedLabel) {
        
        _receivedLabel = [[UILabel alloc] init];
        _receivedLabel.textAlignment = NSTextAlignmentCenter;
        _receivedLabel.font = FONT14;
        _receivedLabel.textColor = Color_999999;
        _receivedLabel.text = @"实收";
    }
    return _receivedLabel;
}

-(UITextField *)receivedTF{
    
    if (!_receivedTF) {
        
        _receivedTF = [[UITextField alloc] init];
        _receivedTF.placeholder = @"请输入实收金额";
        _receivedTF.textColor = Color_333333;
        _receivedTF.font = FONT16;
        _receivedTF.textAlignment = NSTextAlignmentCenter;
    }
    return _receivedTF;
}

-(UILabel *)costLabel{
    
    if (!_costLabel) {
        
        _costLabel = [[UILabel alloc] init];
        _costLabel.textAlignment = NSTextAlignmentCenter;
        _costLabel.font = FONT14;
        _costLabel.textColor = Color_999999;
        _costLabel.text = @"成本";
    }
    return _acceptableLabel;
}

-(UITextField *)acceptableTF{
    
    if (!_acceptableTF) {
        
        _acceptableTF = [[UITextField alloc] init];
        _acceptableTF.placeholder = @"请输入应收金额";
        _acceptableTF.textColor = Color_333333;
        _acceptableTF.font = FONT16;
        _acceptableTF.textAlignment = NSTextAlignmentCenter;
    }
    return _acceptableTF;
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
    
    return 26 + 16 + 36 + (16 + 18 + 1) * 3 + 18 * 2;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.offset(26);
        make.width.offset(100);
        make.height.offset(17);
    }];
    
    [self addSubview:self.repairDateLabel];
    [self.repairDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(36);
        make.height.offset(16);
    }];
    
    [self addSubview:self.repairDateTF];
    [self.repairDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.repairDateLabel.mas_right).offset(26);
        make.top.equalTo(self.repairDateLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.repairDateLabel.mas_height);
    }];
    
    [self addSubview:self.firstLineLabel];
    [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.repairDateLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.kilometersLabel];
    [self.kilometersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.firstLineLabel.mas_bottom).offset(18);
        make.height.offset(16);
    }];
    
    [self addSubview:self.kilometersTF];
    [self.kilometersTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.kilometersLabel.mas_right).offset(26);
        make.top.equalTo(self.kilometersLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.kilometersLabel.mas_height);
    }];
    
    [self addSubview:self.secondLineLabel];
    [self.secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.kilometersLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.associatedProjectLabel];
    [self.associatedProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.secondLineLabel.mas_bottom).offset(18);
        make.height.offset(16);
    }];
    
    [self addSubview:self.associatedProjectTF];
    [self.associatedProjectTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.associatedProjectLabel.mas_right).offset(26);
        make.top.equalTo(self.associatedProjectLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.associatedProjectLabel.mas_height);
    }];
    
    [self addSubview:self.thirdLineLabel];
    [self.thirdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.associatedProjectLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.totalCostLabel];
    [self.totalCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.equalTo(self.thirdLineLabel.mas_bottom).offset(21);
        make.width.offset(100);
        make.height.offset(16);
    }];
    
    float triangulationWidth = MAINWIDTH / 3.0;
    
    [self addSubview:self.acceptableLabel];
    [self.acceptableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.equalTo(self.totalCostLabel.mas_bottom).offset(25);
        make.width.offset(triangulationWidth);
        make.height.offset(14);
    }];
    
    [self addSubview:self.acceptableTF];
    [self.acceptableTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.acceptableLabel.mas_left);
        make.top.equalTo(self.acceptableLabel.mas_bottom).offset(17);
        make.width.equalTo(self.acceptableLabel.mas_width);
        make.height.offset(16);
    }];
}

-(void)showData:(NSDictionary *)dic{
    
    self.repairDateTF.text = dic[@"repairDate"];
    self.kilometersTF.text = dic[@"kilometers"];
    self.associatedProjectTF.text = dic[@"associatedProject"];
}

-(void)test{
    
    [self showData:@{@"repairDate":@"2019-08-14",@"kilometers":@"52365公里",@"associatedProject":@"保养"}];
}

@end
