//
//  MaintenanceLogCell.m
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MaintenanceLogCell.h"
#import "SHTextView.h"
#import "SHPickerView.h"
#import "SHBaiDuBosControl.h"
#import "SHPickerView.h"
#import "SHDatePickView.h"
#import "SHImageViewWithDeleteBtn.h"

#define BTNBASETAG 1300
#define IMAGEBASETAG 1500

@interface MaintenanceLogCell ()<UITextFieldDelegate,SHTextViewDelegate,SHPickerViewDelegate>

@property (nonatomic,strong) UILabel * titleLabel;
//维修日期
@property (nonatomic,strong) UILabel * repairDateLabel;
@property (nonatomic,strong) UILabel * repairDate;
@property (nonatomic,strong) UILabel * firstLineLabel;
//公里数
@property (nonatomic,strong) UILabel * kilometersLabel;
@property (nonatomic,strong) UITextField * kilometersTF;
@property (nonatomic,strong) UILabel * secondLineLabel;
//关联项目
@property (nonatomic,strong) UILabel * associatedProjectLabel;
@property (nonatomic,strong) UILabel * associatedProject;
@property (nonatomic,strong) UILabel * thirdLineLabel;
@property (nonatomic,strong) SHPickerView * projectPickView;
//总费用
@property (nonatomic,strong) UILabel * totalCostLabel;
//应收
@property (nonatomic,strong) UILabel * acceptableLabel;
@property (nonatomic,strong) UITextField * acceptableTF;
@property (nonatomic,strong) UILabel * forthLine;
//实收
@property (nonatomic,strong) UILabel * receivedLabel;
@property (nonatomic,strong) UITextField * receivedTF;
@property (nonatomic,strong) UILabel * fifthLine;
//成本
@property (nonatomic,strong) UILabel * costLabel;
@property (nonatomic,strong) UITextField * costTF;
@property (nonatomic,strong) UILabel * sixthLineLabel;
//维修内容
@property (nonatomic,strong) UILabel * repairContentLabel;
@property (nonatomic,strong) SHTextView * repairContentTF;
@property (nonatomic,strong) UILabel * seventhLabel;
//图片上传
@property (nonatomic,strong) UILabel * imageUploadLabel;
//图片数
@property (nonatomic,strong) UILabel * imageCountLabel;
//添加图片按钮
@property (nonatomic,strong) UIButton * addImageBtn;
//图片字典数组,thumbnails,缩略图;screenSizeImage,全屏图;originalImage,普通图
@property (nonatomic,strong) NSMutableArray<NSDictionary *> * imageArray;
//图片数组
@property (nonatomic,strong) NSMutableArray<NSString *> * imageUrlStrArray;
@property (nonatomic,strong) NSMutableArray<SHImageViewWithDeleteBtn *> * imageViewArray;
//底部图片区view
@property (nonatomic,strong) UIView * bottomView;
//大图浏览数据数组
@property (nonatomic,strong) NSMutableArray * bigPictureDataArray;

@end

@implementation MaintenanceLogCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT17;
        _titleLabel.textColor = Color_333333;
        _titleLabel.text = @"维修日志";
    }
    return _titleLabel;
}

-(UILabel *)repairDateLabel{
    
    if (!_repairDateLabel) {
        
        _repairDateLabel = [[UILabel alloc] init];
        _repairDateLabel.font = FONT16;
        _repairDateLabel.textColor = Color_666666;
        _repairDateLabel.textAlignment = NSTextAlignmentRight;
        _repairDateLabel.text = @"维修日期";
    }
    return _repairDateLabel;
}

-(UILabel *)repairDate{
    
    if (!_repairDate) {
        
        _repairDate = [[UILabel alloc] init];
        _repairDate.font = FONT16;
        _repairDate.textColor = Color_C7C7CD;
        _repairDate.text = @"请选择维修日期";
        _repairDate.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repairDateClicked:)];
        [_repairDate addGestureRecognizer:tap];
    }
    return _repairDate;
}


