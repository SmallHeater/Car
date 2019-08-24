//
//  BaseTableViewController.h
//  IntimatePersonForOC
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 IP. All rights reserved.
//  列表基类视图控制器

#import "BaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,TBVCViewType){
    
    TBVCDefault = 0,//默认状态，只有导航
    TBVCTableView,//显示tableView
    TBVCReloadData,//刷新数据
    TBVCNoInternet,//无网
    TBVCNoData//无数据
};

typedef NS_ENUM(NSUInteger,TBVCDataType){
    
    TBVCGetNewData = 0,
    TBVCLoadMoreData
};


@interface BaseTableViewController : BaseUIViewController

@property (nonatomic,assign) TBVCViewType viewType;
@property (nonatomic,assign) TBVCDataType dataType;
@property (nonatomic,strong) NSMutableArray * dataArray;

-(instancetype)initWithTitle:(NSString *)title andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style;


//请求列表数据
-(void)requestListData;
//刷新页面展示
-(void)refreshViewWithViewType:(TBVCViewType)viewType;

@end

NS_ASSUME_NONNULL_END
