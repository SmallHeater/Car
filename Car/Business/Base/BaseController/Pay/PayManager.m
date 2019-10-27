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
//创建支付订单
-(void)createPaymentOrderWithPayType:(PayType)payType andPayModel:(PayModel *)payModel{
    
    if (self.mbp) {

        [self.mbp hide:YES];
        self.mbp = nil;
    }

    self.mbp = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.mbp show:YES];
    
    self.payModel = payModel;
    //价格
    float price = 0;
    //支付标题
    NSString * title = @"";
    /*
    //id,价格，名，支付方式1微信，2支付宝,3余额支付、4激活码；codename,激活码 没有时不传
    NSDictionary * paramDic;
    if ([payType isEqualToString:@"4"]) {
        
        paramDic = @{@"scenic_id":self.scenicModel.scenic_id,@"money":[NSNumber numberWithFloat:price],@"user_id":[AccountManager sharedManager].userModel.user_id,@"body":title,@"pay_type":payType,@"codename":code};
    }
    else{
        
        paramDic = @{@"scenic_id":self.scenicModel.scenic_id,@"money":[NSNumber numberWithFloat:price],@"user_id":[AccountManager sharedManager].userModel.user_id,@"body":title,@"pay_type":payType};
    }
    __weak PayManager * weakSelf = self;
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KGENURL]];
    [manager POST:@"Payment/payOrder" parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (weakSelf.mbp) {

            [weakSelf.mbp hide:YES];
            weakSelf.mbp = nil;
        }
        
        //1，表示激活码激活成功,支付宝支付成功；8，表示是微信支付；4，5，传参不对，余额不足
        NSNumber * status = responseObject[@"status"];
        
        if ([payType isEqualToString:@"1"]) {
            
            if (status.integerValue == 8){
                
                //微信支付
                 [[PayManager sharedManager] weChatPayWithDic:responseObject[@"xml"]];
            }
        }
        else if ([payType isEqualToString:@"2"]) {
            
            if (status.intValue == 1) {
                
                //支付宝支付成功
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:1]});
                }
            }
        }
        else if ([payType isEqualToString:@"3"]){
            
            //余额支付
            if (status.intValue == 1) {
                
                //刷新用户余额
                [AccountManager sharedManager].userModel.user_money = responseObject[@"user_money"];
                [MBProgressHUD showInfoMessage:@"支付成功"];
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:1]});
                }
            }
            else if (status.intValue == 4) {
                
                [MBProgressHUD showErrorMessage:responseObject[@"msg"]];
            }
            else if (status.intValue == 5){
                
                [MBProgressHUD showErrorMessage:responseObject[@"msg"]];
            }
        }
        else if ([payType isEqualToString:@"4"]){
            
            //激活码支付
            if (status.intValue == 1) {
                
                [MBProgressHUD showInfoMessage:@"支付成功"];
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:1]});
                }
            }
            else if (status.intValue == 5){
                
                [MBProgressHUD showErrorMessage:responseObject[@"msg"]];
                if (self.payBlock) {
                    
                    self.payBlock(@{@"state":[NSNumber numberWithInt:0]});
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (weakSelf.mbp) {
            
            [weakSelf.mbp hide:YES];
            weakSelf.mbp = nil;
        }
    }];
     */
}

