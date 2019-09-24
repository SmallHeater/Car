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
        
        make.left.offset(16);
        make.top.offset(16);
        make.height.offset(25);
        make.right.offset(-16);
    }];
}


@end
