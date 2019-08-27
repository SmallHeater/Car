//
//  MaintenanceRecordsCell.m
//  Car
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MaintenanceRecordsCell.h"

@interface MaintenanceRecordsCell ()

@property (nonatomic,strong) UIView * bgView;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
//车主姓名
@property (nonatomic,strong) UILabel * nameLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
//联系电话
@property (nonatomic,strong) UILabel * phoneNumberLabel;

@end

@implementation MaintenanceRecordsCell

#pragma mark  ----  懒加载

-(UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:0.21].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,3);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 8;
        _bgView.layer.cornerRadius = 10;
        
        [_bgView addSubview:self.numberPlateLabel];
        [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(17);
            make.top.offset(15);
            make.width.offset(150);
            make.height.offset(20);
        }];
        
        [_bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-20);
            make.top.offset(16);
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.height.offset(16);
        }];
        
        [_bgView addSubview:self.carModelLabel];
        [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(17);
            make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(12);
            make.width.offset(MAINWIDTH - 32 - 100 - 36);
            make.height.offset(14);
        }];
        
        [_bgView addSubview:self.phoneNumberLabel];
        [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
            make.right.offset(-21);
            make.height.offset(14);
        }];
        
        [self drawDottedLine];
    }
    return _bgView;
}

-(UILabel *)numberPlateLabel{
    
    if (!_numberPlateLabel) {
        
        _numberPlateLabel = [[UILabel alloc] init];
        _numberPlateLabel.font = BOLDFONT20;
        _numberPlateLabel.textColor = Color_333333;
    }
    return _numberPlateLabel;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = BOLDFONT16;
        _nameLabel.textColor = Color_666666;
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

-(UILabel *)carModelLabel{
    
    if (!_carModelLabel) {
        
        _carModelLabel = [[UILabel alloc] init];
        _carModelLabel.font = FONT14;
        _carModelLabel.textColor = Color_999999;
    }
    return _carModelLabel;
}

-(UILabel *)phoneNumberLabel{
    
    if (!_phoneNumberLabel) {
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = FONT14;
        _phoneNumberLabel.textColor = Color_999999;
        _phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _phoneNumberLabel;
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
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.bottom.offset(0);
    }];
}

-(void)drawRect:(CGRect)rect{
    
    
}

//绘制虚线
-(void)drawDottedLine{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:self.bounds];
    
//    if (isHorizonal) {
    
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
        
//    } else{
//        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
//    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
    //  设置虚线宽度
//    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
//    } else {
//
//        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
//    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
//    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
//    } else {
//        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
//    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
    }
}

-(void)test{
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805"}];
}

@end
