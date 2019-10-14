//
//  MotorOilMonopolyHeaderView.m
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyHeaderView.h"

@interface MotorOilMonopolyHeaderView ()

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIView * whiteView;
//门店名
@property (nonatomic,strong) UILabel * shopNameLabel;


@end

@implementation MotorOilMonopolyHeaderView

#pragma mark  ----  懒加载

-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)shopNameLabel{
    
    if (!_shopNameLabel) {
        
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = BOLDFONT18;
        _shopNameLabel.textColor = Color_333333;
    }
    return _shopNameLabel;
}

-(UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        [_whiteView addSubview:self.shopNameLabel];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(12);
            make.top.offset(0);
            make.height.offset(33);
            make.right.offset(-64);
        }];
        
    }
    return _whiteView;
}

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark  ----  自定义函数

/*
-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [UIScreenControl liuHaiHeight])];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView = [[UIImageView alloc] init];
        __weak typeof(self) weak = self;
        [[self rac_valuesForKeyPath:@"headImageUrlStr" observer:self] subscribeNext:^(id  _Nullable x) {
            
            if (![NSString strIsEmpty:weak.headImageUrlStr]) {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:weak.headImageUrlStr]];
            }
        }];
        [_tableHeaderView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.offset(0);
            make.height.offset(144);
        }];
        
        UIView * whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.cornerRadius = 4;
        whiteView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        whiteView.layer.shadowOffset = CGSizeMake(0,2);
        whiteView.layer.shadowOpacity = 1;
        whiteView.layer.shadowRadius = 10;
        [_tableHeaderView addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(9);
            make.right.offset(-9);
            make.bottom.offset(-8);
            make.height.offset(79);
        }];
    }
    return _tableHeaderView;
}
*/


@end
