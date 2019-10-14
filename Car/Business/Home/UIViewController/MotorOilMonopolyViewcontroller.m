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


#define ITEMBTNBASETAG 1000

@interface MotorOilMonopolyViewcontroller ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) NSMutableArray<NSString *> * tabTitleArray;
//页签view
@property (nonatomic,strong) SHTabView * baseTabView;
//底部悬浮view
@property (nonatomic,strong) UIView * bottomView;
//门店模型
@property (nonatomic,strong) ShopModel * shopModel;
//头部背景图地址
@property (nonatomic,strong) NSString * headImageUrlStr;

@end

@implementation MotorOilMonopolyViewcontroller

#pragma mark  ----  懒加载

-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 176 + [UIScreenControl liuHaiHeight])];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView = [[UIImageView alloc] init];
        __weak typeof(self) weak = self;
        [[self rac_valuesForKeyPath:@"headImageUrlStr" observer:self] subscribeNext:^(id  _Nullable x) {
           
            if (![NSString strIsEmpty:weak.headImageUrlStr]) {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:weak.headImageUrlStr]];
            }
        }];
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
                        if (weakSelf.shopModel.categorys.count > 0) {
                            
                            if (weakSelf.shopModel.images && [weakSelf.shopModel.images isKindOfClass:[NSArray class]] && weakSelf.shopModel.images.count > 0) {
                                
                                weakSelf.headImageUrlStr = weakSelf.shopModel.images[0];
                            }
                            ShopCategoryModel * firstModel = weakSelf.shopModel.categorys[0];
                            if (firstModel && [firstModel isKindOfClass:[ShopCategoryModel class]]) {
                                
                                [weakSelf requestGoodsDataWithTypeId:[[NSString alloc] initWithFormat:@"%ld",firstModel.CategoryId]];
                            }
                            
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

//获取商品数据
-(void)requestGoodsDataWithTypeId:(NSString *)typeId{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"type_id":typeId};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetGoodsByType,@"bodyParameters":bodyParameters};
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
