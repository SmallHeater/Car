//
//  HomeViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavgationBar.h"
#import "CarouselCell.h"
#import "BaseWKWebViewController.h"
#import "ItemsCell.h"
#import "CarouselModel.h"
#import "TabModel.h"
#import "UserInforController.h"
#import "HomeDataModel.h"
#import "SHImageAndTitleBtn.h"
#import "SHTabView.h"
#import "ItemNewsCell.h"
#import "ResidualTransactionViewController.h"
#import "JobRecruitmentViewController.h"
#import "MotorOilMonopolyViewcontroller.h"
#import "PostViewController.h"
#import "PostResidualTransactionViewController.h"
#import "PostJobViewController.h"
#import "PostListViewController.h"
#import "FrameNumberInquiryViewController.h"

#define BASEBTNTAG 1800
#define ITEMBTNBASETAG 1000

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) HomeNavgationBar * homeNavgationBar;
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) HomeDataModel * homeDataModel;
@property (nonatomic,strong) SHTabView * baseTabView;
//发布view
@property (nonatomic,strong) UIView * releaseView;

@end

@implementation HomeViewController

#pragma mark  ----  懒加载

-(HomeNavgationBar *)homeNavgationBar{
    
    if (!_homeNavgationBar) {
        
        _homeNavgationBar = [[HomeNavgationBar alloc] init];
        //点击扫二维码的响应
        [[_homeNavgationBar rac_signalForSelector:@selector(sacnningBtnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
           
            [SHRoutingComponent openURL:SCAN callBack:^(NSDictionary *resultDic) {
               
                NSString * result = resultDic[@"result"];
            }];
        }];
        
        //点击发布的响应
        __weak typeof(self) weakSelf = self;
        [[_homeNavgationBar rac_signalForSelector:@selector(releaseBtnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.releaseView];
            [weakSelf.releaseView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.right.top.bottom.offset(0);
            }];
        }];
    }
    return _homeNavgationBar;
}

