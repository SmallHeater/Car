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
@property (nonatomic,strong) UILabel * firstLineLabel;
//公里数
@property (nonatomic,strong) UILabel * kilometersLabel;
@property (nonatomic,strong) UILabel * secondLineLabel;
//关联项目
@property (nonatomic,strong) UILabel * associatedProjectLabel;
@property (nonatomic,strong) UILabel * thirdLineLabel;


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
    }
    return _repairDateLabel;
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
    }
    return _kilometersLabel;
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
    }
    return _associatedProjectLabel;
}

-(UILabel *)thirdLineLabel{
    
    if (!_thirdLineLabel) {
        
        _thirdLineLabel = [[UILabel alloc] init];
        _thirdLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _thirdLineLabel;
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
    
    return 0;
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
    
    [self addSubview:self.thirdLineLabel];
    [self.thirdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.associatedProjectLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
}


@end
