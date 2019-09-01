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
//利润(元)
@property (nonatomic,strong) UILabel * profitTitleLabel;
//时间
@property (nonatomic,strong) UILabel * timeLabel;
//利润
@property (nonatomic,strong) UILabel * profitLabel;
@property (nonatomic,strong) UILabel * lineLabel;


@end

@implementation ProfitStatisticsCell

#pragma mark  ----  懒加载

-(SHMultipleSwitchingItemsView *)itemsView{
    
    if (!_itemsView) {
        
        _itemsView = [[SHMultipleSwitchingItemsView alloc] initWithItemsArray:@[@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"今日",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1300],@"target":self,@"actionStr":@"switchBtnClicked:"},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"昨日",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1301],@"target":self,@"actionStr":@"switchBtnClicked:"},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"本月",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1302],@"target":self,@"actionStr":@"switchBtnClicked:"},@{@"normalTitleColor":@"333333",@"selectedTitleColor":@"0272FF",@"normalTitle":@"其他",@"normalFont":[NSNumber numberWithInt:16],@"btnTag":[NSNumber numberWithInt:1303],@"target":self,@"actionStr":@"switchBtnClicked:"}]];
    }
    return _itemsView;
}

-(UILabel *)profitTitleLabel{
    
    if (!_profitTitleLabel) {
     
        _profitTitleLabel = [[UILabel alloc] init];
        _profitTitleLabel.font = FONT20;
        _profitTitleLabel.textColor = Color_999999;
        _profitTitleLabel.text = @"利润(元)";
    }
    return _profitTitleLabel;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT12;
        _timeLabel.textColor = Color_999999;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

-(UILabel *)profitLabel{
    
    if (!_profitLabel) {
        
        _profitLabel = [[UILabel alloc] init];
        _profitLabel.textColor = Color_E1534A;
    }
    return _profitLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
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
    
    [self addSubview:self.profitTitleLabel];
    [self.profitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.equalTo(self.itemsView.mas_bottom).offset(16);
        make.width.offset(100);
        make.height.offset(20);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.profitTitleLabel.mas_top);
        make.right.offset(-16);
        make.height.offset(12);
        make.width.offset(180);
    }];
    
    [self addSubview:self.profitLabel];
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.equalTo(self.profitTitleLabel.mas_bottom).offset(10);
        make.height.offset(56);
        make.right.offset(0);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.height.offset(1);
        make.top.equalTo(self.profitLabel.mas_bottom).offset(10);
    }];
    
    
}

//切换按钮的响应
-(void)switchBtnClicked:(UIButton *)btn{
    
    if (btn.tag == 1300) {
        
        //今日
    }
    else if (btn.tag == 1301){
        
        //昨日
    }
    else if (btn.tag == 1302){
        
        //本月
    }
    else if (btn.tag == 1303){
        
        //其他
    }
}

-(void)test{
    
    self.timeLabel.text = @"2019-08-27 至 2019-08-27";
    NSString * profitStr = @"8888.00";
    NSMutableAttributedString * profitAttStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [profitAttStr setAttributes:@{NSFontAttributeName:BOLDFONT40} range:NSMakeRange(0, profitStr.length - 3)];
    [profitAttStr setAttributes:@{NSFontAttributeName:BOLDFONT30} range:NSMakeRange(profitStr.length - 3, 3)];
    self.profitLabel.attributedText = profitAttStr;
}

@end
