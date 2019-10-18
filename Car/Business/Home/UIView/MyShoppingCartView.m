//
//  MyShoppingCartView.m
//  Car
//
//  Created by xianjun wang on 2019/10/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MyShoppingCartView.h"
#import "SHImageAndTitleBtn.h"
#import "GoodsCell.h"
#import "OilGoodModel.h"

static NSString * GoodsCellId = @"GoodsCell";

@interface MyShoppingCartView ()<UITableViewDelegate,UITableViewDataSource>

//顶部灰色view
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * tableHeadView;
//中间tableView
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<OilGoodModel *> * dataArray;

@end

@implementation MyShoppingCartView

#pragma mark  ----  懒加载

-(UIView *)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.39];
        _topView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        __weak typeof(self) weakSelf = self;
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
           
            [weakSelf removeFromSuperview];
        }];
    }
    return _topView;
}

-(UIView *)tableHeadView{
    
    if (!_tableHeadView) {
        
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 39)];
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT12;
        titleLabel.textColor = Color_333333;
        titleLabel.text = @"我的购物车";
        [_tableHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.offset(10);
            make.width.offset(170);
            make.height.offset(18);
        }];
        
        SHImageAndTitleBtn * emptyShoppingCartBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 16 - 61, 14, 61, 12) andImageFrame:CGRectMake(0, 0, 12,12) andTitleFrame:CGRectMake(15, 0, 49, 12) andImageName:@"" andSelectedImageName:@"qingkong" andTitle:@"清空购物车"];
        [emptyShoppingCartBtn refreshFont:FONT9];
        [emptyShoppingCartBtn refreshTitle:@"清空购物车" color:Color_999999];
        [[emptyShoppingCartBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
        [_tableHeadView addSubview:emptyShoppingCartBtn];
    }
    return _tableHeadView;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.tableHeadView;
    }
    return _tableView;
}

-(NSMutableArray<OilGoodModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithArray:(NSMutableArray<OilGoodModel *> *)array{
    
    self = [super init];
    if (self) {
        
        [self.dataArray addObjectsFromArray:array];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ---- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 114;
}

#pragma mark  ---- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsCellId];
    if (!cell) {
        
        cell = [[GoodsCell alloc] initWithReuseIdentifier:GoodsCellId];
    }
    
    OilGoodModel * goodModel = self.dataArray[indexPath.row];
    [cell show:goodModel];
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(168);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.offset(-57 - [UIScreenControl bottomSafeHeight]);
    }];
}

@end
