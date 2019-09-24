//
//  MotorOilMonopolyViewcontroller.m
//  Car
//
//  Created by xianjun wang on 2019/9/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyViewcontroller.h"
#import "SHTabView.h"
#import "MotorOilMonopolyCell.h"

#define ITEMBTNBASETAG 1000

@interface MotorOilMonopolyViewcontroller ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) NSMutableArray<NSString *> * tabTitleArray;
//页签view
@property (nonatomic,strong) SHTabView * baseTabView;
//底部悬浮view
@property (nonatomic,strong) UIView * bottomView;

@end

@implementation MotorOilMonopolyViewcontroller

#pragma mark  ----  懒加载

-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [UIScreenControl liuHaiHeight])];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor yellowColor];
        [_tableHeaderView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.right.offset(0);
            make.height.offset(144);
        }];
        
        UIView * whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.cornerRadius = 4;
        whiteView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        whiteView.layer.shadowOffset = CGSizeMake(0,2);
        whiteView.layer.shadowOpacity = 1;
        whiteView.layer.shadowRadius = 10;
        [_tableHeaderView addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(9);
            make.right.offset(-9);
            make.bottom.offset(-8);
            make.height.offset(79);
        }];
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
            tabModel.btnWidth = 60;
            [tabModelArray addObject:tabModel];
        }
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineHeight = 2;
        lineModel.lineWidth = 22;
        lineModel.lineCornerRadio = 0;
        _baseTabView = [[SHTabView alloc] initWithItemsArray:tabModelArray showRightBtn:NO andSHTabSelectLineModel:lineModel isShowBottomLine:YES];
        __weak typeof(self) weakSelf = self;
        [[_baseTabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - ITEMBTNBASETAG;
        }];
    }
    return _baseTabView;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = Color_333333;
        _bottomView.layer.cornerRadius = 23.5;
        _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0,1);
        _bottomView.layer.shadowOpacity = 1;
        _bottomView.layer.shadowRadius = 5;
    }
    return _bottomView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self addRac];
}

#pragma mark  ----  代理

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}



#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return MAINHEIGHT - [UIScreenControl navigationBarHeight] - 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.baseTabView;
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * MotorOilMonopolyCellID = @"MotorOilMonopolyCell";
    MotorOilMonopolyCell * cell = [tableView dequeueReusableCellWithIdentifier:MotorOilMonopolyCellID];
    if (!cell) {
        
        cell = [[MotorOilMonopolyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MotorOilMonopolyCellID];
    }
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.navigationbar.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(-20);
        make.left.right.bottom.offset(0);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(17);
        make.right.offset(-17);
        make.bottom.offset(-5 - [UIScreenControl bottomSafeHeight]);
        make.height.offset(47);
    }];
}

//添加rac处理
-(void)addRac{
    
    [[[self.tableView rac_valuesForKeyPath:@"contentOffset" observer:self] throttle:0.1] subscribeNext:^(id  _Nullable x) {
       
        CGPoint point = [x CGPointValue];
        float y = point.y;
        NSLog(@"坐标：%lf",y);
        __weak typeof(self) weakSelf = self;
        if (y >= 176 - [UIScreenControl navigationBarHeight] - 20) {

            [UIView animateWithDuration:0.5 animations:^{

                weakSelf.navigationbar.backgroundColor = [UIColor whiteColor];
            }];
        }
        else{

            [UIView animateWithDuration:0.5 animations:^{

                weakSelf.navigationbar.backgroundColor = [UIColor clearColor];
            }];
        }
    }];
}

@end