-(UILabel *)firstLineLabel{
    
    if (!_firstLineLabel) {
        
        _firstLineLabel = [[UILabel alloc] init];
        _firstLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _firstLineLabel;
}

-(UILabel *)kilometersLabel{
    
    if (!_kilometersLabel) {
        
        _kilometersLabel = [[UILabel alloc] init];
        _kilometersLabel.font = FONT16;
        _kilometersLabel.textColor = Color_666666;
        _kilometersLabel.textAlignment = NSTextAlignmentRight;
        _kilometersLabel.text = @"公里数";
    }
    return _kilometersLabel;
}

-(UITextField *)kilometersTF{
    
    if (!_kilometersTF) {
        
        _kilometersTF = [[UITextField alloc] init];
        _kilometersTF.delegate = self;
        _kilometersTF.font = FONT16;
        _kilometersTF.textColor = Color_333333;
        _kilometersTF.placeholder = @"请输入公里数";
        _kilometersTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _kilometersTF;
}

-(UILabel *)secondLineLabel{
    
    if (!_secondLineLabel) {
        
        _secondLineLabel = [[UILabel alloc] init];
        _secondLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _secondLineLabel;
}

-(UILabel *)associatedProjectLabel{
    
    if (!_associatedProjectLabel) {
        
        _associatedProjectLabel = [[UILabel alloc] init];
        _associatedProjectLabel.font = FONT16;
        _associatedProjectLabel.textColor = Color_666666;
        _associatedProjectLabel.textAlignment = NSTextAlignmentRight;
        _associatedProjectLabel.text = @"关联项目";
    }
    return _associatedProjectLabel;
}

-(UILabel *)associatedProject{
    
    if (!_associatedProject) {
        
        _associatedProject = [[UILabel alloc] init];
        _associatedProject.font = FONT16;
        _associatedProject.textColor = Color_C7C7CD;
        _associatedProject.text = @"请选择关联项目";
        _associatedProject.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(associatedProjectClicked:)];
        [_associatedProject addGestureRecognizer:tap];
    }
    return _associatedProject;
}


-(UILabel *)thirdLineLabel{
    
    if (!_thirdLineLabel) {
        
        _thirdLineLabel = [[UILabel alloc] init];
        _thirdLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _thirdLineLabel;
}

-(SHPickerView *)projectPickView{
    
    if (!_projectPickView) {
        
        _projectPickView = [[SHPickerView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT) andTitle:@"关联项目" andComponent:1 andData:@[@{@"title":@"保养",@"key":@"0"},@{@"title":@"维修",@"key":@"1"},@{@"title":@"美容洗车",@"key":@"2"}]];
        _projectPickView.delegate = self;
    }
    return _projectPickView;
}

-(UILabel *)totalCostLabel{
    
    if (!_totalCostLabel) {
        
        _totalCostLabel = [[UILabel alloc] init];
        _totalCostLabel.font = FONT16;
        _totalCostLabel.textColor = Color_666666;
        _totalCostLabel.text = @"总费用";
    }
    return _totalCostLabel;
}

-(UILabel *)acceptableLabel{
    
    if (!_acceptableLabel) {
        
        _acceptableLabel = [[UILabel alloc] init];
        _acceptableLabel.textAlignment = NSTextAlignmentCenter;
        _acceptableLabel.font = FONT14;
        _acceptableLabel.textColor = Color_999999;
        _acceptableLabel.text = @"应收";
    }
    return _acceptableLabel;
}

-(UITextField *)acceptableTF{
    
    if (!_acceptableTF) {
        
        _acceptableTF = [[UITextField alloc] init];
        _acceptableTF.delegate = self;
        _acceptableTF.textColor = Color_333333;
        _acceptableTF.font = FONT16;
        _acceptableTF.textAlignment = NSTextAlignmentCenter;
        _acceptableTF.keyboardType = UIKeyboardTypePhonePad;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"请输入应收金额" attributes:
             @{NSForegroundColorAttributeName:Color_999999,
               NSFontAttributeName:FONT12}
             ];
        _acceptableTF.attributedPlaceholder = attrString;
    }
    return _acceptableTF;
}

-(UILabel *)forthLine{
    
    if (!_forthLine) {
        
        _forthLine = [[UILabel alloc] init];
        _forthLine.backgroundColor = Color_DEDEDE;
    }
    return _forthLine;
}

-(UILabel *)receivedLabel{
    
    if (!_receivedLabel) {
        
        _receivedLabel = [[UILabel alloc] init];
        _receivedLabel.textAlignment = NSTextAlignmentCenter;
        _receivedLabel.font = FONT14;
        _receivedLabel.textColor = Color_999999;
        _receivedLabel.text = @"实收";
    }
    return _receivedLabel;
}

-(UITextField *)receivedTF{
    
    if (!_receivedTF) {
        
        _receivedTF = [[UITextField alloc] init];
        _receivedTF.delegate = self;
        _receivedTF.textColor = Color_333333;
        _receivedTF.font = FONT16;
        _receivedTF.textAlignment = NSTextAlignmentCenter;
        _receivedTF.keyboardType = UIKeyboardTypePhonePad;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"请输入实收金额" attributes:
             @{NSForegroundColorAttributeName:Color_999999,
               NSFontAttributeName:FONT12}
             ];
        _receivedTF.attributedPlaceholder = attrString;
    }
    return _receivedTF;
}

-(UILabel *)fifthLine{
    
    if (!_fifthLine) {
        
        _fifthLine = [[UILabel alloc] init];
        _fifthLine.backgroundColor = Color_DEDEDE;
    }
    return _fifthLine;
}

-(UILabel *)costLabel{
    
    if (!_costLabel) {
        
        _costLabel = [[UILabel alloc] init];
        _costLabel.textAlignment = NSTextAlignmentCenter;
        _costLabel.font = FONT14;
        _costLabel.textColor = Color_999999;
        _costLabel.text = @"成本";
    }
    return _costLabel;
}

-(UITextField *)costTF{
    
    if (!_costTF) {
        
        _costTF = [[UITextField alloc] init];
        _costTF.delegate = self;
        _costTF.textColor = Color_333333;
        _costTF.font = FONT16;
        _costTF.textAlignment = NSTextAlignmentCenter;
        _costTF.keyboardType = UIKeyboardTypePhonePad;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"请输入成本" attributes:
             @{NSForegroundColorAttributeName:Color_999999,
               NSFontAttributeName:FONT12}
             ];
        _costTF.attributedPlaceholder = attrString;
    }
    return _costTF;
}

