//
//  ImageViewAndTextFieldAndBottomLineView.m
//  Car
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ImageViewAndTextFieldAndBottomLineView.h"

@interface ImageViewAndTextFieldAndBottomLineView ()

//图片
@property (nonatomic,strong) UIImageView * iconImageView;
//输入框
@property (nonatomic,strong) UITextField * textField;
//分割线
@property (nonatomic,strong) UILabel * bottomLine;
//配置字典
@property (nonatomic,strong) NSDictionary * configurationDic;

@end

@implementation ImageViewAndTextFieldAndBottomLineView

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.configurationDic[@"imageName"]]];
    }
    return _iconImageView;
}

-(UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.placeholder = self.configurationDic[@"placeholder"];
    }
    return _textField;
}

-(UILabel *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = Color_EEEEEE;
    }
    return _bottomLine;
}

#pragma mark  ----  生命周期函数

//对默认的实例化方法加处理，避免实例化方法选择错误
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"`-init` 初始化方法不再使用. 用 `initWithConfigurationDic:` 代替"
                                 userInfo:nil];
    return nil;
}

//实例化方法;imageName:图片名;placeholder:默认显示文字;
-(instancetype)initWithConfigurationDic:(NSDictionary *)configurationDic{
    
    self = [super init];
    if (self) {
        
        self.configurationDic = configurationDic;
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(9);
        make.top.offset(15);
        make.width.height.offset(22);
    }];
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.offset(14);
        make.right.offset(-9);
        make.height.offset(24);
    }];
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

@end
