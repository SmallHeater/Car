//
//  SearchBarTwoCell.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SearchBarTwoCell.h"
#import "SHSearchTF.h"

@interface SearchBarTwoCell ()<UITextFieldDelegate>

@property (nonatomic,strong) SHSearchTF * searchBar;

@end


@implementation SearchBarTwoCell

#pragma mark  ----  懒加载

-(SHSearchTF *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchTF alloc] initWithRightImageName:@""];
        _searchBar.placeholder = @"请输入需要搜索的内容";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

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
    
    [self addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-16);
        make.top.offset(20);
        make.height.offset(40);
    }];
}

@end
