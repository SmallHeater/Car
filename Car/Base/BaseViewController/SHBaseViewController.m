//
//  SHBaseViewController.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//

#import "SHBaseViewController.h"

@interface SHBaseViewController ()

@end

@implementation SHBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


@end
