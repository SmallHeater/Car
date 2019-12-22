//
//  HomeViewController.m
//  Car
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavgationBar.h"
#import "SHBaseWKWebViewController.h"
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
#import "PushViewController.h"
#import "ForumDetailViewController.h"
#import "LoginViewController.h"
#import "HoverPageViewController.h"
#import "SHCarouselView.h"
#import "ArticleListViewController.h"
#import "SmallVideoViewControllerForHome.h"

#define BASEBTNTAG 1800
#define ITEMBTNBASETAG 1000

@interface HomeViewController ()<UIGestureRecognizerDelegate,HoverPageViewControllerDelegate>

@property (nonatomic,strong) HomeNavgationBar * homeNavgationBar;
@property (nonatomic,strong) HomeDataModel * homeDataModel;
//发布view
@property (nonatomic,strong) UIView * releaseView;
//头部view
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) SHCarouselView * carouselView;
@property (nonatomic,strong) ItemsCell * itemsCell;
//切换view
@property (nonatomic,strong) SHTabView * baseTabView;
@property (nonatomic,strong) HoverPageViewController * hoverPageViewController;
@property(nonatomic, strong) UIView *indicator;

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
            
            if ([[UserInforController sharedManager].userInforModel.userID isEqualToString:@"0"]) {
                
                //未登录
                LoginViewController * vc = [[LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.releaseView];
                [weakSelf.releaseView mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                    make.left.right.top.bottom.offset(0);
                }];
            }
        }];
    }
    return _homeNavgationBar;
}

-(UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINWIDTH / 2 + 159 + 10 + 7)];
        [_headerView addSubview:self.carouselView];
        NSMutableArray * carouselDicArray = [[NSMutableArray alloc] init];
        for (CarouselModel * model in self.homeDataModel.banner) {
            
            NSString * CarouselImageUrlStr = [[NSString alloc] initWithFormat:@"%@",model.image];
            NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.CarouselId,@"CarouselId",CarouselImageUrlStr,@"CarouselImageUrlStr",model.type,@"type",model.url,@"urlStr", nil];
            [carouselDicArray addObject:dic];
        }
        [self.carouselView refreshData:carouselDicArray];
        self.itemsCell.frame = CGRectMake(0, MAINWIDTH / 2, MAINWIDTH, 159 + 10 + 7);
        [_headerView addSubview:self.itemsCell];
    }
    return _headerView;
}

