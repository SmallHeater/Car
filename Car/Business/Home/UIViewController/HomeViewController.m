//
//  HomeViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavgationBar.h"


@interface HomeViewController ()

@property (nonatomic,strong) HomeNavgationBar * homeNavgationBar;

@end

@implementation HomeViewController

#pragma mark  ----  懒加载

-(HomeNavgationBar *)homeNavgationBar{
    
    if (!_homeNavgationBar) {
        
        _homeNavgationBar = [[HomeNavgationBar alloc] init];
        _homeNavgationBar.backgroundColor = [UIColor greenColor];
    }
    return _homeNavgationBar;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.homeNavgationBar];
    [self.homeNavgationBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(31 + [UIScreenControl liuHaiHeight]);
        make.height.offset(40);
    }];
}

@end
