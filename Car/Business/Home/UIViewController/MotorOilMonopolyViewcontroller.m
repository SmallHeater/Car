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
#import "MotorOilMonopolyShopViewController.h"
#import "MyShoppingCartView.h"
#import "OilGoodModel.h"
#import "SelectPaymentMethodView.h"
#import "PayManager.h"
#import "MotorOilController.h"


#define ITEMBTNBASETAG 1000

@interface MotorOilMonopolyViewcontroller ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

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
@property (nonatomic,strong) MotorOilMonopolyGoodsViewController * goodsVC;
@property (nonatomic,strong) MotorOilMonopolyEvaluationViewController * evaVC;
@property (nonatomic,strong) MotorOilMonopolyShopViewController * shopVC;
//存放商品view,评价view,商家view的容器view
@property (nonatomic,strong) UIScrollView * bgScrollView;
//机油总价
@property (nonatomic,assign) float totalPrice;
//存放添加的机油商品模型的数组
@property (nonatomic,strong) NSMutableArray <OilGoodModel *> * goodsArray;
//支付选择view
@property (nonatomic,strong) SelectPaymentMethodView * paymentMethodView;
//结算方式
@property (nonatomic,strong) NSString * pay_type;
//我的购物车指针
@property (nonatomic,strong) MyShoppingCartView * carView;

//选中的索引
@property (nonatomic,assign) NSUInteger selectedIndex;

@end

@implementation MotorOilMonopolyViewcontroller

#pragma mark  ----  懒加载

-(MotorOilMonopolyHeaderView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[MotorOilMonopolyHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [SHUIScreenControl liuHaiHeight])];
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
        
        NSUInteger i = 0;
        for (NSString * str in self.tabTitleArray) {
            
            SHTabModel * tabModel = [[SHTabModel alloc] init];
            tabModel.tabTitle = str;
            tabModel.normalFont = FONT14;
            tabModel.normalColor = Color_999999;
            tabModel.selectedFont = FONT14;
            tabModel.selectedColor = Color_108EE9;
            tabModel.btnWidth = 60;
            tabModel.tabTag = ITEMBTNBASETAG + i;
            i++;
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
            [weakSelf.bgScrollView setContentOffset:CGPointMake(index * MAINWIDTH, 0) animated:YES];
        }];
    }
    return _baseTabView;
}

