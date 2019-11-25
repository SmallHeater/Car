//
//  AutoRepairShopCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AutoRepairShopCell.h"

@interface AutoRepairShopCell ()

@property (nonatomic,strong) UILabel * autoRepairShopNameLabel;

@end

@implementation AutoRepairShopCell

#pragma mark  ----  懒加载

-(UILabel *)autoRepairShopNameLabel{
    
    if (!_autoRepairShopNameLabel) {
        
        _autoRepairShopNameLabel = [[UILabel alloc] init];
        _autoRepairShopNameLabel.font = BOLDFONT18;
        _autoRepairShopNameLabel.textColor = Color_333333;
    }
    return _autoRepairShopNameLabel;
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
    
    [self addSubview:self.autoRepairShopNameLabel];
    [self.autoRepairShopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(0);
        make.height.offset(18);
        make.bottom.offset(0);
    }];
}

-(void)showAutoRepairShopName:(NSString *)name{
    
    self.autoRepairShopNameLabel.text = [NSString repleaseNilOrNull:name];;
}

@end