-(UILabel *)sixthLineLabel{
    
    if (!_sixthLineLabel) {
        
        _sixthLineLabel = [[UILabel alloc] init];
        _sixthLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _sixthLineLabel;
}

-(UILabel *)repairContentLabel{
    
    if (!_repairContentLabel) {
        
        _repairContentLabel = [[UILabel alloc] init];
        _repairContentLabel.font = FONT16;
        _repairContentLabel.textColor = Color_666666;
        _repairContentLabel.text = @"维修内容";
    }
    return _repairContentLabel;
}

-(SHTextView *)repairContentTF{
    
    if (!_repairContentTF) {
        
        _repairContentTF = [[SHTextView alloc] init];
        _repairContentTF.delegate = self;
        _repairContentTF.textFont = FONT16;
        _repairContentTF.placeholderColor = Color_C7C7CD;
        _repairContentTF.textColor = Color_333333;
        _repairContentTF.placeholder = @"请输入维修内容";
    }
    return _repairContentTF;
}

-(UILabel *)seventhLabel{
    
    if (!_seventhLabel) {
        
        _seventhLabel = [[UILabel alloc] init];
        _seventhLabel.backgroundColor = Color_DEDEDE;
    }
    return _seventhLabel;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        
        [_bottomView addSubview:self.imageUploadLabel];
        [self.imageUploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.offset(20);
            make.width.offset(100);
            make.height.offset(16);
        }];
        
        [_bottomView addSubview:self.imageCountLabel];
        [self.imageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-18);
            make.top.offset(20);
            make.width.offset(50);
            make.height.offset(16);
        }];
        
        [_bottomView addSubview:self.addImageBtn];
        [self.addImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(15);
            make.top.offset(56);
            make.width.height.offset(111);
        }];
    }
    return _bottomView;
}

-(UILabel *)imageUploadLabel{
    
    if (!_imageUploadLabel) {
        
        _imageUploadLabel = [[UILabel alloc] init];
        _imageUploadLabel.font = FONT16;
        _imageUploadLabel.textColor = Color_666666;
        _imageUploadLabel.text = @"图片上传";
    }
    return _imageUploadLabel;
}

-(UILabel *)imageCountLabel{
    
    if (!_imageCountLabel) {
        
        _imageCountLabel = [[UILabel alloc] init];
        _imageCountLabel.font = FONT16;
        _imageCountLabel.textColor = Color_999999;
        _imageCountLabel.textAlignment = NSTextAlignmentRight;
//        _imageCountLabel.backgroundColor = [UIColor greenColor];
    }
    return _imageCountLabel;
}

