//
//  JobRecruitmenDescriptionCell.m
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobRecruitmenDescriptionCell.h"

@interface JobRecruitmenDescriptionCell ()

@property (nonatomic,strong) UILabel * titleLabel;
//要求
@property (nonatomic,strong) UILabel * claimLabel;
//工作经验要求
@property (nonatomic,strong) UILabel * workExperspaceLabel;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;
//学历要求
@property (nonatomic,strong) UILabel * acadeLabel;
//内容label
@property (nonatomic,strong) UILabel * contentLabel;

//底部灰条
@property (nonatomic,strong) UILabel * bottomLabel;

@end

@implementation JobRecruitmenDescriptionCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT18;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"职位描述";
    }
    return _titleLabel;
}

-(UILabel *)claimLabel{
    
    if (!_claimLabel) {
        
        _claimLabel = [[UILabel alloc] init];
        _claimLabel.layer.borderWidth = 1;
        _claimLabel.layer.borderColor = Color_FF594C.CGColor;
        _claimLabel.layer.cornerRadius = 4;
        _claimLabel.font = FONT12;
        _claimLabel.textColor = Color_FF594C;
        _claimLabel.text = @"要求";
        _claimLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _claimLabel;
}

-(UILabel *)workExperspaceLabel{
    
    if (!_workExperspaceLabel) {
        
        _workExperspaceLabel = [[UILabel alloc] init];
        _workExperspaceLabel.font = FONT12;
        _workExperspaceLabel.textColor = Color_333333;
        _workExperspaceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _workExperspaceLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_333333;
    }
    return _lineLabel;
}

-(UILabel *)acadeLabel{
    
    if (!_acadeLabel) {
        
        _acadeLabel = [[UILabel alloc] init];
        _acadeLabel.font = FONT12;
        _acadeLabel.textColor = Color_333333;
        _acadeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _acadeLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT14;
        _contentLabel.textColor = Color_333333;
    }
    return _contentLabel;
}

-(UILabel *)bottomLabel{
    
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomLabel;
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

+(float)cellHeightWithContent:(NSString *)content{
    
    float cellHeight = 0;
    NSString * usedContent = [NSString repleaseNilOrNull: content];
    float contentLabelWidth = MAINWIDTH - 16 * 2;
    float contentHeight = [usedContent heightWithFont:FONT14 andWidth:contentLabelWidth];
    cellHeight += contentHeight + 94 + 18;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.top.offset(16);
        make.height.offset(25);
        make.right.offset(-16);
    }];
    
    [self addSubview:self.claimLabel];
    [self.claimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.width.offset(30);
        make.height.offset(20);
    }];
    
    [self addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(8);
    }];
}

//工作经验要求，学历要求，内容
-(void)showWorkExperienceRequirements:(NSString *)workExper academicRequirements:(NSString *)acadeStr content:(NSString *)content{
    
    NSString * usedWorkExper = [NSString repleaseNilOrNull:workExper];
    float labelHeight = 17;
    float usedWorkExperWidth = [usedWorkExper widthWithFont:FONT12 andHeight:labelHeight];
    [self addSubview:self.workExperspaceLabel];
    self.workExperspaceLabel.text = usedWorkExper;
    [self.workExperspaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.claimLabel.mas_right).offset(10);
        make.width.offset(usedWorkExperWidth + 5);
        make.top.equalTo(self.claimLabel.mas_top).offset(2);
        make.height.offset(labelHeight);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.workExperspaceLabel.mas_right).offset(5);
        make.top.equalTo(self.workExperspaceLabel.mas_top);
        make.height.equalTo(self.workExperspaceLabel.mas_height);
        make.width.offset(1);
    }];
    
    NSString * usedAcadeStr = [NSString repleaseNilOrNull:acadeStr];
    float acadeStrWidth = [usedAcadeStr widthWithFont:FONT12 andHeight:labelHeight];
    [self addSubview:self.acadeLabel];
    self.acadeLabel.text = usedAcadeStr;
    [self.acadeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.lineLabel.mas_right).offset(5);
        make.top.equalTo(self.workExperspaceLabel.mas_top);
        make.width.offset(acadeStrWidth + 5);
        make.height.equalTo(self.workExperspaceLabel.mas_height);
    }];
    
    NSString * usedContent = [NSString repleaseNilOrNull: content];
    float contentLabelWidth = MAINWIDTH - 16 * 2;
    float contentHeight = [usedContent heightWithFont:FONT14 andWidth:contentLabelWidth];
    [self addSubview:self.contentLabel];
    self.contentLabel.text = usedContent;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-18);
        make.height.offset(contentHeight);
    }];
}

@end
