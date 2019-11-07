//
//  BaseUIViewController.m
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 IP. All rights reserved.
//

#import "SHBaseUIViewController.h"



@interface SHBaseUIViewController ()

//是否显示返回按钮
@property (nonatomic,assign) BOOL isShowBackBtn;

@end

@implementation SHBaseUIViewController

#pragma mark  ----  懒加载
-(SHNavigationBar *)navigationbar{
    
    if (!_navigationbar) {
        
        _navigationbar = [[SHNavigationBar alloc] initWithTitle:self.navTitle andShowBackBtn:self.isShowBackBtn];
        [_navigationbar addbackbtnTarget:self andAction:@selector(backBtnClicked:)];
    }
    return _navigationbar;
}

#pragma mark  ----  SET

-(void)setNavTitle:(NSString *)navTitle{
    
    _navTitle = navTitle;
    self.navigationbar.navTitle = navTitle;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn{

    self = [super init];
    if (self) {
        
        self.isShowBackBtn = isShowBackBtn;
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.navTitle = title;
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNav];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

#pragma mark  ----  自定义函数
-(void)addNav{
    
    [self.view addSubview:self.navigationbar];
    [self.navigationbar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset([SHUIScreenControl navigationBarHeight]);
    }];
}

-(void)backBtnClicked:(UIButton *)btn{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


@end