-(UIView *)releaseView{
    
    if (!_releaseView) {
        
        _releaseView = [[UIView alloc] init];
        _releaseView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        __weak typeof(self) weakSelf = self;
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
        }];
        [_releaseView addGestureRecognizer:tap];
        
        UIView * whiteBGView = [[UIView alloc] init];
        whiteBGView.backgroundColor = [UIColor whiteColor];
        //按钮宽度
        float btnWidth = 60;
        //按钮间距
        float interval = (MAINWIDTH - 25 * 2 - btnWidth * 4) / 3;
        //发布帖子按钮
        SHImageAndTitleBtn * postBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(25, 14, btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"fabutiezi" andSelectedImageName:@"fabutiezi" andTitle:@"发布帖子"];
        [[postBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
            PostViewController * vc = [[PostViewController alloc] initWithTitle:@"发布帖子" andIsShowBackBtn:YES];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:postBtn];
        
        //发布残值按钮
        SHImageAndTitleBtn * releaseResidualValueBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(postBtn.frame) + interval, CGRectGetMinY(postBtn.frame), btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"liruntongji" andSelectedImageName:@"liruntongji" andTitle:@"发布残值"];
        [[releaseResidualValueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
            PostResidualTransactionViewController * vc = [[PostResidualTransactionViewController alloc] initWithTitle:@"发布残值" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:releaseResidualValueBtn];
        //发布招聘按钮
        SHImageAndTitleBtn * postRecruitmentBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(releaseResidualValueBtn.frame) + interval, CGRectGetMinY(postBtn.frame), btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"fabuzhaopin" andSelectedImageName:@"fabuzhaopin" andTitle:@"发布招聘"];
        [[postRecruitmentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
            PostJobViewController * vc = [[PostJobViewController alloc] initWithTitle:@"发布招聘" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:postRecruitmentBtn];
        //发布视频按钮
        SHImageAndTitleBtn * publishVideoBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(postRecruitmentBtn.frame) + interval, CGRectGetMinY(postBtn.frame), btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"fabushipin" andSelectedImageName:@"fabushipin" andTitle:@"发布视频"];
        [[publishVideoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
        }];
        [whiteBGView addSubview:publishVideoBtn];
        [_releaseView addSubview:whiteBGView];
        [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.offset(71 + [UIScreenControl liuHaiHeight]);
            make.height.offset(82);
        }];
    }
    return _releaseView;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(SHTabView *)baseTabView{
    
    if (!_baseTabView) {
        
        NSMutableArray * tabModelArray = [[NSMutableArray alloc] init];
        
        if (self.homeDataModel && self.homeDataModel.tabs && self.homeDataModel.tabs.count > 0) {
            
            NSUInteger i = 0;
            for (TabModel * model in self.homeDataModel.tabs) {
                
                SHTabModel * tabModel = [[SHTabModel alloc] init];
                
                tabModel.tabTitle = model.name;
                tabModel.normalFont = FONT16;
                tabModel.normalColor = Color_333333;
                tabModel.selectedFont = BOLDFONT21;
                tabModel.selectedColor = Color_333333;
                tabModel.btnWidth = [model.name widthWithFont:BOLDFONT21 andHeight:30] + 10;
                tabModel.tabTag = ITEMBTNBASETAG + i;
                [tabModelArray addObject:tabModel];
                i++;
            }
        }
        
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineHeight = 4;
        lineModel.lineWidth = 11;
        lineModel.lineCornerRadio = 2;
        _baseTabView = [[SHTabView alloc] initWithItemsArray:tabModelArray showRightBtn:YES andSHTabSelectLineModel:lineModel isShowBottomLine:NO];
        __weak typeof(self) weakSelf = self;
        [[_baseTabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
           
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - ITEMBTNBASETAG;
            ItemNewsCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            [cell scrollToIndex:index];
        }];
    }
    return _baseTabView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self requestData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                
                cellHeight = (MAINWIDTH - 15 * 2) / 345.0 * 150.0;
                break;
            case 1:
                
                cellHeight = 190;
                break;
            default:
                break;
        }
    }
    else{
        
        cellHeight = [ItemNewsCell cellHeight];
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight = 0;
    if (section == 1) {
        
        if (self.homeDataModel.tabs && self.homeDataModel.tabs.count > 0) {
            
            headerHeight = 40;
        }
    }
    return headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = nil;
    if (section == 1) {
        
        headerView = self.baseTabView;
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if (section == 0) {
        
        rows = 2;
    }
    else if (section == 1 && self.homeDataModel.tabs && self.homeDataModel.tabs.count > 0){
        
        rows = 1;
    }
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
     
        if (indexPath.row == 0){
            
            static NSString * carouselCellId = @"CarouselCell";
            CarouselCell * cell = [tableView dequeueReusableCellWithIdentifier:carouselCellId];
            if (!cell) {
                
                cell = [[CarouselCell alloc] initWithReuseIdentifier:carouselCellId andStyle:CarouselStyle_shouye];
                
                __weak typeof(self) weakSelf = self;
                cell.clickCallBack = ^(NSString * _Nonnull urlStr) {
                    
                    if (![NSString strIsEmpty:urlStr]) {
                        
                        BaseWKWebViewController * webViewController = [[BaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
                        webViewController.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:webViewController animated:YES];
                    }
                };
            }
            
            if (self.homeDataModel.banner && self.homeDataModel.banner.count > 0) {
    
                [cell showData:self.homeDataModel.banner];
            }
            return cell;
        }
        else if (indexPath.row == 1){
            
            static NSString * ItemsCellID = @"ItemsCell";
            ItemsCell * cell = [tableView dequeueReusableCellWithIdentifier:ItemsCellID];
            if (!cell) {
                
                cell = [[ItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItemsCellID];
                
                __weak typeof(self) weakSelf = self;
                [[cell rac_signalForSelector:@selector(itemClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
                   
                    SHImageAndTitleBtn * btn = x.first;
                    if (btn && [btn isKindOfClass:[SHImageAndTitleBtn class]]) {
                        
                        NSUInteger btnTag = btn.tag - BASEBTNTAG;
                        NSString * urlStr;
                        UIViewController * vc;
                        switch (btnTag) {
                            case 0:
                                
                                vc = [[MotorOilMonopolyViewcontroller alloc] initWithTitle:@"" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                                break;
                            case 1:
                                
                                urlStr = @"https://xcbb.xcx.zyxczs.com/mobile.php?phone=18737510089";
                                break;
                            case 2:
                                
                                vc = [[PostListViewController alloc] initWithTitle:@"营销课" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andVCType:VCType_yingxiaoke];
                                break;
                            case 3:
                                
                                vc = [[ResidualTransactionViewController alloc] initWithTitle:@"残值交易" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                                break;
                            case 4:
                            
                                vc = [[JobRecruitmentViewController alloc] initWithTitle:@"求职招聘" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                                break;
                            case 5:
                                
                                vc = [[FrameNumberInquiryViewController alloc] initWithTitle:@"车架号查询" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
                                break;
                            case 6:
                                
                                urlStr = @"https://m.weizhang8.cn/";
                                break;
                            case 7:
                                
                                urlStr = @"https://zlk.xcbb.zyxczs.com/";
                                break;
                            case 8:
                                
                                urlStr = @"http://qczl.ycqpmall.com/XmData/Wc/index";
                                break;
                            case 9:
                                
                                vc = [[PostListViewController alloc] initWithTitle:@"疑难杂症" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andVCType:VCType_yinanzazheng];
                                break;
                            default:
                                break;
                        }
                        
                        if (![NSString strIsEmpty:urlStr]) {
                            
                            BaseWKWebViewController * vc = [[BaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
                            vc.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        }
                        else if (vc){
                            
                            vc.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }];
            }
            
            return cell;
        }
    }
    else if (indexPath.section == 1){
        
        static NSString * ItemNewsCellID = @"ItemNewsCell";
        ItemNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ItemNewsCellID];
        if (!cell) {
            
            NSMutableArray * tabsArray = [[NSMutableArray alloc] init];
            for (TabModel * model in self.homeDataModel.tabs) {
                
                [tabsArray addObject:model.tabID];
            }
            
            cell = [[ItemNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItemNewsCellID andTabIDsArray:tabsArray];
            __weak typeof(self) weakSelf = self;
            //滑动过程中的回调
            [[cell rac_valuesForKeyPath:@"collectionView.contentOffset" observer:self] subscribeNext:^(id  _Nullable x) {
            
            }];
            //滑动完成的回调
            [[cell rac_signalForSelector:@selector(scrollViewDidEndDecelerating:)] subscribeNext:^(RACTuple * _Nullable x) {
               
                UICollectionView * collectionView = x.first;
                NSUInteger index = collectionView.contentOffset.x / MAINWIDTH;
                [weakSelf.baseTabView selectItemWithIndex:index];
            }];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark  ----  UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"SHImageAndTitleBtn"]) {
        // cell 不需要响应 父视图的手势，保证didselect 可以正常
        return NO;
    }
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.homeNavgationBar];
    [self.homeNavgationBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(31 + [UIScreenControl liuHaiHeight]);
        make.height.offset(40);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.homeNavgationBar.mas_bottom);
    }];
    
    [self.view bringSubviewToFront:self.homeNavgationBar];
}

-(void)requestData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Home,@"bodyParameters":bodyParameters};
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
                        
                        weakSelf.homeDataModel = [HomeDataModel mj_objectWithKeyValues:dataDic];
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
