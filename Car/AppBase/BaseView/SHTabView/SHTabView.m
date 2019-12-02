//
//  SHTabView.m
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHTabView.h"

@interface SHTabView ()

@property (nonatomic,assign) BOOL isShowRightBtn;

@property (nonatomic,strong) UIScrollView * bgScrollView;
//右侧点击滑动出页签项按钮
@property (nonatomic,strong) UIButton * moreBtn;
@property (nonatomic,strong) NSMutableArray<SHTabModel *> * modelArray;
@property (nonatomic,strong) NSMutableArray<UIButton *> * btnArray;
//选中的label
@property (nonatomic,strong) UILabel * selectedLabel;
@property (nonatomic,strong) SHTabSelectLineModel * lineModel;
@property (nonatomic,assign) BOOL isShowBottomLine;
@property (nonatomic,strong) UILabel * bottomLine;

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
        _selectedLabel.layer.cornerRadius = self.lineModel.lineCornerRadio;
        _selectedLabel.layer.masksToBounds = YES;
    }
    return _selectedLabel;
}

-(UILabel *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = Color_EEEEEE;
    }
    return _bottomLine;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithItemsArray:(NSArray<SHTabModel *> *)itemsArray showRightBtn:(BOOL)isShow andSHTabSelectLineModel:(SHTabSelectLineModel *)lineModel isShowBottomLine:(BOOL)isShowBottomLine{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.isShowRightBtn = isShow;
        self.lineModel = lineModel;
        self.isShowBottomLine = isShowBottomLine;
        [self drawUI];
        if (itemsArray && [itemsArray isKindOfClass:[NSArray class]] && itemsArray.count > 0) {
            
            [self.modelArray addObjectsFromArray:itemsArray];
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf createItems];
            });
        }
    }
    return self;
}


#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.moreBtn];
    if (self.isShowRightBtn) {
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-15);
            make.width.height.offset(22);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    else{
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(0);
            make.width.height.offset(0);
            make.top.offset(0);
        }];
    }
    
    
    [self addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.right.equalTo(self.moreBtn.mas_left);
    }];
    
    if (self.isShowBottomLine) {
        
        [self addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.offset(0);
            make.height.offset(1);
        }];
    }
}

-(void)createItems{
    
    float btnX = 0;
    float scrollViewSizeWidth = 0;
    for (NSUInteger i = 0; i < self.modelArray.count; i++) {
        
        SHTabModel * model = self.modelArray[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (model.tabTag > 0) {
        
            btn.tag = model.tabTag;
        }
        
        [btn setTitle:model.tabTitle forState:UIControlStateNormal];
        btn.titleLabel.font = model.normalFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:model.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:model.selectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:btn];
        float btnHeight = CGRectGetHeight(self.bgScrollView.frame);
        if (self.lineModel.isShowSelectedLine && self.lineModel.lineHeight > 0) {
            
            btnHeight = btnHeight - self.lineModel.lineHeight;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(btnX);
            make.top.offset(0);
            make.height.offset(btnHeight);
            make.width.offset(model.btnWidth);
        }];
        [self.btnArray addObject:btn];
        btnX += model.btnWidth;
        if (i == 0) {
            
            btn.selected = YES;
            btn.titleLabel.font = model.selectedFont;
            [self.bgScrollView addSubview:self.selectedLabel];
            float lineWidth = self.lineModel.lineWidth;
            float lineHeight = self.lineModel.lineHeight;
            [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(btn.mas_bottom).offset(0);
                make.width.offset(lineWidth);
                make.height.offset(lineHeight);
                make.centerX.equalTo(btn.mas_centerX);
            }];
        }
        scrollViewSizeWidth += model.btnWidth;
    }
    
    self.bgScrollView.contentSize = CGSizeMake(scrollViewSizeWidth, CGRectGetHeight(self.frame));
    [self.bgScrollView bringSubviewToFront:self.selectedLabel];
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
    
    if (btn.frame.origin.x + btn.frame.size.width - self.bgScrollView.contentOffset.x >= self.bgScrollView.frame.size.width - 22) {
        
        //选中的按钮在右侧显示不出来，需要移动scrollview
        self.bgScrollView.contentOffset = CGPointMake(btn.frame.origin.x + btn.frame.size.width - self.bgScrollView.frame.size.width + 22, 0);
    }
    else if (btn.frame.origin.x < self.bgScrollView.contentOffset.x){
        
        //选中的按钮在左侧显示不出来，需要移动scrollview
        self.bgScrollView.contentOffset = CGPointMake(btn.frame.origin.x, 0);
    }
    
    float lineWidth = self.lineModel.lineWidth;
    float lineHeight = self.lineModel.lineHeight;
    [self.selectedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(btn.mas_bottom).offset(0);
        make.width.offset(lineWidth);
        make.height.offset(lineHeight);
        make.centerX.equalTo(btn.mas_centerX);
    }];
    
    SHTabModel * tabModel;
    if (btn.tag > 0) {
        
        for (SHTabModel * model in self.modelArray) {
            
            if (model.tabTag == btn.tag) {
                
                tabModel = model;
                break;
            }
        }
    }
    btn.titleLabel.font = tabModel.selectedFont;
}

@end
