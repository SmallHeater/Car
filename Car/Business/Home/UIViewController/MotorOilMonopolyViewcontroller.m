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
#import "SHImageAndTitleBtn.h"
#import "UserInforController.h"
#import "ShopModel.h"
#import "MotorOilMonopolyHeaderView.h"
#import "MotorOilMonopolyGoodsViewController.h"
#import "MotorOilMonopolyEvaluationViewController.h"


#define ITEMBTNBASETAG 1000

@interface MotorOilMonopolyViewcontroller ()<UIScrollViewDelegate>

@property (nonatomic,strong) MotorOilMonopolyHeaderView * tableHeaderView;
@property (nonatomic,strong) NSMutableArray<NSString *> * tabTitleArray;
//页签view
@property (nonatomic,strong) SHTabView * baseTabView;
//底部悬浮view
@property (nonatomic,strong) UIView * bottomView;
//门店模型
@property (nonatomic,strong) ShopModel * shopModel;
//头部背景图地址
@property (nonatomic,strong) NSString * headImageUrlStr;
//存放商品view,评价view,商家view的容器view
@property (nonatomic,strong) UIScrollView * bgScrollView;

@end

@implementation MotorOilMonopolyViewcontroller

#pragma mark  ----  懒加载

-(MotorOilMonopolyHeaderView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[MotorOilMonopolyHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [UIScreenControl liuHaiHeight])];
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
        
        //联系商家
        SHImageAndTitleBtn * contactBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(14, 0, 53, 47) andImageFrame:CGRectMake(13, 5, 22, 22) andTitleFrame:CGRectMake(0, 28, 53, 14) andImageName:@"lianxishangjia" andSelectedImageName:@"" andTitle:@"联系商家"];
        [contactBtn refreshFont:FONT10];
        [contactBtn refreshTitle:@"联系商家" color:[UIColor whiteColor]];
        [_bottomView addSubview:contactBtn];
        //分割线
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(67);
            make.top.bottom.offset(0);
            make.width.offset(1);
        }];
        
        //价格总计
        UILabel * totalPriceLabel = [[UILabel alloc] init];
        totalPriceLabel.textColor = [UIColor whiteColor];
        totalPriceLabel.text = @"总计：¥1080.00";
        [_bottomView addSubview:totalPriceLabel];
        [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(lineLabel.mas_right).offset(10);
            make.top.bottom.offset(0);
            make.width.offset(180);
        }];
        
        //去结算按钮
        UIButton * settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settlementBtn.layer.masksToBounds = YES;
        settlementBtn.layer.cornerRadius = 23;
        settlementBtn.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
        [settlementBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settlementBtn setBackgroundColor:Color_0272FF];
        settlementBtn.titleLabel.font = FONT16;
        [_bottomView addSubview:settlementBtn];
        [settlementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.offset(80);
            make.top.right.bottom.offset(0);
        }];
    }
    return _bottomView;
}

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
        float viewHeight = MAINHEIGHT - [UIScreenControl navigationBarHeight] - 44;
        _bgScrollView.contentSize = CGSizeMake(MAINWIDTH * 3, viewHeight);
        
        MotorOilMonopolyGoodsViewController * goodsVC = [[MotorOilMonopolyGoodsViewController alloc] init];
        [self addChildViewController:goodsVC];
        UIView * goodsView = goodsVC.view;
        goodsView.frame = CGRectMake(0, 0, MAINWIDTH,viewHeight);
        [_bgScrollView addSubview:goodsView];
        
        MotorOilMonopolyEvaluationViewController * evaluationVC = [[MotorOilMonopolyEvaluationViewController alloc] initWithShopId:self.shopModel.shopIdStr];
        [self addChildViewController:evaluationVC];
        UIView * evaluationView = evaluationVC.view;
        evaluationView.frame = CGRectMake(MAINWIDTH, 0, MAINWIDTH,viewHeight);
        [_bgScrollView addSubview:evaluationView];
        
    }
    return _bgScrollView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self requestListData];
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
    
    NSUInteger rows = 0;
    if (self.shopModel) {
        
        rows = 1;
    }
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * MotorOilMonopolyCellID = @"MotorOilMonopolyCell";
    MotorOilMonopolyCell * cell = [tableView dequeueReusableCellWithIdentifier:MotorOilMonopolyCellID];
    if (!cell) {
        
        cell = [[MotorOilMonopolyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MotorOilMonopolyCellID];
        [cell addSubview:self.bgScrollView];
        [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.bottom.offset(0);
        }];
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

//获取门店数据
-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetAgentShop,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
                NSNumber * code = dic[@"code"];
                
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        weakSelf.shopModel = [ShopModel mj_objectWithKeyValues:dataDic[@"shop"]];
                        [weakSelf.tableHeaderView show:weakSelf.shopModel];
                        [weakSelf.tableView reloadData];
                    }
                }
                else{
                    
                    //异常
                }
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

@end
