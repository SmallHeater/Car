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
@property (nonatomic,assign) float btnWidth;
//底部分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;
//选中的线
@property (nonatomic,strong) UILabel * selectedLabel;
@property (nonatomic,strong) NSMutableArray<UIButton *> * buttonArray;

@end

@implementation SHMultipleSwitchingItemsView

#pragma mark  ----  懒加载

-(NSMutableArray<SHMultipleSwitchingItemModel *> *)itemsArray{
    
    if (!_itemsArray) {
        
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLineLabel;
}

-(UILabel *)selectedLabel{
    
    if (!_selectedLabel) {
        
        _selectedLabel = [[UILabel alloc] init];
    }
    return _selectedLabel;
}

-(NSMutableArray<UIButton *> *)buttonArray{
    
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
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
    self.btnWidth = CGRectGetWidth(self.frame) / self.itemsArray.count;
    
    float btnX = 0;
    for (NSUInteger i = 0; i < self.itemsArray.count; i++) {
        
        SHMultipleSwitchingItemModel * itemModel = self.itemsArray[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (itemModel.normalTitleColor) {
            
            [btn setTitleColor:itemModel.normalTitleColor forState:UIControlStateNormal];
        }
        if (itemModel.selectedTitleColor) {
            
            [btn setTitleColor:itemModel.selectedTitleColor forState:UIControlStateSelected];
        }
        
        if (itemModel.normalTitle) {
            
            [btn setTitle:itemModel.normalTitle forState:UIControlStateNormal];
        }
        
        if (itemModel.selectedTitle) {
            
            [btn setTitle:itemModel.selectedTitle forState:UIControlStateSelected];
        }
        
        if (itemModel.normalFont) {
            
            btn.titleLabel.font = itemModel.normalFont;
        }
        
        if (itemModel.btnTag) {
            
            btn.tag = itemModel.btnTag.integerValue;
        }
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(btnX);
            make.top.bottom.offset(0);
            make.width.offset(self.btnWidth);
        }];
        
        btnX += self.btnWidth;

        if (i == 0) {
            
            btn.selected = YES;
            
            float labelWidth = [itemModel.normalTitle widthWithFont:itemModel.normalFont andHeight:CGRectGetHeight(self.frame)] + 2;
            
            [self addSubview:self.selectedLabel];
            self.selectedLabel.backgroundColor = itemModel.selectedTitleColor;
            [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.offset(labelWidth);
                make.height.offset(2);
                make.bottom.offset(-1);
                make.left.offset((self.btnWidth - labelWidth) / 2.0);
            }];
        }
        
        [self.buttonArray addObject:btn];
    }
   
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

-(void)btnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    for (UIButton * btn in self.buttonArray) {
        
        btn.selected = NO;
    }
    
    btn.selected = YES;
    
    float labelWidth = [btn.currentTitle widthWithFont:btn.titleLabel.font andHeight:CGRectGetHeight(self.frame)] + 2;
    [self.selectedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(labelWidth);
        make.height.offset(2);
        make.bottom.offset(-1);
        make.left.offset(CGRectGetMinX(btn.frame) + (self.btnWidth - labelWidth) / 2.0);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedWithBtnTag:)] && btn.tag) {
        
        [self.delegate selectedWithBtnTag:btn.tag];
    }
    
    btn.userInteractionEnabled = YES;
}

//设置按钮为选中
-(void)setBtnSelectedWithIndex:(NSUInteger)index{
    
    if (index < self.buttonArray.count) {
        
        UIButton * btn = self.buttonArray[index];
        [self btnClicked:btn];
    }
}

@end
