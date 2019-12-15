//
//  IdentificationDrivingLicenseCell.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "IdentificationDrivingLicenseCell.h"
#import "VehicleKeyboard_swift-Swift.h"

@interface IdentificationDrivingLicenseCell ()<PWHandlerDelegate>

@property (strong,nonatomic) PWHandler *handler;
@property (strong, nonatomic) UIView *plateInputView;
//切换新能源按钮
@property (nonatomic,strong) UIButton * changeBtn;

@end

@implementation IdentificationDrivingLicenseCell

#pragma mark  ----  懒加载

-(UIView *)plateInputView{
    
    if (!_plateInputView) {
        
        _plateInputView = [[UIView alloc] initWithFrame:CGRectMake(16, 10, MAINWIDTH - 16 * 2, 60)];
    }
    return _plateInputView;
}

-(UIButton *)changeBtn{
    
    if (!_changeBtn) {
        
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.titleLabel.font = FONT16;
        [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _changeBtn.backgroundColor = [UIColor lightGrayColor];
        _changeBtn.backgroundColor = [UIColor colorWithRed:213.0/256.0 green:217.0/256.0 blue:216.0/256.0 alpha:1];
        [_changeBtn setTitle:@"点击切换至新能源" forState:UIControlStateNormal];
        [_changeBtn setTitle:@"点击切换至普通车" forState:UIControlStateSelected];
        __weak typeof(self) weakSelf = self;
        [[_changeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.selected = !x.selected;
            //格子输入框改变新能源
            [weakSelf.handler changeInputTypeWithIsNewEnergy:x.selected];
        }];
    }
    return _changeBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  PWHandlerDelegate
//车牌输入发生变化时的回调
- (void)palteDidChnageWithPlate:(NSString *)plate complete:(BOOL)complete{
NSLog(@"输入车牌号为:%@ \n 是否完整：%@",plate,complete ? @"完整" : @"不完整");
}

//输入完成点击确定后的回调
- (void)plateInputCompleteWithPlate:(NSString *)plate{
    
NSLog(@"输入完成。车牌号为:%@",plate);
    if (self.callBack) {
        
        self.callBack(plate);
    }
}

//车牌键盘出现的回调
- (void)plateKeyBoardShow{

}

//车牌键盘消失的回调
- (void) plateKeyBoardHidden{

}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.plateInputView];
    [self.plateInputView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.left.offset(16);
        make.right.offset(-16);
        make.height.offset(60);
    }];

    self.handler = [PWHandler new];
    //改变主题色
    self.handler.mainColor = [UIColor colorWithRed:84.0/256.0 green:139.0/256.0 blue:228.0/256.0 alpha:1];
    //改变文字大小
    self.handler.textFontSize = 18;
    //改变文字颜色
    self.handler.textColor = [UIColor blackColor];

    [self.handler setKeyBoardViewWithView:self.plateInputView];

    self.handler.delegate = self;
    
    [self addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-5);
        make.height.offset(40);
    }];
}

@end