-(NSMutableArray<NSDictionary *> *)imageArray{
    
    if (!_imageArray) {
        
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

-(NSMutableArray<NSString *> *)imageUrlStrArray{
    
    if (!_imageUrlStrArray) {
        
        _imageUrlStrArray = [[NSMutableArray alloc] init];
    }
    return _imageUrlStrArray;
}

-(NSMutableArray<SHImageViewWithDeleteBtn *> *)imageViewArray{
    
    if (!_imageViewArray) {
        
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

-(UIButton *)addImageBtn{
    
    if (!_addImageBtn) {
        
        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addImageBtn.backgroundColor = Color_E9E9E9;
        [_addImageBtn setImage:[UIImage imageNamed:@"tianjiatupian"] forState:UIControlStateNormal];
        [_addImageBtn addTarget:self action:@selector(addImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageBtn;
}

-(NSMutableArray *)bigPictureDataArray{
    
    if (!_bigPictureDataArray) {
        
        _bigPictureDataArray = [[NSMutableArray alloc] init];
    }
    return _bigPictureDataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.kilometersTF]) {
        
        NSMutableString * showStr = [[NSMutableString alloc] initWithString:textField.text];
        if ([showStr rangeOfString:@" 公里"].location != NSNotFound) {
         
            [showStr replaceCharactersInRange:[showStr rangeOfString:@" 公里"] withString:@""];
        }
        textField.text = showStr;
    }
    else if ([textField isEqual:self.acceptableTF] || [textField isEqual:self.receivedTF] || [textField isEqual:self.costTF]){
        
        //应收
        NSMutableString * showStr = [[NSMutableString alloc] initWithString:textField.text];
        if ([showStr rangeOfString:@"￥"].location != NSNotFound) {
            
            [showStr replaceCharactersInRange:[showStr rangeOfString:@"￥"] withString:@""];
        }
        textField.text = showStr;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.kilometersTF]) {
        
        if (self.kmCallBack) {
            
            self.kmCallBack(textField.text.floatValue);
        }
        
        NSString * mixedStr = [[NSString alloc] initWithFormat:@"%@ 公里",textField.text];
        textField.text = mixedStr;
    }
    else if ([textField isEqual:self.acceptableTF]){
        
        if (self.acceptableCallBack) {
            
            self.acceptableCallBack(textField.text.floatValue);
        }
        
        NSString * str = [[NSString alloc] initWithFormat:@"%.2f",textField.text.floatValue];
        NSString * mixedStr = [[NSString alloc] initWithFormat:@"￥%@",str];
        textField.text = mixedStr;
    }
    else if ([textField isEqual:self.receivedTF]){
        
        if (self.receivedCallBack) {
            
            self.receivedCallBack(textField.text.floatValue);
        }
        
        NSString * str = [[NSString alloc] initWithFormat:@"%.2f",textField.text.floatValue];
        NSString * mixedStr = [[NSString alloc] initWithFormat:@"￥%@",str];
        textField.text = mixedStr;
    }
    else if ([textField isEqual:self.costTF]){
        
        if (self.costCallBack) {
            
            self.costCallBack(textField.text.floatValue);
        }
        
        NSString * str = [[NSString alloc] initWithFormat:@"%.2f",textField.text.floatValue];
        NSString * mixedStr = [[NSString alloc] initWithFormat:@"￥%@",str];
        textField.text = mixedStr;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  SHTextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (self.contentCallBack) {
        
        self.contentCallBack(textView.text);
    }
}

#pragma mark  ----  SHPickerViewDelegate

-(void)picker:(SHPickerView *)picker didSelectedArray:(NSMutableArray *)selectDicArray{
    
    if (selectDicArray && selectDicArray.count > 0) {
     
        NSDictionary * dic = (NSDictionary *)selectDicArray.firstObject;
        self.associatedProject.text = dic[@"title"];
        self.associatedProject.textColor = Color_333333;
        if (self.projectCallBack) {
            
            NSString * keyValue = dic[@"key"];
            self.projectCallBack(keyValue.floatValue);
        }
    }
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithContent:(NSString *)content{
    
    float contentHeight = [[NSString repleaseNilOrNull:content] heightWithFont:FONT16 andWidth:MAINWIDTH - 120];
    
    return 344 + 17 + contentHeight + 19 + 56 + 111 * 2 + 10 + 94;
}

-(void)drawUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(17);
        make.top.offset(26);
        make.width.offset(100);
        make.height.offset(17);
    }];
    
    [self addSubview:self.repairDateLabel];
    [self.repairDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(36);
        make.height.offset(16);
    }];
    
    [self addSubview:self.repairDate];
    [self.repairDate mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.repairDateLabel.mas_right).offset(26);
        make.top.equalTo(self.repairDateLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.repairDateLabel.mas_height);
    }];
    
    [self addSubview:self.firstLineLabel];
    [self.firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.repairDateLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.kilometersLabel];
    [self.kilometersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.firstLineLabel.mas_bottom).offset(18);
        make.height.offset(16);
    }];
    
    [self addSubview:self.kilometersTF];
    [self.kilometersTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.kilometersLabel.mas_right).offset(26);
        make.top.equalTo(self.kilometersLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.kilometersLabel.mas_height);
    }];
    
    [self addSubview:self.secondLineLabel];
    [self.secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.kilometersLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.associatedProjectLabel];
    [self.associatedProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.width.offset(88);
        make.top.equalTo(self.secondLineLabel.mas_bottom).offset(18);
        make.height.offset(16);
    }];
    
    [self addSubview:self.associatedProject];
    [self.associatedProject mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.associatedProjectLabel.mas_right).offset(26);
        make.top.equalTo(self.associatedProjectLabel.mas_top);
        make.right.offset(-15);
        make.height.equalTo(self.associatedProjectLabel.mas_height);
    }];
    
    [self addSubview:self.thirdLineLabel];
    [self.thirdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.associatedProjectLabel.mas_bottom).offset(18);
        make.height.offset(1);
    }];
    
    [self addSubview:self.totalCostLabel];
    [self.totalCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.equalTo(self.thirdLineLabel.mas_bottom).offset(21);
        make.width.offset(100);
        make.height.offset(16);
    }];
    
    float triangulationWidth = MAINWIDTH / 3.0;
    
    [self addSubview:self.acceptableLabel];
    [self.acceptableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.equalTo(self.totalCostLabel.mas_bottom).offset(25);
        make.width.offset(triangulationWidth);
        make.height.offset(14);
    }];
    
    [self addSubview:self.acceptableTF];
    [self.acceptableTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.acceptableLabel.mas_left);
        make.top.equalTo(self.acceptableLabel.mas_bottom).offset(0);
        make.width.equalTo(self.acceptableLabel.mas_width);
        make.height.offset(16 + 17 * 2);
    }];
    
    [self addSubview:self.forthLine];
    [self.forthLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.acceptableLabel.mas_top).offset(10);
        make.left.equalTo(self.acceptableLabel.mas_right);
        make.width.offset(1);
        make.height.offset(17);
    }];
    
    [self addSubview:self.receivedLabel];
    [self.receivedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.acceptableLabel.mas_right).offset(0);
        make.top.equalTo(self.acceptableLabel.mas_top);
        make.width.offset(triangulationWidth);
        make.height.offset(14);
    }];
    
    [self addSubview:self.receivedTF];
    [self.receivedTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.receivedLabel.mas_left);
        make.top.equalTo(self.receivedLabel.mas_bottom).offset(0);
        make.width.equalTo(self.receivedLabel.mas_width);
        make.height.offset(16 + 17 * 2);
    }];
    
    [self addSubview:self.fifthLine];
    [self.fifthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.receivedLabel.mas_top).offset(10);
        make.left.equalTo(self.receivedLabel.mas_right);
        make.width.offset(1);
        make.height.offset(17);
    }];
    
    [self addSubview:self.costLabel];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.receivedLabel.mas_right).offset(0);
        make.top.equalTo(self.receivedLabel.mas_top).offset(0);
        make.width.offset(triangulationWidth);
        make.height.offset(14);
    }];
    
    [self addSubview:self.costTF];
    [self.costTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.costLabel.mas_left);
        make.top.equalTo(self.costLabel.mas_bottom).offset(0);
        make.width.equalTo(self.costLabel.mas_width);
        make.height.offset(16 + 17 * 2);
    }];
    
    [self addSubview:self.sixthLineLabel];
    [self.sixthLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.costTF.mas_bottom).offset(27);
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    
    [self addSubview:self.repairContentLabel];
    [self.repairContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.equalTo(self.sixthLineLabel.mas_bottom).offset(17);
        make.width.offset(68);
        make.height.offset(16);
    }];
    
    [self addSubview:self.repairContentTF];
    //输入区域高度太矮，加高
    float defaultContentTFHeight = [@"维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测维修内容测试" heightWithFont:FONT16 andWidth:MAINWIDTH - 120];
    [self.repairContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.repairContentLabel.mas_right).offset(26);
        make.top.equalTo(self.repairContentLabel.mas_top);
        make.right.offset(-17);
        make.height.offset(defaultContentTFHeight);
    }];
    
    [self addSubview:self.seventhLabel];
    [self.seventhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.repairContentTF.mas_bottom).offset(19);
        make.height.offset(1);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.seventhLabel.mas_bottom).offset(0);
    }];
}

