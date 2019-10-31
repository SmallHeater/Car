//
//  GetVerificationCodeBtn.m
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHGetVerificationCodeBtn.h"

@interface SHGetVerificationCodeBtn ()

@property (nonatomic,strong) NSDictionary * configurationDic;
@property (nonatomic,strong) dispatch_source_t timer;
@end

@implementation SHGetVerificationCodeBtn

#pragma mark  ----  生命周期函数

//对默认的实例化方法加处理，避免实例化方法选择错误
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"`-buttonWithType:` 初始化方法不再使用. 用 `initWithConfigurationDic:` 代替"
                                 userInfo:nil];
    return nil;
}

//实例化方法;imageName:图片名;placeholder:默认显示文字;
-(instancetype)initWithConfigurationDic:(NSDictionary *)configurationDic{
    
    self = [super init];
    if (self) {
        
        self.configurationDic = configurationDic;
        [self setTitle:configurationDic[@"normalTitle"] forState:UIControlStateNormal];
        [self setTitleColor:Color_333333 forState:UIControlStateNormal];
        self.titleLabel.font = FONT14;
        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)buttonClicked{
    
    self.userInteractionEnabled = NO;
    
    __weak SHGetVerificationCodeBtn * weakSelf = self;
    __block NSUInteger runSeconds = 0;
    NSNumber * timeNumber = self.configurationDic[@"time"];
    NSUInteger time = timeNumber.integerValue;
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        
        runSeconds++;
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self setTitleColor:Color_CCCCCC forState:UIControlStateNormal];
            [weakSelf setTitle:[[NSString alloc] initWithFormat:@"重新发送(%ld)",(time - runSeconds)] forState:UIControlStateNormal];
            if (runSeconds >= time) {
                
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.userInteractionEnabled = YES;
                [self setTitle:weakSelf.configurationDic[@"normalTitle"] forState:UIControlStateNormal];
                [self setTitleColor:Color_333333 forState:UIControlStateNormal];
            }
        });
    });
    dispatch_resume(self.timer);
}


@end
