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
#import "MarketingViewController.h"
#import "WorkbenchViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "UserInforController.h"
#import "PLeakSniffer.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [[PLeakSniffer sharedInstance] installLeakSniffer];
//    [[PLeakSniffer sharedInstance] alertLeaks];
//    [[PLeakSniffer sharedInstance] addIgnoreList:@[@"AVCaptureSession",@"AVCaptureVideoDataOutput",@"CALayer"]];
    
//    //模拟器
//    UserInforModel * model = [[UserInforModel alloc] init];
//    model.userID = @"21";
//    [UserInforController sharedManager].userInforModel = model;
    
    if ([UserInforController sharedManager].userInforModel) {
        
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
        
        MarketingViewController * marketingVC = [[MarketingViewController alloc] init];
        UINavigationController * marketingNav = [[UINavigationController alloc] initWithRootViewController:marketingVC];
        marketingNav.tabBarItem.title = @"营销";
        marketingNav.tabBarItem.image = [UIImage imageNamed:@"yingxiao"];
        marketingNav.tabBarItem.selectedImage = [UIImage imageNamed:@"yingxiao"];
        
        MineViewController * mineVC = [[MineViewController alloc] init];
        UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
        mineNav.tabBarItem.title = @"我的";
        mineNav.tabBarItem.image = [UIImage imageNamed:@"wode"];
        mineNav.tabBarItem.selectedImage = [UIImage imageNamed:@"wode"];
        
        UITabBarController * tarBarController = [[UITabBarController alloc] init];
        self.window.rootViewController = tarBarController;
        tarBarController.viewControllers = @[homeNav,forumNav,workbenchNav,marketingNav,mineNav];
        tarBarController.selectedIndex = 2;
    }
    else{
        
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
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


@end
