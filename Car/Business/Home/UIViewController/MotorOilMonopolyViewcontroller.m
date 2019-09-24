//
//  MotorOilMonopolyViewcontroller.m
//  Car
//
//  Created by xianjun wang on 2019/9/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyViewcontroller.h"
#import "SHTabView.h"

#define ITEMBTNBASETAG 1000

@interface MotorOilMonopolyViewcontroller ()

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) NSMutableArray<NSString *> * tabTitleArray;
//页签view
@property (nonatomic,strong) SHTabView * baseTabView;
@end

@implementation MotorOilMonopolyViewcontroller

#pragma mark  ----  懒加载

-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [UIScreenControl liuHaiHeight])];
        _tableHeaderView.backgroundColor = [UIColor greenColor];
    }
    return _tableHeaderView;
}

-(NSMutableArray<NSString *> *)tabTitleArray{
    
    if (!_tabTitleArray) {
        
        _tabTitleArray = [[NSMutableArray alloc] initWithObjects:@"商品",@"评价",@"商家", nil];
    }
    return _tabTitleArray;
}

-(SHTabView *)baseTabView{
    
    if (!_baseTabView) {
        
        NSMutableArray * tabModelArray = [[NSMutableArray alloc] init];
        
        for (NSString * str in self.tabTitleArray) {
            
            SHTabModel * tabModel = [[SHTabModel alloc] init];
            tabModel.tabTitle = str;
            tabModel.normalFont = FONT14;
            tabModel.normalColor = Color_999999;
            tabModel.selectedFont = FONT14;
            tabModel.selectedColor = Color_108EE9;
            [tabModelArray addObject:tabModel];
        }
        
        _baseTabView = [[SHTabView alloc] initWithItemsArray:tabModelArray showRightBtn:NO];
        __weak typeof(self) weakSelf = self;
        [[_baseTabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - ITEMBTNBASETAG;
        }];
        _baseTabView.backgroundColor = [UIColor yellowColor];
    }
    return _baseTabView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.baseTabView;
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.navigationbar.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.tableHeaderView;
}

@end