-(SelectPaymentMethodView *)paymentMethodView{
    
    if (!_paymentMethodView) {
        
        _paymentMethodView = [[SelectPaymentMethodView alloc] init];
        __weak typeof(self) weakSelf = self;
        [[_paymentMethodView rac_valuesForKeyPath:@"payMethod" observer:self] subscribeNext:^(id  _Nullable x) {
           
            if (![NSString strIsEmpty:x]) {
                
                weakSelf.pay_type = x;
            }
        }];
        
        [[_paymentMethodView rac_signalForSelector:@selector(sureBtnClicked)] subscribeNext:^(RACTuple * _Nullable x) {
           
            if (![NSString strIsEmpty:weakSelf.pay_type]) {
             
                [weakSelf settlement];
            }
        }];
    }
    return _paymentMethodView;
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
        [contactBtn refreshColor:[UIColor whiteColor]];
        __weak typeof(self) weakSelf = self;
        [[contactBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.userInteractionEnabled = NO;
            
            if (![NSString strIsEmpty:weakSelf.shopModel.phone]) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",weakSelf.shopModel.phone]] options:@{} completionHandler:nil];
            }
            
            x.userInteractionEnabled = YES;
        }];
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
        
        //价格总额
        float totalPrice = 0;
        for (OilBrandModel * oilBrandModel in [MotorOilController sharedManager].dataArray) {
            
            for (OilGoodModel * goodModel in oilBrandModel.goods) {
                
                if (goodModel.count > 0) {
                 
                    float price = 0;
                    if (goodModel.specs && [goodModel.specs isKindOfClass:[NSArray class]] && goodModel.specs.count > 0) {
                        
                        NSDictionary * dic = goodModel.specs[0];
                        NSNumber * priceNumber = dic[@"goods_price"];
                        price = priceNumber.floatValue;
                    }
                    
                    totalPrice += goodModel.count * price;
                }
            }
        }
        self.totalPrice = totalPrice;
        //价格总计
        UILabel * totalPriceLabel = [[UILabel alloc] init];
        totalPriceLabel.textColor = [UIColor whiteColor];
        totalPriceLabel.userInteractionEnabled = YES;
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"总计：¥%.2f",totalPrice]];
        [attStr addAttributes:@{NSFontAttributeName:FONT12} range:NSMakeRange(0, 3)];
        [attStr addAttributes:@{NSFontAttributeName:FONT18} range:NSMakeRange(3, attStr.length - 3)];
        totalPriceLabel.attributedText = attStr;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            if (weakSelf.carView) {
                
                [weakSelf.carView removeFromSuperview];
                weakSelf.carView = nil;
            }
            else{
             
                MyShoppingCartView * carView = [[MyShoppingCartView alloc] initWithArray:weakSelf.goodsArray];
                weakSelf.carView = carView;
                [weakSelf.view addSubview:carView];
                [carView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.top.bottom.offset(0);
                }];
                [weakSelf.view bringSubviewToFront:weakSelf.bottomView];
            }
        }];
        [totalPriceLabel addGestureRecognizer:tap];
        
        [_bottomView addSubview:totalPriceLabel];
        [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(lineLabel.mas_right).offset(10);
            make.top.bottom.offset(0);
            make.width.offset(180);
        }];
        
        [[self.goodsVC rac_valuesForKeyPath:@"priceStr" observer:self] subscribeNext:^(id  _Nullable x) {
            
            if (![NSString strIsEmpty:x]) {
             
                weakSelf.totalPrice = [x floatValue];
                
                NSString * str = [[NSString alloc] initWithFormat:@"总计：¥%@",x];
                NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
                [attStr addAttributes:@{NSFontAttributeName:FONT12} range:NSMakeRange(0, 3)];
                [attStr addAttributes:@{NSFontAttributeName:FONT18} range:NSMakeRange(3, attStr.length - 3)];
                totalPriceLabel.attributedText = attStr;
            }
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
        [[settlementBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.userInteractionEnabled = NO;
            if (weakSelf.totalPrice > 0) {
                
                weakSelf.paymentMethodView.totalAmount = weakSelf.totalPrice;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.paymentMethodView];
                [weakSelf.paymentMethodView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.top.bottom.offset(0);
                }];
            }
            x.userInteractionEnabled = YES;
        }];
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
        _bgScrollView.delegate = self;
        _bgScrollView.pagingEnabled = YES;
        float viewHeight = MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 47 - 5;
        _bgScrollView.contentSize = CGSizeMake(MAINWIDTH * 3, viewHeight);
        
        MotorOilMonopolyGoodsViewController * goodsVC = [[MotorOilMonopolyGoodsViewController alloc] init];
        goodsVC.parentTableView = self.tableView;
        __weak typeof(self) weakSelf = self;
        goodsVC.callBack = ^(NSMutableArray * _Nonnull dataArray) {
            
            if (dataArray && [dataArray isKindOfClass:[NSMutableArray class]]) {
             
                [weakSelf.goodsArray removeAllObjects];
                [weakSelf.goodsArray addObjectsFromArray:dataArray];
            }
        };
    
        goodsVC.canScrollCallBack = ^(BOOL canScroll) {
          
            weakSelf.tableView.scrollEnabled = canScroll;
        };
        
        self.goodsVC = goodsVC;
        UIView * goodsView = goodsVC.view;
        [_bgScrollView addSubview:goodsView];
        goodsView.frame = CGRectMake(0, 0, 0,viewHeight);
        [self addChildViewController:goodsVC];
        
        MotorOilMonopolyEvaluationViewController * evaluationVC = [[MotorOilMonopolyEvaluationViewController alloc] initWithShopId:self.shopModel.shopIdStr];
        self.evaVC = evaluationVC;
        evaluationVC.parentTableView = self.tableView;
        evaluationVC.canScrollCallBack = ^(BOOL canScroll) {
          
            weakSelf.tableView.scrollEnabled = canScroll;
        };
        [self addChildViewController:evaluationVC];
        UIView * evaluationView = evaluationVC.view;
        evaluationView.frame = CGRectMake(MAINWIDTH, 0, 0,viewHeight);
        [_bgScrollView addSubview:evaluationView];
        
        MotorOilMonopolyShopViewController * shopVC = [[MotorOilMonopolyShopViewController alloc] initWithShopModel:self.shopModel];
        self.shopVC = shopVC;
        shopVC.parentTableView = self.tableView;
        shopVC.canScrollCallBack = ^(BOOL canScroll) {
          
            weakSelf.tableView.scrollEnabled = canScroll;
        };
        [self addChildViewController:shopVC];
        UIView * shopView = shopVC.view;
        shopView.frame = CGRectMake(MAINWIDTH * 2, 0, 0,viewHeight);
        [_bgScrollView addSubview:shopView];
    }
    return _bgScrollView;
}

