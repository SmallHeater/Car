//
//  SHTabView.m
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHTabView.h"

@interface SHTabView ()

@property (nonatomic,strong) UIScrollView * bgScrollView;
//右侧点击滑动出页签项按钮
@property (nonatomic,strong) UIButton * moreBtn;


@end

@implementation SHTabView

#pragma mark  ----  懒加载

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithItemsArray:(NSArray<SHTabModel *> *)itemsArray{
    
    self = [super init];
    if (self) {
        
        if (itemsArray && [itemsArray isKindOfClass:[NSArray class]] && itemsArray.count > 0) {
            
            [self createItemsWithArr:itemsArray];
        }
    }
    return self;
}


#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-18);
        make.width.height.offset(22);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.right.equalTo(self.moreBtn.mas_left).offset(5);
    }];
}

-(void)createItemsWithArr:(NSArray<SHTabModel *> *)itemsArray{
    
    for (NSUInteger i = 0; i < itemsArray.count; i++) {
        
        SHTabModel * model = itemsArray[i];
        
    }
}


@end
