//
//  SHMultipleSwitchingItemsView.m
//  Car
//
//  Created by xianjun wang on 2019/9/1.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHMultipleSwitchingItemsView.h"
#import "SHMultipleSwitchingItemModel.h"


@interface SHMultipleSwitchingItemsView ()

//数据数组
@property (nonatomic,strong) NSMutableArray<SHMultipleSwitchingItemModel *> * itemsArray;

@end

@implementation SHMultipleSwitchingItemsView

#pragma mark  ----  懒加载

-(NSMutableArray<SHMultipleSwitchingItemModel *> *)itemsArray{
    
    if (!_itemsArray) {
        
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithItemsArray:(NSArray<NSDictionary *> *)itemsArray{
    
    self = [super init];
    if (self) {
        
        for (NSDictionary * dic in itemsArray) {
            
            SHMultipleSwitchingItemModel * itemModel = [SHMultipleSwitchingItemModel mj_objectWithKeyValues:dic];
            [self.itemsArray addObject:itemModel];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //需要在本view设置坐标完成后再设置按钮的坐标
            [self drawUI];
        });
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    //每个按钮的宽度
    float btnWidth = CGRectGetWidth(self.frame) / self.itemsArray.count;
    
    float btnX = 0;
    for (SHMultipleSwitchingItemModel * itemModel in self.itemsArray) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        if (itemModel.normalTitleColor) {
//
//            [btn setTitleColor:itemModel.normalTitleColor forState:UIControlStateNormal];
//        }
//        if (itemModel.selectedTitleColor) {
//
//            [btn setTitleColor:itemModel.selectedTitleColor forState:UIControlStateSelected];
//        }
        
        if (itemModel.normalTitle) {
            
            [btn setTitle:itemModel.normalTitle forState:UIControlStateNormal];
        }
        
        if (itemModel.selectedTitle) {
            
            [btn setTitle:itemModel.selectedTitle forState:UIControlStateSelected];
        }
        
        if (itemModel.normalFont) {

            btn.titleLabel.font = itemModel.normalFont;
        }
        
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(btnX);
            make.top.bottom.offset(0);
            make.width.offset(btnWidth);
        }];
        
        btnX += btnWidth;
    }
}

@end