-(SHCarouselView *)carouselView{
    
    if (!_carouselView) {
        
        _carouselView = [[SHCarouselView alloc] initWithPageControlType:PageControlType_MiddlePage];
        _carouselView.frame = CGRectMake(0, 0, MAINWIDTH, MAINWIDTH / 2);
        __weak typeof(self) weakSelf = self;
        _carouselView.clickCallBack = ^(NSString * _Nonnull urlStr) {
            
            if (![NSString strIsEmpty:urlStr]) {
                
                if ([urlStr hasPrefix:@"http"]) {
                    
                    SHBaseWKWebViewController * webViewController = [[SHBaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
                    webViewController.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:webViewController animated:YES];
                }
                else{
                    
                    //去详情页
                    ForumDetailViewController * vc = [[ForumDetailViewController alloc] initWithTitle:@"" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andArticleId:urlStr];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            }

        };
    }
    return _carouselView;
}

-(ItemsCell *)itemsCell{
    
    if (!_itemsCell) {
        
        static NSString * ItemsCellID = @"ItemsCell";
        _itemsCell = [[ItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItemsCellID];
        __weak typeof(self) weakSelf = self;
        [[_itemsCell rac_signalForSelector:@selector(itemClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
           
            SHImageAndTitleBtn * btn = x.first;
            if (btn && [btn isKindOfClass:[SHImageAndTitleBtn class]]) {
                
                NSUInteger btnTag = btn.tag - BASEBTNTAG;
                NSString * urlStr;
                UIViewController * vc;
                switch (btnTag) {
                    case 0:

//                                vc = [[PostListViewController alloc] initWithTitle:@"维修保养" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:@"1" vcType:VCType_tieziliebiao];
                        if ([[UserInforController sharedManager].userInforModel.userID isEqualToString:@"0"]) {
                            
                            //未登录
                            LoginViewController * vc = [[LoginViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            return;
                        }
                        
//                        vc = [[MotorOilMonopolyViewcontroller alloc] initWithTitle:@"" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                        vc = [[MotorOilMonopolyViewcontroller alloc] init];
                        break;
                    case 1:
                    {
                        if ([[UserInforController sharedManager].userInforModel.userID isEqualToString:@"0"]) {
                            LoginViewController * vc = [[LoginViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                            
                            return;
                        }
                        Class class=NSClassFromString(@"MrCategoryListVC");
                        UIViewController* vc=[[class alloc] init];
                        vc.hidesBottomBarWhenPushed=YES;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                        return;
                    }
                        break;
                    case 2:
                        
                        vc = [[PostListViewController alloc] initWithTitle:@"营销课" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:@"5"];
                        break;
                    case 3:
                        
                        vc = [[ResidualTransactionViewController alloc] initWithTitle:@"残值交易" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                        break;
                    case 4:
                    
                        vc = [[JobRecruitmentViewController alloc] initWithTitle:@"求职招聘" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                        break;
                    case 5:
                        
                        vc = [[FrameNumberInquiryViewController alloc] initWithTitle:@"车架号查询" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
                        break;
                    case 6:
                        
                        urlStr = @"https://m.weizhang8.cn/";
                        break;
                    case 7:
                        
                        urlStr = @"https://zlk.xcbb.zyxczs.com/";
                        break;
                    case 8:
                        
                        urlStr = @"https://cx2.ycqpmall.com/XmData/Wc/index";
                        break;
                    case 9:
                        
                        vc = [[PostListViewController alloc] initWithTitle:@"疑难杂症" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:@"8"];
                        break;
                    default:
                        break;
                }
                
                if (![NSString strIsEmpty:urlStr]) {

                    SHBaseWKWebViewController * vc = [[SHBaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
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
    return _itemsCell;
}

-(UIView *)releaseView{
    
    if (!_releaseView) {
        
        _releaseView = [[UIView alloc] init];
        __weak typeof(self) weakSelf = self;
        _releaseView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
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
            PostResidualTransactionViewController * vc = [[PostResidualTransactionViewController alloc] initWithTitle:@"发布残值" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:releaseResidualValueBtn];
        //发布招聘按钮
        SHImageAndTitleBtn * postRecruitmentBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(releaseResidualValueBtn.frame) + interval, CGRectGetMinY(postBtn.frame), btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"fabuzhaopin" andSelectedImageName:@"fabuzhaopin" andTitle:@"发布招聘"];
        [[postRecruitmentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
            PostJobViewController * vc = [[PostJobViewController alloc] initWithTitle:@"发布招聘" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:postRecruitmentBtn];
        //发布视频按钮
        SHImageAndTitleBtn * publishVideoBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(postRecruitmentBtn.frame) + interval, CGRectGetMinY(postBtn.frame), btnWidth, 52) andImageFrame:CGRectMake((btnWidth - 25) / 2, 0, 25, 25) andTitleFrame:CGRectMake(0, 38, btnWidth, 12) andImageName:@"fabushipin" andSelectedImageName:@"fabushipin" andTitle:@"发布视频"];
        [[publishVideoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.releaseView removeFromSuperview];
            PushViewController * vc = [[PushViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [whiteBGView addSubview:publishVideoBtn];
        [_releaseView addSubview:whiteBGView];
        [whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.offset(71 + [SHUIScreenControl liuHaiHeight]);
            make.height.offset(82);
        }];
    }
    return _releaseView;
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
        _baseTabView.frame = CGRectMake(0, 0, MAINWIDTH, 40);
        __weak typeof(self) weakSelf = self;
        [[_baseTabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
           
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - ITEMBTNBASETAG;
            [weakSelf.hoverPageViewController moveToAtIndex:index animated:YES];
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark  ----  代理

#pragma mark  ----  UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"SHImageAndTitleBtn"]) {
        // cell 不需要响应 父视图的手势，保证didselect 可以正常
        return NO;
    }
    return YES;
}


#pragma mark  ----  HoverPageViewControllerDelegate

- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.baseTabView selectItemWithIndex:index];
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.homeNavgationBar];
    [self.homeNavgationBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(31 + [SHUIScreenControl liuHaiHeight]);
        make.height.offset(40);
    }];
}

-(void)drawOtherView{
    
    // 添加子控制器
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (TabModel * model in self.homeDataModel.tabs) {
        
        if ([model.name isEqualToString:@"小视频"]) {
            
            SmallVideoViewControllerForHome * videoVC = [[SmallVideoViewControllerForHome alloc] init];
            [viewControllers addObject:videoVC];
        }
        else{
         
            ArticleListViewController * listVC = [[ArticleListViewController alloc] init];
            [listVC requestWithTabID:model.tabID];
            [viewControllers addObject:listVC];
        }
    }
     
     // 计算导航栏高度
     CGFloat barHeight = (71 + [SHUIScreenControl liuHaiHeight]);
     // 添加分页控制器
    self.hoverPageViewController = [HoverPageViewController viewControllers:viewControllers headerView:self.headerView pageTitleView:self.baseTabView];
    self.hoverPageViewController.view.frame = CGRectMake(0, barHeight, MAINWIDTH,MAINHEIGHT - barHeight - 44);
    self.hoverPageViewController.delegate = self;
    [self addChildViewController:self.hoverPageViewController];
    [self.view addSubview:self.hoverPageViewController.view];
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
                        [weakSelf drawOtherView];
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