-(NSMutableArray<OilGoodModel *> *)goodsArray{
    
    if (!_goodsArray) {
        
        _goodsArray = [[NSMutableArray alloc] init];
    }
    return _goodsArray;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self requestListData];
    self.selectedIndex = 0;
}

#pragma mark  ----  代理

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[SHBaseTableView class]]) {
     
        float y = scrollView.contentOffset.y;
            if (y >= 92) {
                
                //已滑动到最大
        //        self.tableView.contentOffset = CGPointMake(0, 92);
                self.tableView.scrollEnabled = NO;
                if (self.selectedIndex == 0) {
                
                    self.goodsVC.canScroll = YES;
                    self.goodsVC.rightTableView.contentOffset = CGPointMake(0, y - 92);
                }
                else if (self.selectedIndex == 1){
                    
                    self.evaVC.canScroll = YES;
                }
                else if (self.selectedIndex == 2){
                    
                    self.shopVC.canScroll = YES;
                }
            }
            
            __weak typeof(self) weakSelf = self;
            if (y >= 176 - [SHUIScreenControl navigationBarHeight] - 20) {

                [UIView animateWithDuration:0.1 animations:^{

                    weakSelf.navigationbar.backgroundColor = [UIColor whiteColor];
                }];
            }
            else{

                [UIView animateWithDuration:0.1 animations:^{

                    weakSelf.navigationbar.backgroundColor = [UIColor clearColor];
                }];
            }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([NSStringFromClass(scrollView.class) isEqualToString:@"UIScrollView"]) {
     
        float index = scrollView.contentOffset.x / MAINWIDTH;
        if (self.selectedIndex != index) {
         
            self.selectedIndex = index;
            self.tableView.scrollEnabled = YES;
            [self.baseTabView selectItemWithIndex:index];
        }
    }
}


#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44;
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

#pragma mark  ----  UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.navigationbar.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(-20);
        make.left.right.bottom.offset(0);
    }];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [weakSelf.view addSubview:weakSelf.bottomView];
        [weakSelf.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(17);
            make.right.offset(-17);
            make.bottom.offset(-5 - [SHUIScreenControl bottomSafeHeight]);
            make.height.offset(47);
        }];
    });
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
                    [MBProgressHUD wj_showError:dic[@"msg"]];
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

//结算
-(void)settlement{
    
    //pay_type,结算方式;total_price,商品总价;pay_price,订单支付总价;
    NSString * total_priceStr = [[NSString alloc] initWithFormat:@"%.2f",self.totalPrice];
    
    NSMutableArray * goods = [[NSMutableArray alloc] init];
    for (OilGoodModel * model in self.goodsArray) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSNumber numberWithLong:model.goods_id] forKey:@"goods_id"];
        [dic setObject:[NSNumber numberWithLong:model.count] forKey:@"total_num"];
        [dic setObject:[NSNumber numberWithLong:model.spec_type] forKey:@"spec_type"];
        if (model.spec_type == 20) {
            
            if (model.specs && [model.specs isKindOfClass:[NSArray class]] && model.specs.count > 0) {
                
                NSDictionary * specDic = model.specs[0];
                [dic setObject:specDic[@"goods_spec_id"] forKey:@"goods_spec_id"];
                [dic setObject:specDic[@"spec_sku_id"] forKey:@"spec_sku_id"];
            }
        }
        [goods addObject:dic];
    }
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"pay_type":self.pay_type,@"total_price":total_priceStr,@"pay_price":total_priceStr,@"goods":goods,@"shop_id":[NSString stringWithFormat:@"%ld",self.shopModel.shopId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":OrderCreate,@"bodyParameters":bodyParameters};
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
                     
                        NSString * paramsStr = dataDic[@"params"];
                        if ([weakSelf.pay_type isEqualToString:@"wechat"]) {
                            
                            NSData *jsonData = [paramsStr dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                            //微信支付
                            [[PayManager sharedManager] weChatPayWithDic:dic];
                        }
                        else if ([weakSelf.pay_type isEqualToString:@"alipay"]){
                            
                            //支付宝支付
                            [[PayManager sharedManager] alipayPayWithOrderString:paramsStr];
                        }
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
