//
//  CustomerManagementCell.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CustomerManagementCell.h"
#import "ImageAndLabelControl.h"

@interface CustomerManagementCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIScrollView * btnBGScrollView;

@property (nonatomic,strong) NSArray * btnDicArray;

@end

@implementation CustomerManagementCell

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT17;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UIScrollView *)btnBGScrollView{
    
    if (!_btnBGScrollView) {
        
        _btnBGScrollView = [[UIScrollView alloc] init];
//        _btnBGScrollView.backgroundColor = [UIColor greenColor];
    }
    return _btnBGScrollView;
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
       
        make.left.offset(15);
        make.top.offset(0);
        make.right.offset(-15);
        make.height.offset(17);
    }];
    
    [self addSubview:self.btnBGScrollView];
    [self.btnBGScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
    }];
}

//title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
-(void)showData:(NSDictionary *)dic{
    
    NSString * title = dic[@"title"];
    self.titleLabel.text = title;
    
    NSArray * btnDicArray = dic[@"btnDicArray"];
    self.btnDicArray = [[NSArray alloc] initWithArray:btnDicArray];
    NSUInteger controlX = 28;
    NSUInteger scrollViewWidth = 0;
    NSUInteger btnWidth = 50;
    for (NSUInteger i = 0; i < btnDicArray.count; i++) {
        
        NSDictionary * dic = btnDicArray[i];
        NSString * imageName = dic[@"imageName"];
        NSNumber * imageWidthNumber = dic[@"imageWidth"];
        NSNumber * imageHeightNumber = dic[@"imageHeight"];
        NSString * title = dic[@"btnTitle"];
        ImageAndLabelControl * control = [[ImageAndLabelControl alloc] initWithImageName:[NSString repleaseNilOrNull:imageName] andImageSize:CGSizeMake(imageWidthNumber.floatValue, imageHeightNumber.floatValue) andTitle:[NSString repleaseNilOrNull:title]];
//        control.backgroundColor = [UIColor redColor];
        [control addTarget:self action:@selector(controlClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBGScrollView addSubview:control];
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(controlX);
            make.top.offset(23);
            make.width.offset(btnWidth);
            make.height.offset(57);
        }];
        controlX += btnWidth + 44;
        if (i == btnDicArray.count - 1) {
            
            scrollViewWidth = controlX - btnWidth - 44 + 29;
        }
    }
    
    self.btnBGScrollView.contentSize = CGSizeMake(scrollViewWidth, 118);
}

-(void)controlClicked:(ImageAndLabelControl *)control{
    
    NSString * title = control.title;
    for (NSUInteger i = 0; i < self.btnDicArray.count; i++) {
        
        NSDictionary * dic =  self.btnDicArray[i];
        NSString * btnTitle = dic[@"btnTitle"];
        if ([title isEqualToString:btnTitle]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(itemClickedWithItemID:)]) {
                
                NSString * itemId = dic[@"itemId"];
                [self.delegate itemClickedWithItemID:itemId];
            }
            break;
        }
    }
}

@end
