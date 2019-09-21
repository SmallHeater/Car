//
//  CommodityCell.m
//  Car
//
//  Created by mac on 2019/9/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommodityCell.h"

@interface CommodityCell ()

@property (nonatomic,strong) UIImageView * commodityImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UILabel * dateLabel;

@end

@implementation CommodityCell

#pragma mark  ----  懒加载

-(UIImageView *)commodityImageView{
    
    if (!_commodityImageView) {
        
        _commodityImageView = [[UIImageView alloc] init];
        _commodityImageView.backgroundColor = [UIColor clearColor];
    }
    return _commodityImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT14;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT12;
        _addressLabel.textColor = Color_999999;
    }
    return _addressLabel;
}

-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = BOLDFONT16;
        _priceLabel.textColor = Color_FF3B30;
    }
    return _priceLabel;
}

-(UILabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT12;
        _dateLabel.textColor = Color_333333;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
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
    
    [self addSubview:self.commodityImageView];
    [self.commodityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.offset(16);
        make.width.offset(100);
        make.height.offset(80);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.commodityImageView.mas_right).offset(16);
        make.top.equalTo(self.commodityImageView.mas_top);
        make.right.offset(-16);
        make.height.offset(36);
    }];
    
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.offset(58);
        make.right.offset(-16);
        make.height.offset(17);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.addressLabel.mas_left);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
        make.width.offset(100);
        make.height.offset(16);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-18);
        make.bottom.offset(-2);
        make.width.offset(100);
        make.height.offset(16);
    }];
}

-(void)test{
    
    self.commodityImageView.backgroundColor = [UIColor greenColor];
    self.titleLabel.text = @"这里是标题这里是标题单行显示";
    self.addressLabel.text = @"山东省济南市平阴县";
    self.priceLabel.text = @"价格面议";
    self.dateLabel.text = @"2019.09.01";
}

@end
