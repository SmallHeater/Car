//
//  MarketingViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MarketingViewController.h"
#import "SHTabView.h"
#import "AddNewVehicleVC.h"

@interface MarketingViewController ()

@property (nonatomic,strong) NSMutableArray<SHTabModel *> * tabModelArray;
@property (nonatomic,strong) SHTabView * baseTabView;
//问号按钮
@property (nonatomic,strong) UIButton * descriptionBtn;
//导航view
@property (nonatomic,strong) UIView * marketingNav;


@end

@implementation MarketingViewController

#pragma mark  ----  懒加载

-(NSMutableArray<SHTabModel *> *)tabModelArray{
    
    if (!_tabModelArray) {
        
        _tabModelArray = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < 1; i++) {
            
            SHTabModel * tabModel = [[SHTabModel alloc] init];
            tabModel.tabTitle = @"新增车辆";
            tabModel.normalFont = FONT15;
            tabModel.normalColor = Color_333333;
            tabModel.selectedFont = BOLDFONT21;
            tabModel.selectedColor = Color_333333;
            tabModel.btnWidth = [tabModel.tabTitle widthWithFont:tabModel.selectedFont andHeight:30] + 10;;
            [_tabModelArray addObject:tabModel];
        }
    }
    return _tabModelArray;
}

-(SHTabView *)baseTabView{
    
    if (!_baseTabView) {
        
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineHeight = 4;
        lineModel.lineWidth = 11;
        lineModel.lineCornerRadio = 2;
        _baseTabView = [[SHTabView alloc] initWithItemsArray:self.tabModelArray showRightBtn:NO andSHTabSelectLineModel:lineModel isShowBottomLine:NO];
    }
    return _baseTabView;
}

-(UIButton *)descriptionBtn{
    
    if (!_descriptionBtn) {
        
        _descriptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_descriptionBtn setImage:[UIImage imageNamed:@"shuoming"] forState:UIControlStateNormal];
        [[_descriptionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _descriptionBtn;
}

-(UIView *)marketingNav{
    
    if (!_marketingNav) {
        
        _marketingNav = [[UIView alloc] init];
        _marketingNav.backgroundColor = [UIColor whiteColor];
        _marketingNav.layer.shadowColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:0.3].CGColor;
        _marketingNav.layer.shadowOffset = CGSizeMake(0,5);
        _marketingNav.layer.shadowOpacity = 1;
        _marketingNav.layer.shadowRadius = 4;
        
        [_marketingNav addSubview:self.baseTabView];
        [self.baseTabView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.bottom.offset(0);
            make.height.offset(34);
            make.width.offset(100);
        }];
        
//        [_marketingNav addSubview:self.descriptionBtn];
//        [self.descriptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.bottom.offset(-5);
//            make.right.offset(-12);
//            make.width.height.offset(22);
//        }];
    }
    return _marketingNav;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
     [self.view addSubview:self.marketingNav];
     [self.marketingNav mas_makeConstraints:^(MASConstraintMaker *make) {
         
         make.left.right.top.offset(0);
         make.height.offset([SHUIScreenControl navigationBarHeight]);
     }];
    
    AddNewVehicleVC * vc = [[AddNewVehicleVC alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
    UIView * addNewVehicleView = vc.view;
    [self.view addSubview:addNewVehicleView];
    [addNewVehicleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.marketingNav.mas_bottom);
    }];
    [self addChildViewController:vc];
    [self.view bringSubviewToFront:self.marketingNav];
}

@end
