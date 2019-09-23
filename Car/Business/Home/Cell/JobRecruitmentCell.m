//
//  JobRecruitmentCell.m
//  Car
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "JobRecruitmentCell.h"

@interface JobRecruitmentCell ()

@property (nonatomic,strong) UILabel * titleLabel;
//推荐
@property (nonatomic,strong) UILabel * recommendLabel;
//工资
@property (nonatomic,strong) UILabel * wageLabel;
//工种
@property (nonatomic,strong) UIImageView * workTypeImageView;
@property (nonatomic,strong) UILabel * workTypeLabel;
//查看按钮
@property (nonatomic,strong) UIButton * lookBtn;
//虚线分割线
@property (nonatomic,strong) UIImageView * lineImageView;
//公司
@property (nonatomic,strong) UILabel *companyLabel;
//区域
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * bottomGrayLabel;

@end

@implementation JobRecruitmentCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT18;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)recommendLabel{
    
    if (!_recommendLabel) {
        
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.font = FONT14;
        _recommendLabel.textColor = Color_999999;
        _recommendLabel.textAlignment = NSTextAlignmentRight;
    }
    return _recommendLabel;
}

-(UILabel *)wageLabel{
    
    if (!_wageLabel) {
        
        _wageLabel = [[UILabel alloc] init];
        _wageLabel.font = FONT16;
        _wageLabel.textColor = Color_FF594C;
    }
    return _wageLabel;
}

-(UIImageView *)workTypeImageView{
    
    if (!_workTypeImageView) {
        
        _workTypeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _workTypeImageView;
}

-(UILabel *)workTypeLabel{
    
    if (!_workTypeLabel) {
        
        _workTypeLabel = [[UILabel alloc] init];
        _workTypeLabel.font = FONT14;
        _workTypeLabel.textColor = Color_999999;
    }
    return _workTypeLabel;
}

-(UIButton *)lookBtn{
    
    if (!_lookBtn) {
        
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookBtn.backgroundColor = Color_0272FF;
        [_lookBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lookBtn.titleLabel.font = FONT14;
    }
    return _lookBtn;
}

-(UIImageView *)lineImageView{
    
    if (!_lineImageView) {
        
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fengexian"]];
    }
    return _lineImageView;
}

-(UILabel *)companyLabel{
    
    if (!_companyLabel) {
        
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = FONT14;
        _companyLabel.textColor = Color_999999;
    }
    return _companyLabel;
}

-(UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT14;
        _addressLabel.textColor = Color_999999;
        _addressLabel.textAlignment = NSTextAlignmentRight;
    }
    return _addressLabel;
}

-(UILabel *)bottomGrayLabel{
    
    if (!_bottomGrayLabel) {
        
        _bottomGrayLabel = [[UILabel alloc] init];
        _bottomGrayLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomGrayLabel;
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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.offset(16);
        make.right.offset(-50);
        make.height.offset(25);
    }];
    
    [self addSubview:self.recommendLabel];
    [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.top.equalTo(self.titleLabel.mas_top);
        make.width.offset(35);
        make.height.offset(20);
    }];
    
    [self addSubview:self.wageLabel];
    [self.wageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.offset(23);
        make.width.offset(130);
    }];
    
    [self addSubview:self.workTypeImageView];
    [self.workTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.wageLabel.mas_right).offset(16);
        make.top.equalTo(self.wageLabel.mas_bottom).offset(3);
        make.width.height.offset(16);
    }];
    
    [self addSubview:self.workTypeLabel];
    [self.workTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.workTypeImageView.mas_right).offset(2);
        make.top.equalTo(self.wageLabel.mas_top);
        make.right.offset(-10);
        make.height.offset(20);
    }];
    
    [self addSubview:self.lookBtn];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.top.offset(72);
        make.width.offset(66);
        make.height.offset(32);
    }];
    
    [self addSubview:self.lineImageView];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-56);
        make.height.offset(1);
    }];
    
    [self addSubview:self.companyLabel];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.bottom.offset(-23);
        make.right.offset(-50);
        make.height.offset(20);
    }];
    
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(-23);
        make.width.offset(30);
        make.height.offset(20);
    }];
    
    [self addSubview:self.bottomGrayLabel];
    [self.bottomGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(8);
    }];
}

-(void)test{
    
    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.recommendLabel.backgroundColor = [UIColor yellowColor];
    self.wageLabel.backgroundColor = [UIColor redColor];
    self.workTypeLabel.backgroundColor = [UIColor greenColor];
    self.companyLabel.backgroundColor = [UIColor yellowColor];
    self.addressLabel.backgroundColor = [UIColor redColor];
}

@end
