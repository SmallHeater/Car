//
//  MyShoppingCartView.m
//  Car
//
//  Created by xianjun wang on 2019/10/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MyShoppingCartView.h"
#import "SHImageAndTitleBtn.h"
#import "SPGoodsCell.h"
#import "OilGoodModel.h"
#import "UIViewController+SHTool.h"

static NSString * SPGoodsCellID = @"SPGoodsCell";

@interface MyShoppingCartView ()<UITableViewDelegate,UITableViewDataSource>

//顶部灰色view
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * tableHeadView;
//中间tableView
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<OilGoodModel *> * dataArray;
//箱数目
@property (nonatomic,strong) NSString * countStr;

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
            //发送通知，通知机油商品页面刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOPPINGCARTREMOVE" object:nil];
        }];
        [_topView addGestureRecognizer:tap];
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
        [[self rac_valuesForKeyPath:@"countStr" observer:self] subscribeNext:^(id  _Nullable x) {
           
            if (![NSString strIsEmpty:x]) {
                
                NSString * str = [[NSString alloc] initWithFormat:@"%@(总计:%@箱)",@"我的购物车",x];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSFontAttributeName:FONT12,NSForegroundColorAttributeName:Color_333333} range:NSMakeRange(0, 5)];
                [attStr addAttributes:@{NSFontAttributeName:FONT10,NSForegroundColorAttributeName:Color_FF4C4B} range:NSMakeRange(5, str.length - 5)];
                titleLabel.attributedText = attStr;
            }
        }];
        [_tableHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.offset(10);
            make.width.offset(170);
            make.height.offset(18);
        }];
        
        SHImageAndTitleBtn * emptyShoppingCartBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 16 - 61, 14, 61, 12) andImageFrame:CGRectMake(0, 0, 12,12) andTitleFrame:CGRectMake(15, 0, 49, 12) andImageName:@"qingkong" andSelectedImageName:@"qingkong" andTitle:@"清空购物车"];
        [emptyShoppingCartBtn refreshFont:FONT9];
        [emptyShoppingCartBtn refreshTitle:@"清空购物车" color:Color_999999];
        __weak typeof(self) weakSelf = self;
        [[emptyShoppingCartBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            
            UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要清空购物车" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                for (OilGoodModel * goodModel in weakSelf.dataArray) {
                    
                    goodModel.count = 0;
                }
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.tableView reloadData];
                [weakSelf setCount];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GOODSVARIETY" object:nil];
            }];
            
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertControl addAction:sureAction];
            [alertControl addAction:cancleAction];
            
            [[UIViewController topMostController] presentViewController:alertControl animated:YES completion:nil];
            x.userInteractionEnabled = YES;
        }];
        [_tableHeadView addSubview:emptyShoppingCartBtn];
        
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = Color_EEEEEE;
        [_tableHeadView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.offset(0);
            make.height.offset(1);
        }];
    }
    return _tableHeadView;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        [self setCount];
        [self addNotification];
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
    
    SPGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:SPGoodsCellID];
    if (!cell) {
        
        cell = [[SPGoodsCell alloc] initWithReuseIdentifier:SPGoodsCellID];
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

-(void)setCount{
    
    NSUInteger count = 0;
    for (OilGoodModel * goodModel in self.dataArray) {
        
        count += goodModel.count;
    }
    
    self.countStr = [[NSString alloc] initWithFormat:@"%ld",count];
}

-(void)addNotification{
    
    __weak typeof(self) weakSelf = self;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"OILCOUNTZERO" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        [weakSelf refreshDataArray];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"GOODSVARIETY" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       
        [weakSelf setCount];
    }];
}

//刷新数据源（有机油j数量减为零）
-(void)refreshDataArray{
    
    for (OilGoodModel * goodModel in self.dataArray) {
        
        if (goodModel.count == 0) {
            
            [self.dataArray removeObject:goodModel];
            break;
        }
    }
    [self setCount];
    [self.tableView reloadData];
}

@end
