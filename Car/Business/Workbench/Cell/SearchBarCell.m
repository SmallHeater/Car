//
//  SearchBarCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SearchBarCell.h"
#import "SHSearchTF.h"


@interface SearchBarCell ()<UITextFieldDelegate>

@property (nonatomic,strong) SHSearchTF * searchTF;

@end

@implementation SearchBarCell

#pragma mark  ----  懒加载

-(SHSearchTF *)searchTF{
    
    if (!_searchTF) {
        
        _searchTF = [[SHSearchTF alloc] initWithRightImageName:@"xiangji"];
        _searchTF.delegate = self;
        _searchTF.placeholder = @"请输入要搜索的车牌号";
        __weak typeof(self) weakSelf = self;
        _searchTF.rightViewCallback = ^{
          
            [weakSelf scanning];
        };
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
