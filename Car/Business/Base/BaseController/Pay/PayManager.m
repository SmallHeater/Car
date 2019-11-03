//
//  PayManager.m
//  GoodView
//
//  Created by xianjun wang on 2019/1/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface PayManager ()<WXApiDelegate>

@property (nonatomic,strong) PayModel * payModel;
@property (nonatomic,strong) MBProgressHUD * mbp;

@end


@implementation PayManager

#pragma mark  ----  生命周期函数

+(PayManager *)sharedManager{
    
    static PayManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[PayManager alloc] init];
        //支付宝支付成功监听
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(alipayResult:) name:@"ALIPAYRESULT" object:nil];
    });
    return manager;
}

#pragma mark  ----  代理
#pragma mark  ----  WXApiDelegate
// 微信支付返回结果回调
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                
               //支付结果：成功
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:1]});
                }
                break;
                
            default:
                
                //支付结果：失败
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:0]});
                }
                break;
        }
    }else {
    }
}

#pragma mark  ----  自定义函数

//支付宝支付
-(void)alipayPayWithOrderString:(NSString *)orderString{
    
    NSString *appScheme = @"com.nuanfengkeji.alypay";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut = %@",resultDic);
    }];
}

//支付宝支付成功
-(void)alipayResult:(NSNotification *)notification{
    
    NSDictionary * infoDic = notification.userInfo;
    NSNumber * stateNum = infoDic[@"state"];
    if (stateNum.intValue == 1) {
        
        //成功
//        [self createPaymentOrderWithPayType:@"2" andScenicModel:self.scenicModel andActivationCode:@""];
    }
}

//微信支付
-(void)weChatPayWithDic:(NSDictionary *)dic{
    
    [WXApi registerApp:@"wx268417062a763c9d"];
    PayReq *req = [[PayReq alloc] init];
    req.openID = [dic objectForKey:@"appid"];
    req.partnerId = [dic objectForKey:@"partnerid"];
    req.prepayId = [dic objectForKey:@"prepayid"];
    req.package = [dic objectForKey:@"package"];
    req.nonceStr = [dic objectForKey:@"noncestr"];
    req.timeStamp = [[dic objectForKey:@"timestamp"] intValue];
    req.sign = [dic objectForKey:@"sign"];
    BOOL result = [WXApi sendReq:req];
    NSString * str = result?@"微信支付调用成功":@"微信支付调用失败";
    NSLog(@"%@",str);
}

@end