-(void)repairDateClicked:(UITapGestureRecognizer *)gesture{
    
    [self endEditing:YES];
    __weak typeof(self) weakSelf = self;
    [SHDatePickView showActionSheetDateWithtitle:@"" formatter:@"yyyy-MM-dd" callBack:^(NSDate * _Nonnull date, NSString * _Nonnull dateStr) {
        
        weakSelf.repairDate.text = dateStr;
        weakSelf.repairDate.textColor = Color_333333;
        if (weakSelf.repairDateCallBack) {
            
            weakSelf.repairDateCallBack(dateStr);
        }
    }];
}

-(void)associatedProjectClicked:(UITapGestureRecognizer *)gesture{
    
    [self endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.projectPickView];
}

-(void)showData:(NSDictionary *)dic{
    
    NSString * repairDate = dic[@"repairDate"];
    if (![NSString strIsEmpty:repairDate]) {
        
        self.repairDate.text = repairDate;
        self.repairDate.textColor = Color_333333;
    }
    
    NSString * associatedProject = dic[@"associatedProject"];
    if (![NSString strIsEmpty:associatedProject]) {
        
        self.associatedProject.text = dic[@"associatedProject"];
        self.associatedProject.textColor = Color_333333;
    }
    
    self.kilometersTF.text = dic[@"kilometers"];
    self.repairContentTF.text = dic[@"repairContent"];
    
    float repairContentHeight = [dic[@"repairContent"] heightWithFont:FONT16 andWidth:MAINWIDTH - 120];
    if (repairContentHeight > 20) {
     
        [self.repairContentTF mas_updateConstraints:^(MASConstraintMaker *make) {
            
            NSLog(@"高度：%lf",repairContentHeight);
            make.height.offset(repairContentHeight);
        }];
    }
    
    self.acceptableTF.text = [[NSString alloc] initWithFormat:@"￥%@",dic[@"acceptable"]];
    self.receivedTF.text = [[NSString alloc] initWithFormat:@"￥%@",dic[@"received"]];
    self.costTF.text = [[NSString alloc] initWithFormat:@"￥%@",dic[@"cost"]];
    
    NSString * urlStr = dic[@"images"];
    if (![NSString strIsEmpty:urlStr]) {
        
        [self.imageUrlStrArray removeAllObjects];
        NSArray * tempArr = [urlStr componentsSeparatedByString:@","];
        [self.imageUrlStrArray addObjectsFromArray:tempArr];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            [weakSelf createImageViews];
        });
    }
}

