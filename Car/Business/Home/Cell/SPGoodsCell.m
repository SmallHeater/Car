//
//  GoodsCell.m
//  Car
//
//  Created by xianjun wang on 2019/10/15.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SPGoodsCell.h"

@interface SPGoodsCell ()

//图片
@property (nonatomic,strong) UIImageView * iconImageView;
//商品名
@property (nonatomic,strong) UILabel * goodsNameLabel;
//价格label
@property (nonatomic,strong) UILabel * priceLabel;
//减按钮
@property (nonatomic,strong) UIButton * subtractBtn;
//数量
@property (nonatomic,strong) UILabel * countLabel;
//加按钮
@property (nonatomic,strong) UIButton * addBtn;
//分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;
//存储标签label的数组
@property (nonatomic,strong) NSMutableArray<UILabel *> * labelArray;
//数据模型
@property (nonatomic,strong) OilGoodModel * model;

@end

@implementation SPGoodsCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _iconImageView;
}

-(UILabel *)goodsNameLabel{
    
    if (!_goodsNameLabel) {
        
        _goodsNameLabel = [[UILabel alloc] init];
        _goodsNameLabel.font = BOLDFONT16;
        _goodsNameLabel.textColor = Color_333333;
        _goodsNameLabel.numberOfLines = 0;
    }
    return _goodsNameLabel;
}

-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = Color_FF4C4B;
        _priceLabel.font = FONT9;
    }
    return _priceLabel;
}

-(UIButton *)subtractBtn{
    
    if (!_subtractBtn) {
        
        _subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subtractBtn setImage:[UIImage imageNamed:@"jiyoujian"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_subtractBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.userInteractionEnabled = NO;
            if (weakSelf.model.count > 0) {
             
                weakSelf.model.count--;
                weakSelf.countLabel.text = weakSelf.model.countStr;
                if (weakSelf.model.count == 0) {
                    
                    //减到0
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"OILCOUNTZERO" object:nil];
                }
            }
            x.userInteractionEnabled = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GOODSVARIETY" object:nil];
        }];
    }
    return _subtractBtn;
}

-(UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = FONT14;
        _countLabel.textColor = Color_2E78FF;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"jiyoujia"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            weakSelf.model.count++;
            weakSelf.countLabel.text = weakSelf.model.countStr;
            x.userInteractionEnabled = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GOODSVARIETY" object:nil];
        }];
    }
    return _addBtn;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLineLabel;
}

-(NSMutableArray<UILabel *> *)labelArray{
    
    if (!_labelArray) {
        
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(10);
        make.width.offset(70);
        make.height.offset(93);
    }];
    
    [self addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.offset(-16);
        make.height.offset(18);
    }];
    
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(-7);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.addBtn.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.height.offset(20);
        make.width.offset(30);
    }];
    
    [self addSubview:self.subtractBtn];
    [self.subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.countLabel.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.goodsNameLabel.mas_left);
        make.bottom.equalTo(self.addBtn.mas_bottom);
        make.height.offset(20);
        make.right.equalTo(self.subtractBtn.mas_left);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.priceLabel.mas_left);
        make.bottom.right.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(OilGoodModel *)model{
    
    self.model = model;
    for (UILabel * label in self.labelArray) {
        
        [label removeFromSuperview];
    }
    
    if (model.images && [model.images isKindOfClass:[NSArray class]] && model.images.count > 0) {
     
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.images[0]]]];
    }
    else{
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
    NSString * goodsName = [NSString repleaseNilOrNull:model.goods_name];
    float nameWidth = [goodsName widthWithFont:FONT16 andHeight:20];
    if (nameWidth < CGRectGetWidth(self.frame) - 106) {
        
        //一行
        [self.goodsNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView.mas_top);
            make.right.offset(-16);
            make.height.offset(18);
        }];
    }
    else{
        
        //两行
        [self.goodsNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView.mas_top);
            make.right.offset(-16);
            make.height.offset(40);
        }];
    }
    
    self.goodsNameLabel.text = goodsName;
    
    NSString * grade = [NSString repleaseNilOrNull:model.grade];
    NSString * viscosity = [NSString repleaseNilOrNull:model.viscosity];
    NSString * origin = [NSString repleaseNilOrNull:model.origin];
    NSString * pack = [NSString repleaseNilOrNull:model.pack];
    
    float labelX = 96;
    float labelHeight = 18;
    for (NSUInteger i = 0; i < 4; i++) {
        
        UILabel * label = [[UILabel alloc] init];
        [self.labelArray addObject:label];
        label.font = FONT9;
        label.textColor = Color_2E78FF;
        label.backgroundColor = [UIColor colorWithRed:0/255.0 green:121/255.0 blue:255/255.0 alpha:0.1];
        label.textAlignment = NSTextAlignmentCenter;
        
        float labelWidth;
        if (i == 0) {
         
             label.text = grade;
        }
        else if (i == 1){
            
             label.text = viscosity;
        }
        else if (i == 2){
            
             label.text = origin;
        }
        else if (i == 3){
            
             label.text = pack;
        }
        labelWidth = [label.text widthWithFont:FONT9 andHeight:labelHeight] + 6;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(labelX);
            make.top.offset(43);
            make.width.offset(labelWidth);
            make.height.offset(labelHeight);
        }];
        
        labelX += labelWidth + 3;
    }
    
    if (model.specs && [model.specs isKindOfClass:[NSArray class]] && model.specs.count > 0) {
        
        NSDictionary * dic = model.specs[0];
        //计量单位
        NSString * unitStr = @"箱";
        if ([dic.allKeys containsObject:@"unit"]) {
            
            unitStr = dic[@"unit"];
        }
        NSNumber * priceNumber = dic[@"goods_price"];
        
        NSString * price = [[NSString alloc] initWithFormat:@"￥%.2f/%@",priceNumber.floatValue,unitStr];
        NSMutableAttributedString * priceAttributedStr = [[NSMutableAttributedString alloc] initWithString:price];
        [priceAttributedStr addAttributes:@{NSFontAttributeName:FONT9} range:NSMakeRange(0, 1)];
        [priceAttributedStr addAttributes:@{NSFontAttributeName:FONT14} range:NSMakeRange(1, price.length - 1)];
        self.priceLabel.attributedText = priceAttributedStr;
    }
    else{
        
        self.priceLabel.text = @"￥";
    }
    
    self.countLabel.text = model.countStr;
}

@end
