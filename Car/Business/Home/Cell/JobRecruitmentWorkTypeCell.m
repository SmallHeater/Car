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

//title,标题;wage,工资;workType,工作类型;tabs,标签数组;
-(void)showDic:(NSDictionary *)dic{
    
    NSString * title = @"";
    if ([dic.allKeys containsObject:@"title"]) {
        
        title = dic[@"title"];
    }
    self.titleLabel.text = title;
    
    NSString * wage = @"";
    if ([dic.allKeys containsObject:@"wage"]) {
        
        wage = dic[@"wage"];
    }
    self.wageLabel.text = wage;
    
    NSString * workType = @"";
    if ([dic.allKeys containsObject:@"workType"]) {
        
        workType = dic[@"workType"];
    }
    self.workTypeLabel.text = workType;
    
    NSArray * tabs = dic[@"tabs"];
    float labelX = 16;
    float labelHeight = 18;
    for (NSString * str in tabs) {
        
        float labelWidth = [str widthWithFont:FONT12 andHeight:labelHeight] + 10;
        UILabel * label = [[UILabel alloc] init];
        label.font = FONT12;
        label.textColor = Color_2E78FF;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = str;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 1;
        label.backgroundColor = [UIColor colorWithRed:0/255.0 green:121/255.0 blue:255/255.0 alpha:0.1];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(labelX);
            make.top.equalTo(self.wageLabel.mas_bottom).offset(13);
            make.width.offset(labelWidth);
            make.height.offset(labelHeight);
        }];
        labelX += labelWidth + 5;
    }
}

@end
