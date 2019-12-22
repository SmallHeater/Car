//
//  HoverChildViewController.m
//  HoverDome_OC
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 com.etraffic.EasyCharging. All rights reserved.
//

#import "HoverChildViewController.h"

@interface HoverChildViewController ()

@end

@implementation HoverChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)){
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
