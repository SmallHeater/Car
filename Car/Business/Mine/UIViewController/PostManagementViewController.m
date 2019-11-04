//
//  PostManagementViewController.m
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostManagementViewController.h"
#import "SHTabView.h"


static NSUInteger tabBaseTag = 1650;

@interface PostManagementViewController ()

@property (nonatomic,strong) SHTabView * tabView;

@end

@implementation PostManagementViewController

#pragma mark  ----  懒加载

-(SHTabView *)tabView{
    
    if (!_tabView) {
        
        float tabWidth = MAINWIDTH / 3.0;
        
        NSMutableArray * tabModelsArray = [[NSMutableArray alloc] init];
        NSArray * tabTitleArray = @[@"我的帖子",@"我的回帖",@"回复我的"];
        for (NSUInteger i = 0; i < 3; i++) {
            
            SHTabModel * myPostModel = [[SHTabModel alloc] init];
            myPostModel.tabTitle = tabTitleArray[i];
            myPostModel.normalFont = FONT16;
            myPostModel.normalColor = Color_333333;
            myPostModel.selectedColor = Color_0272FF;
            myPostModel.btnWidth = tabWidth;
            myPostModel.tabTag = tabBaseTag + i;
            [tabModelsArray addObject:myPostModel];
        }
        
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineWidth = tabWidth;
        lineModel.lineHeight = 1;
        
        _tabView = [[SHTabView alloc] initWithItemsArray:tabModelsArray showRightBtn:NO andSHTabSelectLineModel:lineModel isShowBottomLine:NO];
        _tabView.layer.shadowColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:0.23].CGColor;
        _tabView.layer.shadowOffset = CGSizeMake(1,5);
        _tabView.layer.shadowOpacity = 1;
        _tabView.layer.shadowRadius = 9;
        _tabView.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
        //利用贝瑟尔曲线设置局部阴影
        CGRect shadowRect = CGRectZero;
        CGFloat originX,originY,sizeWith,sizeHeight,shadowPathWidth;
        originX = 0;
        originY = 0;
        sizeWith = MAINWIDTH;
        sizeHeight = 44;
        shadowPathWidth = 4;
        shadowRect = CGRectMake(0, sizeHeight, sizeWith, shadowPathWidth);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
        _tabView.layer.shadowPath = bezierPath.CGPath;//阴影路径
    }
    return _tabView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}


#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.height.offset(44);
    }];
}


@end
