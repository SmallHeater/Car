//
//  SHBaseTableViewController.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 IP. All rights reserved.
//  列表基类视图控制器

#import "SHBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger,BTVCType){
    
    BTVCType_AddTableView = 0,//添加tableView
    BTVCType_RefreshTableView,//刷新tableView
    BTVCType_NoData,//无数据
    BTVCType_NoInterNet//无网络
};

@interface SHBaseTableViewController : SHBaseUIViewController

//考虑到有的场景，虽然不是只有tableView一个控件，但是也适合本基类，所以让tableView指针开放出来
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

//isShowHead,是否显示下拉刷新;isShowFoot，是否显示上拉加载
-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andIsShowHead:(BOOL)isShowHead andIsShowFoot:(BOOL)isShowFoot;


//请求列表数据
-(void)requestListData;
//下拉刷新(回调函数)
-(void)loadNewData;
//上拉加载(回调函数)
-(void)loadMoreData;
//刷新展示
-(void)refreshViewType:(BTVCType)viewType;

@end

NS_ASSUME_NONNULL_END
