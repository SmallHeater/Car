//
//  BaseTableViewController.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 IP. All rights reserved.
//  列表基类视图控制器

#import "BaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger,BTVCType){
    
    BTVCType_AddTableView = 0,//添加tableView
    BTVCType_RefreshTableView,//刷新tableView
    BTVCType_NoData,//无数据
    BTVCType_NoInterNet//无网络
};

@interface BaseTableViewController : BaseUIViewController

//考虑到有的场景，虽然不是只有tableView一个控件，但是也适合本基类，所以让tableView指针开放出来
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style;


//请求列表数据
-(void)requestListData;

//刷新展示
-(void)refreshViewType:(BTVCType)viewType;

@end

NS_ASSUME_NONNULL_END
