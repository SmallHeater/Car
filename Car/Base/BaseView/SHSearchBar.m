//
//  SHSearchBar.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHSearchBar.h"

@implementation SHSearchBar

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.placeholder = @"请输入需要搜索的内容";
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:0.29].CGColor;
    self.layer.shadowOffset = CGSizeMake(1,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.cornerRadius = 20;
    self.font = FONT14;
    
    
    self.leftViewMode = UITextFieldViewModeAlways;
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, 33 + 8, 17)];
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
    [leftView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.top.bottom.offset(0);
        make.right.offset(-8);
    }];
    self.leftView = leftView;
}

@end
