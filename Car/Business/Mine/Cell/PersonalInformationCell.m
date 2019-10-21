//
//  PersonalInformationCell.m
//  Car
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PersonalInformationCell.h"

@interface PersonalInformationCell ()

@property (nonatomic,assign) CellType cellType;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * avaterImageView;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation PersonalInformationCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 21;
        _avaterImageView.layer.masksToBounds = YES;
    }
    return _avaterImageView;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT14;
        if (self.cellType == CellType_LabelAndLabelWarning) {
            
            _contentLabel.textColor = Color_F23E3E;
        }
        else{
            
            _contentLabel.textColor = Color_666666;
        }
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andCellType:(CellType)cellType{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellType = cellType;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.bottom.offset(0);
        make.width.offset(100);
    }];
    
    if (self.cellType == CellType_Avater) {
        
        [self addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(14);
            make.right.offset(-32);
            make.width.height.offset(42);
        }];
    }
    else if (self.cellType == CellType_LabelAndLabel || self.cellType == CellType_LabelAndLabelWarning || self.cellType == CellType_LabelAndLabelWithoutLine){
        
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-32);
            make.top.bottom.offset(0);
            make.width.offset(MAINWIDTH - 32 - 100);
        }];
    }
    else if (self.cellType == CellType_LabelAndLabelWithoutArrow || self.cellType == CellType_LabelAndLabelWithoutArrowLine){
        
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-16);
            make.top.bottom.offset(0);
            make.width.offset(MAINWIDTH - 16 - 100);
        }];
    }
    
    if (self.cellType == CellType_LabelAndLabelWithoutLine || self.cellType == CellType_LabelAndLabelWithoutArrowLine) {
    }
    else{
        
        [self addSubview:self.bottomLineLabel];
        [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.right.offset(-15);
            make.bottom.offset(0);
            make.height.offset(1);
        }];
    }
}

-(void)show:(NSString *)title andAvater:(NSString *)avater andContent:(NSString *)content{
    
    self.titleLabel.text = [NSString repleaseNilOrNull:title];
    [self.avaterImageView sd_setImageWithURL:[NSURL URLWithString:avater]];
    self.contentLabel.text = [NSString repleaseNilOrNull:content];
}

@end
