//
//  JHStoreDatePickView.m
//  JHLivePlayLibrary
//
//  Created by i'm yu on 2019/7/12.
//

#import "SHDatePickView.h"

@interface SHDatePickView ()
@property(nonatomic,strong)UIView * bgView;//背景view
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIButton * cancleBtn;
@property(nonatomic,strong)UIButton * insureBtn;
@property(nonatomic,strong)UIDatePicker * dataPicker;
@property(nonatomic,strong)UILabel * titleLabel;
//显示格式,默认yyyy-MM-dd
@property (nonatomic,strong) NSString * showFormatter;
@property (nonatomic, copy) void(^handle)(NSDate * date,NSString * dateStr);
@end

@implementation SHDatePickView

#pragma mark - 懒加载

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, MAINHEIGHT, MAINWIDTH, 240.f)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    }
    return _topView;
}
- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc]init];
        _cancleBtn.tag = 1;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = FONT17;
        [_cancleBtn addTarget:self action:@selector(hideAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (UIButton *)insureBtn{
    if (!_insureBtn) {
        _insureBtn = [[UIButton alloc]init];
        _insureBtn.tag = 2;
        [_insureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_insureBtn setTitleColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _insureBtn.titleLabel.font = FONT17;
        [_insureBtn addTarget:self action:@selector(hideAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insureBtn;
}
- (UIDatePicker *)dataPicker{
    if (!_dataPicker) {
        _dataPicker = [[UIDatePicker alloc]init];
        _dataPicker.datePickerMode = UIDatePickerModeDate;
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        if (!self.showFormatter) {
            
            self.showFormatter = @"yyyy-MM-dd";
        }
        [formatter setDateFormat:self.showFormatter];
        NSDate * minDate = [formatter dateFromString:@"1900-01-01 00:00:01"];
        NSDate * maxDate = [formatter dateFromString:@"2100-12-31 23:59:59"];
        [_dataPicker setMinimumDate:minDate];
        [_dataPicker setMaximumDate:maxDate];
    }
    return _dataPicker;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        _titleLabel.font = BOLDFONT18;
        _titleLabel.text = @"选择时间";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
#pragma mark - 生命周期函数

+ (void)showActionSheetDateWithtitle:(NSString *)title formatter:(NSString *)formatter callBack:(void(^)(NSDate * date,NSString * dateStr))handle
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SHDatePickView *view = [[SHDatePickView alloc] initWithFrame:[UIScreen mainScreen].bounds andFormatter:formatter];
    view.handle = handle;
    if (![NSString strIsEmpty:title]) {
        
        view.titleLabel.text = title;
    }
    [window addSubview:view];
    [view showAnimation];
}
- (instancetype)initWithFrame:(CGRect)frame andFormatter:(NSString *)formatter{
    
    if (self = [super initWithFrame:frame])
    {
        self.showFormatter = formatter;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self addContentView];
    }
    return self;
}

#pragma mark - 自定义函数

- (void)addContentView{
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topView];
    [self.topView addSubview:self.cancleBtn];
    [self.topView addSubview:self.insureBtn];
    [self.bgView addSubview:self.dataPicker];
    [self.topView addSubview:self.titleLabel];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bgView);
        make.height.offset(44);
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(16);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.size.mas_offset(CGSizeMake(40, 22));
    }];
    [self.insureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-16);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.size.mas_offset(CGSizeMake(40, 22));
    }];
    [self.dataPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-34);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.centerX.equalTo(self.topView.mas_centerX);
        make.size.mas_offset(CGSizeMake(150, 17));
    }];
}

- (void)hideAnimation:(UIButton *)sender
{
    CGRect frame = self.bgView.frame;
    frame.origin.y = MAINHEIGHT;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (sender.tag == 2) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (!self.showFormatter) {
                
                self.showFormatter = @"yyyy-MM-dd";
            }
            [formatter setDateFormat:self.showFormatter];
           NSString * resultStr = [formatter stringFromDate:self.dataPicker.date];
            if (self.handle) {
                self.handle(self.dataPicker.date,resultStr);
            }
        }
    }];
}

- (void)showAnimation
{
    CGRect frame = self.bgView.frame;
    frame.origin.y = MAINHEIGHT-240;
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}


@end
