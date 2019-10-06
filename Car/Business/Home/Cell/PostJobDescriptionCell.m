//
//  PostJobDescriptionCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostJobDescriptionCell.h"
#import "SHTextView.h"


@interface PostJobDescriptionCell ()

@property (nonatomic,strong) SHTextView * descriptionTV;

@property (nonatomic,strong) NSString * descrip;

@end

@implementation PostJobDescriptionCell

#pragma mark  ----  懒加载

-(SHTextView *)descriptionTV{
    
    if (!_descriptionTV) {
        
        _descriptionTV = [[SHTextView alloc] init];
        _descriptionTV.placeholder = @"请输入职位描述";
        _descriptionTV.placeholderColor = Color_C7C7CD;
        _descriptionTV.textFont = FONT16;
        _descriptionTV.textColor = Color_333333;
        __weak typeof(self) weakSelf = self;
        _descriptionTV.block = ^(NSString *str) {
            
            weakSelf.descrip = str;
        };
    }
    return _descriptionTV;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andShowBottomLine:(BOOL)isShow{
    
    self = [super initWithReuseIdentifier:reuseIdentifier andTitle:title andShowBottomLine:isShow];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.offset(25);
        make.width.offset(70);
        make.height.offset(16);
    }];
    
    [self addSubview:self.descriptionTV];
    [self.descriptionTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(104);
        make.top.offset(24);
        make.bottom.offset(-24);
        make.right.offset(-16);
    }];
}

@end
