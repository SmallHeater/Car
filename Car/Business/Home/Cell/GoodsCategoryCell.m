//
//  GoodsCategoryCell.m
//  Car
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "GoodsCategoryCell.h"

@interface GoodsCategoryCell ()

//选中条
@property (nonatomic,strong) UILabel * selectedLabel;
@property (nonatomic,strong) UILabel * titleLabel;
//数量
@property (nonatomic,strong) UILabel * countLabel;

@end

@implementation GoodsCategoryCell

#pragma mark  ----  懒加载

-(UILabel *)selectedLabel{
    
    if (!_selectedLabel) {
        
        _selectedLabel = [[UILabel alloc] init];
        _selectedLabel.backgroundColor = Color_0272FF;
    }
    return _selectedLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT10;
        _titleLabel.textColor = Color_333333;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.backgroundColor = Color_FF3B30;
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.layer.cornerRadius = 7;
        _countLabel.layer.masksToBounds = YES;
        _countLabel.font = FONT10;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = Color_F8F8F8;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  系统函数

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    if (selected) {
        
        self.selectedLabel.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    else{
        
        self.selectedLabel.hidden = YES;
        self.backgroundColor = Color_F8F8F8;
    }
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.selectedLabel];
    [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.width.offset(3);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(8);
        make.right.offset(-16);
        make.width.height.offset(14);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.equalTo(self.countLabel.mas_bottom);
        make.right.offset(0);
        make.height.offset(34);
    }];
}

-(void)show:(NSString *)title count:(NSUInteger)count{
    
    if (![NSString strIsEmpty:title] && title.length > 1) {
        
        NSMutableString * titleStr = [[NSMutableString alloc] initWithString:title];
        [titleStr insertString:@"\n" atIndex:2];
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        [attributedStr addAttributes:@{NSFontAttributeName:FONT10,NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(0, 2)];
        [attributedStr addAttributes:@{NSFontAttributeName:BOLDFONT12,NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(2, titleStr.length - 2)];
        self.titleLabel.attributedText = attributedStr;
    }
    else{
        
        self.titleLabel.text = [NSString repleaseNilOrNull:title];
    }
    
    self.countLabel.text = [[NSString alloc] initWithFormat:@"%ld",count];
}

@end
