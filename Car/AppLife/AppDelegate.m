//
//  AppDelegate.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ForumViewController.h"
#import "WorkbenchViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "UserInforController.h"
#import "PLeakSniffer.h"
#import "AvoidCrash.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import <Bugly/Bugly.h>
#import "MotorOilController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //容灾
    [AvoidCrash becomeEffective];
    //Bugly
    [Bugly startWithAppId:@"af9aecbea0"];
    
    
//    if ([UserInforController sharedManager].userInforModel) {
        
        HomeViewController * homeVC = [[HomeViewController alloc] init];
        UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        homeNav.tabBarItem.title = @"首页";
        homeNav.tabBarItem.image = [UIImage imageNamed:@"shouye"];
        homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye"];
        
        ForumViewController * forumVC = [[ForumViewController alloc] init];
        UINavigationController * forumNav = [[UINavigationController alloc] initWithRootViewController:forumVC];
        forumNav.tabBarItem.title = @"论坛";
        forumNav.tabBarItem.image = [UIImage imageNamed:@"luntan"];
        forumNav.tabBarItem.selectedImage = [UIImage imageNamed:@"luntan"];
        
        WorkbenchViewController * workbenchVC = [[WorkbenchViewController alloc] init];
        UINavigationController * workbenchNav = [[UINavigationController alloc] initWithRootViewController:workbenchVC];
        workbenchNav.tabBarItem.title = @"工作台";
        workbenchNav.tabBarItem.image = [UIImage imageNamed:@"gongzuotai"];
        workbenchNav.tabBarItem.selectedImage = [UIImage imageNamed:@"gongzuotai"];
        
        MineViewController * mineVC = [[MineViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
        UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
        mineNav.tabBarItem.title = @"我的";
        mineNav.tabBarItem.image = [UIImage imageNamed:@"wode"];
        mineNav.tabBarItem.selectedImage = [UIImage imageNamed:@"wode"];
        
        UITabBarController * tarBarController = [[UITabBarController alloc] init];
        tarBarController.delegate = self;
        self.window.rootViewController = tarBarController;
        tarBarController.viewControllers = @[homeNav,forumNav,workbenchNav,mineNav];
        tarBarController.selectedIndex = 0;
//    }
//    else{
//
//        self.window.rootViewController = [[LoginViewController alloc] init];
//    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
            
            if (orderState==9000) {
                
                [[MotorOilController sharedManager] initializationAllOil];
                //支付宝支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ALIPAYRESULT" object:nil userInfo:@{@"state":[NSNumber numberWithInt:1]}];
            }else{
                
                //支付宝支付失败
                NSString *returnStr;
                switch (orderState) {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        break;
                    case 6001:
                        returnStr=@"订单取消";
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        break;
                        
                    default:
                        break;
                }
                
                [MBProgressHUD wj_showError:returnStr];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ALIPAYRESULT" object:nil userInfo:@{@"state":[NSNumber numberWithInt:0]}];
            }

        }];
    }
    else if ([url.host isEqualToString:@"pay"]){ //微信支付的回调
        
        NSString *result = [url absoluteString];
        NSArray *array = [result componentsSeparatedByString:@"="];
        NSString *resultNumber = [array lastObject];
        if ([resultNumber integerValue] == 0){ //成功
            
            [[MotorOilController sharedManager] initializationAllOil];
            //发送支付成功的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:NoticePaySuccess object:nil];
        }else if ([resultNumber integerValue] == -1) { //错误
            //发送支付失败的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:NoticePayFailure object:nil];
        }else if ([resultNumber integerValue] == -2){ //用户取消
            //发送支付取消的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:NoticePayCancel object:nil];
        }
    }
    return YES;
}

#pragma mark  ----  代理

#pragma mark  ----  UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    BOOL canSelect = YES;
    UINavigationController * nav = (UINavigationController * )viewController;
    if ([NSStringFromClass([nav.viewControllers.firstObject class]) isEqualToString:@"WorkbenchViewController"] || [NSStringFromClass([nav.viewControllers.firstObject class]) isEqualToString:@"MineViewController"]) {
        
        if ([[UserInforController sharedManager].userInforModel.userID isEqualToString:@"0"]) {
            
            //未登录
            canSelect = NO;
            LoginViewController * vc = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.hidesBottomBarWhenPushed = YES;
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [[UIViewController topMostController] presentViewController:nav animated:YES completion:nil];
        }
    }
    return canSelect;
}
@end
