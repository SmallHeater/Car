//
//  SHTabView.m
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHTabView.h"

#define BTNBASETAG 1000

@interface SHTabView ()

@property (nonatomic,strong) UIScrollView * bgScrollView;
//右侧点击滑动出页签项按钮
@property (nonatomic,strong) UIButton * moreBtn;
@property (nonatomic,strong) NSMutableArray<SHTabModel *> * modelArray;
@property (nonatomic,strong) NSMutableArray<UIButton *> * btnArray;
//选中的label
@property (nonatomic,strong) UILabel * selectedLabel;

@end

@implementation SHTabView

#pragma mark  ----  懒加载

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bgScrollView;
}

-(UIButton *)moreBtn{
    
    if (!_moreBtn) {
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            weakSelf.bgScrollView.contentOffset = CGPointMake(weakSelf.bgScrollView.contentSize.width - weakSelf.bgScrollView.frame.size.width, 0);
        }];
    }
    return _moreBtn;
}

-(NSMutableArray<SHTabModel *> *)modelArray{
    
    if (!_modelArray) {
        
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}

-(NSMutableArray<UIButton *> *)btnArray{
    
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

-(UILabel *)selectedLabel{
    
    if (!_selectedLabel) {
        
        _selectedLabel = [[UILabel alloc] init];
        _selectedLabel.backgroundColor = Color_0072FF;
        _selectedLabel.layer.cornerRadius = 2;
        _selectedLabel.layer.masksToBounds = YES;
    }
    return _selectedLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithItemsArray:(NSArray<SHTabModel *> *)itemsArray{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
        if (itemsArray && [itemsArray isKindOfClass:[NSArray class]] && itemsArray.count > 0) {
            
            [self.modelArray addObjectsFromArray:itemsArray];
            [self createItems];
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
        make.right.equalTo(self.moreBtn.mas_left).offset(0);
    }];
}

-(void)createItems{
    
    float btnX = 0;
    float scrollViewSizeWidth = 0;
    for (NSUInteger i = 0; i < self.modelArray.count; i++) {
        
        SHTabModel * model = self.modelArray[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = BTNBASETAG + i;
        [btn setTitle:model.tabTitle forState:UIControlStateNormal];
        btn.titleLabel.font = model.normalFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:model.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:model.selectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(btnX);
            make.top.bottom.offset(0);
            make.width.offset(model.btnMaxWidth);
        }];
        [self.btnArray addObject:btn];
        btnX += model.btnMaxWidth;
        if (i == 0) {
            
            btn.selected = YES;
            btn.titleLabel.font = model.selectedFont;
            [self.bgScrollView addSubview:self.selectedLabel];
            [self layoutIfNeeded];
            
            [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.offset(0);
                make.width.offset(10);
                make.height.offset(4);
                make.centerX.equalTo(btn.mas_centerX);
            }];
        }
        scrollViewSizeWidth += model.btnMaxWidth;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        self.bgScrollView.contentSize = CGSizeMake(scrollViewSizeWidth, CGRectGetHeight(self.frame));
    });
}

//设置对应的索引按钮选中
-(void)selectItemWithIndex:(NSUInteger)index{
    
    if (index < self.btnArray.count) {
     
        UIButton * btn = self.btnArray[index];
        [self btnClicked:btn];
    }
}

-(void)btnClicked:(UIButton *)btn{
    
    for (NSUInteger i = 0; i < self.btnArray.count; i++) {
        
        UIButton * tempBtn = self.btnArray[i];
        if (tempBtn.isSelected) {
            
            tempBtn.selected = NO;
            SHTabModel * tabModel = self.modelArray[i];
            tempBtn.titleLabel.font = tabModel.normalFont;
            break;
        }
    }
    
    
    btn.selected = YES;
    [self.selectedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(0);
        make.width.offset(10);
        make.height.offset(4);
        make.centerX.equalTo(btn.mas_centerX);
    }];
    
    SHTabModel * tabModel = self.modelArray[btn.tag - BTNBASETAG];
    btn.titleLabel.font = tabModel.selectedFont;
}

@end
