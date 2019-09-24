//
//  JobRecruitmentWorkTypeCell.m
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobRecruitmentWorkTypeCell.h"

@interface JobRecruitmentWorkTypeCell ()

//工种
@property (nonatomic,strong) UILabel * workTypeLabel;
@property (nonatomic,strong) UILabel * titleLabel;
//工资
@property (nonatomic,strong) UILabel * wageLabel;
@property (nonatomic,strong) UILabel * lineLabel;


@end

@implementation JobRecruitmentWorkTypeCell

#pragma mark  ----  懒加载

-(UILabel *)workTypeLabel{
    
    if (!_workTypeLabel) {
        
        _workTypeLabel = [[UILabel alloc] init];
        _workTypeLabel.font = FONT14;
        _workTypeLabel.textColor = Color_999999;
    }
    return _workTypeLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT18;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)wageLabel{
    
    if (!_wageLabel) {
        
        _wageLabel = [[UILabel alloc] init];
        _wageLabel.font = FONT16;
        _wageLabel.textColor = Color_FF594C;
    }
    return _wageLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
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
    
    [self addSubview:self.workTypeLabel];
    [self.workTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.offset(16);
        make.height.offset(20);
        make.right.offset(-16);
    }];
    
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.workTypeLabel.mas_left);
        make.top.equalTo(self.workTypeLabel.mas_bottom).offset(10);
        make.height.offset(28);
        make.right.offset(-16);
    }];
    
    [self addSubview:self.wageLabel];
    [self.wageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.workTypeLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.offset(28);
        make.right.offset(-16);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)test{
    
    self.workTypeLabel.backgroundColor = [UIColor greenColor];
    self.wageLabel.backgroundColor = [UIColor redColor];
    self.titleLabel.backgroundColor = [UIColor yellowColor];
}

@end
