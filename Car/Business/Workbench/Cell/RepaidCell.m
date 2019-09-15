//
//  UnpaidCell.m
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "RepaidCell.h"
#import "ReturnRecordCell.h"

static NSString * cellId = @"ReturnRecordCell";

@interface RepaidCell ()<UITableViewDelegate,UITableViewDataSource>

//背景view
@property (nonatomic,strong) UIView * bgView;
//车牌号
@property (nonatomic,strong) UILabel * numberPlateLabel;
//车主姓名
@property (nonatomic,strong) UILabel * nameLabel;
//车型号
@property (nonatomic,strong) UILabel * carModelLabel;
//联系电话
@property (nonatomic,strong) UILabel * phoneNumberLabel;
//虚线分割线
@property (nonatomic,strong) UIImageView * dottedLineImageView;
//内容
@property (nonatomic,strong) UILabel * contentLabel;
//分割线
@property (nonatomic,strong) UILabel * firstLineLabel;
//回款记录
@property (nonatomic,strong) UILabel * RepaidRecordsLabel;
//列表
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<NSDictionary *> * dataArray;

@end

@implementation RepaidCell

#pragma mark  ----  懒加载

-(UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _bgView.layer.cornerRadius = 13;
        _bgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,2);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 10;
        
        [_bgView addSubview:self.numberPlateLabel];
        [self.numberPlateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.offset(21);
            make.width.offset(150);
            make.height.offset(20);
        }];
        
        [_bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-16);
            make.top.offset(23);
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.height.offset(16);
        }];
        
        [_bgView addSubview:self.carModelLabel];
        [self.carModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.equalTo(self.numberPlateLabel.mas_bottom).offset(7);
            make.width.offset(MAINWIDTH - 32 - 100 - 36);
            make.height.offset(14);
        }];
        
        [_bgView addSubview:self.phoneNumberLabel];
        [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.numberPlateLabel.mas_right).offset(0);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
            make.right.offset(-17);
            make.height.offset(14);
        }];
        
        [_bgView addSubview:self.dottedLineImageView];
        [self.dottedLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(self.carModelLabel.mas_bottom).offset(13);
            make.height.offset(1);
        }];
        
        [_bgView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(self.dottedLineImageView).offset(14);
            make.height.offset(36);
        }];
        
        [_bgView addSubview:self.firstLineLabel];
        [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(16);
            make.height.offset(1);
        }];
        
        [_bgView addSubview:self.RepaidRecordsLabel];
        [self.RepaidRecordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.equalTo(self.firstLineLabel.mas_bottom).offset(15);
            make.right.offset(-20);
            make.height.offset(20);
        }];
        
        [_bgView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(self.RepaidRecordsLabel.mas_bottom).offset(20);
            make.bottom.offset(0);
        }];
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

-(UIImageView *)dottedLineImageView{
    
    if (!_dottedLineImageView) {
        
        _dottedLineImageView = [[UIImageView alloc] init];
        _dottedLineImageView.image = [UIImage imageNamed:@"fengexian"];
    }
    return _dottedLineImageView;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT14;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)RepaidRecordsLabel{
    
    if (!_RepaidRecordsLabel) {
        
        _RepaidRecordsLabel = [[UILabel alloc] init];
        _RepaidRecordsLabel.font = FONT20;
        _RepaidRecordsLabel.textColor = Color_333333;
        _RepaidRecordsLabel.text = @"回款记录";
    }
    return _RepaidRecordsLabel;
}

-(NSMutableArray<NSDictionary *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 38;
}

#pragma mark  ----  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReturnRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[ReturnRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary * dic = self.dataArray[indexPath.row];
    [cell showTime:dic[@"createtime"] andMoney:dic[@"money"]];
    
    return cell;
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithContent:(NSString *)content andRepaidListCount:(NSUInteger)count{
    
    float listHeight = count * 38;
    return 159 + 54 + listHeight;
}

-(void)drawUI{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(15);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(0);
    }];
}

-(void)showDataWithDic:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        self.numberPlateLabel.text = dic[@"numberPlate"];
        self.nameLabel.text = dic[@"name"];
        self.carModelLabel.text = dic[@"carModel"];
        self.phoneNumberLabel.text = dic[@"phoneNumber"];
        self.contentLabel.text = dic[@"content"];
        
        if ([dic.allKeys containsObject:@"repaidList"]) {
            
            NSArray * arr = dic[@"repaidList"];
            if (arr && arr.count > 0) {
             
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:arr];
            }
        }
        [self.tableView reloadData];
    }
    else{
        
        self.numberPlateLabel.text = @"";
        self.nameLabel.text = @"";
        self.carModelLabel.text = @"";
        self.phoneNumberLabel.text = @"";
    }
}

-(void)test{
    
//    self.numberPlateLabel.backgroundColor = [UIColor redColor];
//    self.nameLabel.backgroundColor = [UIColor orangeColor];
//    self.carModelLabel.backgroundColor = [UIColor greenColor];
//    self.phoneNumberLabel.backgroundColor = [UIColor grayColor];
//    self.contentLabel.backgroundColor = [UIColor redColor];
//    self.receivableLabel.backgroundColor = [UIColor grayColor];
//    self.receivableContentLabel.backgroundColor = [UIColor greenColor];
//    self.actualHarvestLabel.backgroundColor = [UIColor orangeColor];
//    self.actualHarvestContentLabel.backgroundColor = [UIColor redColor];
//    self.arrearsLabel.backgroundColor = [UIColor orangeColor];
//    self.arrearsContentLabel.backgroundColor = [UIColor greenColor];
    
    [self showDataWithDic:@{@"numberPlate":@"京A12345 ",@"name":@"张三丰 ",@"carModel":@"奥德赛牌HG6481BBAN）",@"phoneNumber":@"18605569805",@"MaintenanceContent":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"receivable":@"2400",@"cost":@"1000",@"profit":@"1400",@"content":@"更换右下摆臂、雨刮电机、右叶子板、下悬梁和左球头",@"receivable":@"2400.00",@"actualHarvest":@"1000.00",@"arrears":@"1400.00"}];
}
@end
