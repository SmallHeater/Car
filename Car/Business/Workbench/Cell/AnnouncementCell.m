//
//  AnnouncementCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AnnouncementCell.h"
#import "TXScrollLabelView.h"
#import "AnnouncementModel.h"

@interface AnnouncementCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
//公告走马灯view
@property (nonatomic,strong) TXScrollLabelView * labelView;
@property (nonatomic,strong) UIButton * moreBtn;
@property (nonatomic,strong) NSMutableArray<AnnouncementModel *> * dataArray;
@property (nonatomic,strong) NSMutableArray<NSString *> * titlesArray;

@end

@implementation AnnouncementCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gonggao"]];
    }
    return _iconImageView;
}

-(UIButton *)moreBtn{
    
    if (!_moreBtn) {
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:Color_0072FF forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = FONT14;
    }
    return _moreBtn;
}

-(TXScrollLabelView *)labelView{
    
    if (!_labelView) {
        
        
        _labelView = [[TXScrollLabelView alloc] initWithTextArray:self.titlesArray type:TXScrollLabelViewTypeUpDown velocity:5 * 30 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        _labelView.scrollTitleColor = Color_666666;
        _labelView.font = FONT14;
        _labelView.backgroundColor = [UIColor whiteColor];
        _labelView.textAlignment = NSTextAlignmentLeft;
//        _labelView.backgroundColor = [UIColor grayColor];
    }
    return _labelView;
}

-(NSMutableArray<AnnouncementModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray<NSString *> *)titlesArray{
    
    if (!_titlesArray) {
        
        _titlesArray = [[NSMutableArray alloc] init];
    }
    return _titlesArray;
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
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(10);
        make.width.offset(36);
        make.height.offset(19);
    }];
    
    [self addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(14);
        make.right.offset(-19);
        make.width.offset(30);
        make.height.offset(14);
    }];
}

-(void)showData:(NSArray<AnnouncementModel *> *)array{
    
    [self.dataArray addObjectsFromArray:array];
    for (AnnouncementModel * model in self.dataArray) {
        
        [self.titlesArray addObject:model.content];
    }
    
    [self addSubview:self.labelView];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(13);
        make.right.offset(-62);
        make.top.offset(13);
        make.height.offset(14);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.labelView beginScrolling];
    });
}

@end
