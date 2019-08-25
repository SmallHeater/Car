//
//  SearchBarTwoCell.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SearchBarTwoCell.h"
#import "SHSearchBar.h"

@interface SearchBarTwoCell ()

@property (nonatomic,strong) SHSearchBar * searchBar;

@end


@implementation SearchBarTwoCell

#pragma mark  ----  懒加载

-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] init];
    }
    return _searchBar;
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
    
    [self addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-16);
        make.top.offset(20);
        make.height.offset(40);
    }];
}

@end
