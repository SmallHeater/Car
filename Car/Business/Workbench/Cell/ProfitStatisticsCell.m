//
//  ProfitStatisticsCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ProfitStatisticsCell.h"
#import "SHMultipleSwitchingItemsView.h"


@interface ProfitStatisticsCell ()

//头部切换view
@property (nonatomic,strong) SHMultipleSwitchingItemsView * itemsView;

@end

@implementation ProfitStatisticsCell

#pragma mark  ----  懒加载

-(SHMultipleSwitchingItemsView *)itemsView{
    
    if (!_itemsView) {
        
        _itemsView = [[SHMultipleSwitchingItemsView alloc] initWithItemsArray:@[@{@"normalTitleColor":Color_333333,@"selectedTitleColor":Color_0272FF,@"normalTitle":@"今日",@"normalFont":FONT16},@{@"normalTitleColor":Color_333333,@"selectedTitleColor":Color_0272FF,@"normalTitle":@"昨日",@"normalFont":FONT16}]];
    }
    return _itemsView;
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
    
    [self addSubview:self.itemsView];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
}

-(void)test{
    
}

@end