//主动开始上传图片
-(void)startUploadImages{
    
    if (self.imageArray.count > 0) {
        
        __block NSMutableArray * imagePathArray = [[NSMutableArray alloc] initWithArray:self.imageUrlStrArray];
        for (NSDictionary * imageDic in self.imageArray) {
            
            UIImage * image = imageDic[@"screenSizeImage"];
            [[SHBaiDuBosControl sharedManager] uploadImage:image callBack:^(NSString * _Nonnull imagePath) {
                
                [imagePathArray addObject:imagePath];
                if (imagePathArray.count == self.imageArray.count + self.imageUrlStrArray.count) {
                    
                    //上传全部完成
                    if (self.imageUrlCallBack) {
    
                        NSString * callBackImagePath = [imagePathArray componentsJoinedByString:@","];
                        self.imageUrlCallBack(callBackImagePath);
                    }
                }
            }];
        }
    }
    else{
        
        if (self.imageUrlCallBack) {
            
            self.imageUrlCallBack(@"");
        }
    }
}

-(void)addImageBtnClicked:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:GETIMAGE withParameter:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:5 - self.imageArray.count - self.imageUrlStrArray.count],@"sourceType":[NSNumber numberWithInteger:0]} callBack:^(NSDictionary *resultDic) {
        
        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
            
            NSArray * dataArray = resultDic[@"data"];
            [weakSelf.imageArray addObjectsFromArray:dataArray];
            [weakSelf createImageViews];
        }
    }];
    btn.userInteractionEnabled = YES;
}

