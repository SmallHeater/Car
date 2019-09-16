//
//  SHSearchTF.m
//  Car
//
//  Created by xianjun wang on 2019/9/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHSearchTF.h"

@interface SHSearchTF ()

@end

@implementation SHSearchTF

#pragma mark  ----  生命周期函数

-(instancetype)initWithRightImageName:(NSString *)rightImageName{
    
    self = [super init];
    if (self) {
        
        self.returnKeyType = UIReturnKeySearch;
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
        
        if (![NSString strIsEmpty:rightImageName]) {
         
            self.rightViewMode = UITextFieldViewModeAlways;
            UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 41)];
            rightView.userInteractionEnabled = YES;
            UIImageView * rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightImageName]];
            [rightView addSubview:rightImageView];
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.offset(12);
                make.bottom.offset(-12);
                make.right.offset(-17);
                make.left.offset(0);
            }];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanning)];
            [rightView addGestureRecognizer:tap];
            
            self.rightView = rightView;
        }
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)scanning{
    
    if (self.rightViewCallback) {
        
        self.rightViewCallback();
    }
}

@end
