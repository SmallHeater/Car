//
//  SearchBarCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SearchBarCell.h"

@interface SearchBarCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField * searchTF;

@end

@implementation SearchBarCell

#pragma mark  ----  懒加载

-(UITextField *)searchTF{
    
    if (!_searchTF) {
        
        _searchTF = [[UITextField alloc] init];
        _searchTF.delegate = self;
        _searchTF.placeholder = @"请输入要搜索的车牌号";
        _searchTF.returnKeyType = UIReturnKeySearch;
        
        _searchTF.backgroundColor = [UIColor whiteColor];
        _searchTF.layer.shadowColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:0.29].CGColor;
        _searchTF.layer.shadowOffset = CGSizeMake(1,1);
        _searchTF.layer.shadowOpacity = 1;
        _searchTF.layer.shadowRadius = 5;
        _searchTF.layer.cornerRadius = 20;
        _searchTF.font = FONT14;
        
        
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, 33 + 8, 17)];
        UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
        [leftView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.bottom.offset(0);
            make.right.offset(-8);
        }];
        _searchTF.leftView = leftView;
        
        _searchTF.rightViewMode = UITextFieldViewModeAlways;
        UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 41)];
        rightView.userInteractionEnabled = YES;
        UIImageView * rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiangji"]];
        [rightView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(12);
            make.bottom.offset(-12);
            make.right.offset(-17);
            make.left.offset(0);
        }];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanning)];
        [rightView addGestureRecognizer:tap];
        
        _searchTF.rightView = rightView;
    }
    return _searchTF;
}


#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    if (self.searchCallBack) {
        
        self.searchCallBack(textField.text);
    }
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.searchTF];
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-16);
        make.top.offset(18);
        make.height.offset(40);
    }];
}

-(void)scanning{
    
    if (self.scanningCallBack) {
        
        self.scanningCallBack();
    }
}

@end