//创建图片
-(void)createImageViews{
    
    //移除所有imageView
    for (SHImageViewWithDeleteBtn * imageViewWithBtn in self.imageViewArray) {
        
        [imageViewWithBtn removeFromSuperview];
    }
    
    [self.imageViewArray removeAllObjects];
    [self.bigPictureDataArray removeAllObjects];
    
    //图片总数
    NSUInteger imageCount = self.imageUrlStrArray.count + self.imageArray.count;
    self.imageCountLabel.text = [[NSString alloc] initWithFormat:@"%ld / 5",imageCount];
    float imageViewLeft = 15;
    float imageViewTop = 56;
    float imageWidthHeight = 111;
    float interval = (MAINWIDTH - 15 * 2 - imageWidthHeight * 3) / 2.0;
    
    __weak typeof(self) weakSelf = self;
    for (NSUInteger i = 0; i < imageCount; i++) {
        
        if (i < self.imageUrlStrArray.count) {
            
            NSString * imageUrlStr = self.imageUrlStrArray[i];
            SHImageViewWithDeleteBtn * imageViewWithBtn = [[SHImageViewWithDeleteBtn alloc] initWithImage:nil andButtonTag:BTNBASETAG + i];
            imageViewWithBtn.tag = IMAGEBASETAG + i;
            imageViewWithBtn.deleteCallBack = ^(NSUInteger btnTag) {
              
                NSString * str = [weakSelf.imageUrlStrArray objectAtIndex:btnTag - BTNBASETAG];
                [weakSelf.imageUrlStrArray removeObjectAtIndex:btnTag - BTNBASETAG];
                if (weakSelf.deleteImageUrlCallBack) {
                    
                    weakSelf.deleteImageUrlCallBack(str);
                }
                [weakSelf createImageViews];
            };
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
            [imageViewWithBtn addGestureRecognizer:tap];
            
            [imageViewWithBtn.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
            [self.bigPictureDataArray addObject:imageUrlStr];
            [self.bottomView addSubview:imageViewWithBtn];
            [self.imageViewArray addObject:imageViewWithBtn];
            [imageViewWithBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(imageViewLeft);
                make.top.offset(imageViewTop);
                make.width.height.offset(imageWidthHeight);
            }];
            imageViewLeft += imageWidthHeight + interval;
            if (i == 2) {
                
                imageViewTop += imageWidthHeight + 10;
                imageViewLeft = 15;
            }
        }
        else{
            
            NSDictionary * dic = self.imageArray[i - self.imageUrlStrArray.count];
            UIImage * thumbnailsImage = dic[@"thumbnails"];
            [self.bigPictureDataArray addObject:thumbnailsImage];
            SHImageViewWithDeleteBtn * imageViewWithBtn = [[SHImageViewWithDeleteBtn alloc] initWithImage:thumbnailsImage andButtonTag:BTNBASETAG + i];
            imageViewWithBtn.deleteCallBack = ^(NSUInteger btnTag) {
                
                [weakSelf.imageArray removeObjectAtIndex:btnTag - BTNBASETAG - self.imageUrlStrArray.count];
                [weakSelf createImageViews];
            };
            [self.bottomView addSubview:imageViewWithBtn];
            [self.imageViewArray addObject:imageViewWithBtn];
            [imageViewWithBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(imageViewLeft);
                make.top.offset(imageViewTop);
                make.width.height.offset(imageWidthHeight);
            }];
            imageViewLeft += imageWidthHeight + interval;
            if (i == 2) {
                
                imageViewTop += imageWidthHeight + 10;
                imageViewLeft = 15;
            }
        }
    }
    
    [self.addImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(imageViewLeft);
        make.top.offset(imageViewTop);
        make.width.height.offset(imageWidthHeight);
    }];
}

-(void)imageTaped:(UITapGestureRecognizer *)gesture{
    
    UIView * view = gesture.view;
    NSUInteger index = view.tag - IMAGEBASETAG;
    [SHRoutingComponent openURL:BIGPICTUREBROWSING withParameter:@{@"dataArray":self.bigPictureDataArray,@"selectedIndex":[NSNumber numberWithInteger:index]}];
}

@end
