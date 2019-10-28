//
//  ResidualTransactionComplaintCell.m
//  Car
//
//  Created by mac on 2019/9/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ResidualTransactionComplaintCell.h"
#import "SHImageAndTitleBtn.h"

@interface ResidualTransactionComplaintCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) SHImageAndTitleBtn * complaintBtn;

@end

@implementation ResidualTransactionComplaintCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT12;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(SHImageAndTitleBtn *)complaintBtn{
    
    if (!_complaintBtn) {
        
        _complaintBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 40, 18, 24, 40) andImageFrame:CGRectMake(0, 0, 24, 24) andTitleFrame:CGRectMake(0, 24, 24, 16) andImageName:@"tousu" andSelectedImageName:@"tousu" andTitle:@"投诉"];
        [_complaintBtn refreshFont:FONT11];
        [_complaintBtn refreshTitle:nil color:Color_FF3B30];
    }
    return _complaintBtn;
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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.offset(16);
        make.top.offset(16);
        make.width.offset(240);
        make.height.offset(40);
    }];
    
    NSString * str = @"办理服务前请勿付订金、押金等费用\n请先请先确认对方资质，谨防上当受骗！";
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr setAttributes:@{NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(0, str.length)];
    [attributedStr setAttributes:@{NSForegroundColorAttributeName:Color_FF3B30} range:NSMakeRange(9,5)];
    self.titleLabel.attributedText = attributedStr;
    
    //上线暂时注释
//    [self addSubview:self.complaintBtn];
}

@end
