//
//  CarChatFuntion.m
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarChatFuntion.h"
#import "UserInforController.h"
#import "LoginViewController.h"
@implementation CarChatFuntion


- (void)onUserStatus:(NSNotification *)notification
{
    TUIUserStatus status = [notification.object integerValue];
    switch (status) {
        case TUser_Status_ForceOffline:
        {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"您的帐号于另一台手机上登录,请重新登录" preferredStyle:
                                          UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                LoginViewController * vc = [[LoginViewController alloc] init];
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
                nav.hidesBottomBarWhenPushed = YES;
                nav.modalPresentationStyle = UIModalPresentationFullScreen;
                [[UIViewController topMostController] presentViewController:nav animated:YES completion:nil];
            }];
            [alertVc addAction:action1];
            [[UIViewController topMostController] presentViewController:alertVc animated:YES completion:nil];
        }
            break;
        case TUser_Status_ReConnFailed:
        {
            NSLog(@"连网失败");
        }
            break;
        case TUser_Status_SigExpired:
        {
            NSLog(@"userSig过期");
            
        }
            break;
        default:
            break;
    }
}

+(instancetype)shareInterface
{
    static CarChatFuntion *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[CarChatFuntion alloc]init];
        }
    });
    return manager;
}
-(void)chatLogin{
    TIMLoginParam *param = [[TIMLoginParam alloc] init];
    param.identifier = [UserInforController sharedManager].userInforModel.phone;
    param.userSig = [GenerateTestUserSig genTestUserSig:[UserInforController sharedManager].userInforModel.phone];
    [[TIMManager sharedInstance] login:param succ:^{
        NSLog(@"登录成功");
        [self setUserInfo];
    } fail:^(int code, NSString *msg) {
        NSLog(@"登录失败----%@",msg);
    }];
}
-(void)setUserInfo{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserStatus:) name:TUIKitNotification_TIMUserStatusListener object:nil];
    
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_Nick:[UserInforController sharedManager].userInforModel.shop_name,TIMProfileTypeKey_FaceUrl:[UserInforController sharedManager].userInforModel.avatar} succ:nil fail:nil];
    [[TIMManager sharedInstance]getLoginUser];
    
}
-(void)requetPostInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    NSString *url = interface;
    
    
    if ([interface isEqualToString:CategoryShopDetail]) {
        _httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else{
        _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [self.httpManager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResponse:task response:responseObject handler:handler interface:interface url:url parameter:para];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求网址:%@\n请求参数:%@",url, para);
        
        //        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
    }];
}
-(void)requetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    [self requetGetInterface:interface withParameter:para handler:handler];
}
-(void)requetGetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    [self.httpManager GET:interface parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResponse:task response:responseObject handler:handler interface:interface url:interface parameter:para];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求网址:%@\n请求参数:%@",interface, para);
        
        //        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
    }];
}
-(void)dealResponse:(NSURLSessionDataTask *_Nonnull)task response:(id  _Nullable)responseObject handler:(InterfaceHandler)handler interface:(NSString *)interface url:(NSString *)url parameter:(NSDictionary *)para
{
    NSDictionary *info = responseObject;
    NSData *data = [NSJSONSerialization dataWithJSONObject:info options:kNilOptions error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"请求网址:%@\n请求参数:%@", url, para);
    NSLog(@"返回:%@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSLog(@"快快快------%@",dic);
    handler(dic,nil);
    
    //    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
}
-(AFHTTPSessionManager *)httpManager
{
    if (!_httpManager) {
        _httpManager = [[AFHTTPSessionManager alloc]init];
        _httpManager.responseSerializer.acceptableContentTypes = [_httpManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data"]];
        _httpManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [_httpManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _httpManager.requestSerializer.timeoutInterval = 15;
        [_httpManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        //不序列化
//            _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
//            _httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _httpManager;
}





+(UIColor *)GradualChangeColor:(NSArray *)colors ViewSize:(CGSize)ViewSize gradientType:(GradientType)gradientType
{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(ViewSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, ViewSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(ViewSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(ViewSize.width, ViewSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(ViewSize.width, 0.0);
            end = CGPointMake(0.0, ViewSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