//支付宝支付
-(void)alipayPayWithPayModel:(PayModel *)payModel{
    
    self.payModel = payModel;
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017011004975973";
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCwfsi+AutkT9kDWp5gMptYm1boyk9+paI/7dV3bZjFOR4iMyoIbEjN9rFsgoSa/31EPNxvtWnE2n5hm8OVjwTreCe6xweLSeGOYrui+uQjoJbl+SiG5VTtLgDWz2hU9+QjJI9+rCqzzs1B0WhktpZ7JJLMIZGeZ7gnRIdGry8aly8VeQPBMr0fqVg4lmYJYOek+/yU5F2XVOujzZJNSrop40+b9EeAfxXKi8juSUcKiC2+fbXQcjSXHxlmn8nPcKLXvcGPq6hbd01+hjHQVOZdGBijDnUl0DyS4fOgBWoNvEOYuC06qtawBbe7Y/HUnaUfAlxJ/nAy8pMwEkdOWJvRAgMBAAECggEBAKyOKCFtpUpbrqZS0IjosWy94wiR04rU0X6DPrMW2cfpAgcZ0ryNcdi8mdam/JK1u3kdr78ftJsbq3gu29e7DmpQ/TblJAEQaI/XA/BiLu6OMToCkZbhXFjPI07hVPXNrqSVOB32oYFObOsum0vsH8+hgExHfaFLcoYhv8hhukHZcWtVFLQD/p/XwN20wgkRfcNx3LVcZM7vOGLIGMm0mU/JvPJUl9eO2yHWZz0CDfLyFgnHgmJB+nLpRySISHsdk1o/HmoBpnar49X+18udj1mONCxi3UT2tRRf3lMYGMt0YtdKc0DgYRI2r6CXfs3KdncfzmTvG/wvftEb7IVW+AECgYEA4evSGYmWjPq0vjOXO4p6F4v1oEfYQs8vi3uxRpJsRZg79tTwMDXWnz/zBzXqlEWozqFUtZ3RDNX3Rhzp0ZiwHop9nug+4DomLjFgiAypDT9WJrFBAKjvDDAvO/nw3Jjn596C/LD1LH8Fy5oKrqiW7QhIielESMibfQ5oWR/gbxECgYEAx/5bJ4SZKj1lz9jx918bt2UCryb7nnbZDv6YustZLm64zbzmycXNBqj0mSU9JjcuI/mOHX4qK4fUuKGq277FQOJphFIRPudNc9YIvMfQJXKQuRylFksc/+rRIqpIIBi7NdAAXEo/nAmTAkqh6KfOWetXywX8bwPy2rW0pcGW4MECgYARXDms1LHI64rwAq7gWGfBX3PkeSDZIWqZ4UtiDOZdArG46ev7CGgRnKxkJXR9KE0sc6E6w4HI5rg1nwsom/8Mmb/FcjtCp7U/X3P3gGGNLwzDtGM2VcTovtsiVLZ5fRZ07thJ6p8saCZd2txvR20xka1hS5d/sEqidXT3REfOwQKBgQCekvO79ctsTpp3n1DcD7FuTM1AC+zezOV2mjCHi8z+oBQwLWPhANF8QmMPOxOtRXt0Ut94Sx0svtrQOn+7FRxaQivgGyJJeiVTf5YV+Wj1CE3wOOI9NvmbgZipn9LogDOQi4h9pPGiy4ShAIQ4cTWQ3qYR+IEblUnuWL0P4Nu9AQKBgAcJIo48+G24n6CLkE8RZjdOb0L3tj8i+2juzdUAuHqCDOVoAlLBUOz8k+6RgKF/1/G5O9XgCLeBYK1g/s3Q3w3emzTn5AaBxIGPRm0LG2y8WSY9H2xsiNizmSqSuplYCoK8xyQv0AmXnntq3A4tE+4SecY7oOrpgETOnRJ/k3FV";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    /*
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    // NOTE: app_id设置
    order.app_id = appID;
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    // NOTE: 支付版本
    order.version = @"1.0";
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = [NSString stringWithFormat:@"ios景好云导游APP客户端，支付%@景区的服务费用",self.scenicModel.scenic_name];
    order.biz_content.subject =[NSString stringWithFormat:@"%@景区智能导游授权",self.scenicModel.scenic_name];
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%@",self.scenicModel.cost_money] ; //商品价格
    //    [NSString stringWithFormat:@"%.2f",0.01];
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"com.zhaoyehua.alypay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
        }];
    }
     */
}

- (NSString *)generateTradeNO{
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
    
    PayReq *req = [[PayReq alloc] init];
    req.openID = [dic objectForKey:@"appid"];
    req.partnerId = [dic objectForKey:@"partnerid"];
    req.prepayId = [dic objectForKey:@"prepayid"];
    req.package = [dic objectForKey:@"package"];
    req.nonceStr = [dic objectForKey:@"noncestr"];
    req.timeStamp = [[dic objectForKey:@"timestamp"] intValue];
    req.sign = [dic objectForKey:@"sign"];
    [WXApi sendReq:req];
}

@end
