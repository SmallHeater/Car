//
//  PostJobSelectCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobSelectCell.h"

@interface PostJobSelectCell ()

//选择cell
@property (nonatomic,strong) UILabel * selectLabel;

@end

@implementation PostJobSelectCell

#pragma mark  ----  懒加载

-(UILabel *)selectLabel{
    
    if (!_selectLabel) {
        
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font = FONT16;
        _selectLabel.textColor = Color_C7C7CD;
        _selectLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLabelTaped)];
        [_selectLabel addGestureRecognizer:tap];
    }
    return _selectLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andShowBottomLine:(BOOL)isShow{
    
    self = [super initWithReuseIdentifier:reuseIdentifier andTitle:title andShowBottomLine:isShow];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self drawUI];
        self.selectLabel.text = [NSString repleaseNilOrNull:placeholder];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.selectLabel];
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(104);
        make.top.bottom.offset(0);
        make.right.offset(-25);
    }];
}

-(void)selectLabelTaped{
    
}

-(void)refreshLabel:(NSString *)str{
    
    self.selectLabel.text = [NSString repleaseNilOrNull:str];
    self.selectLabel.textColor = Color_333333;
}

@end
