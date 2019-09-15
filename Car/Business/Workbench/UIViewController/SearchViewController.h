//
//  SearchViewController.h
//  Car
//
//  Created by mac on 2019/9/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  搜索

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class SearchConfigurationModel;


typedef NS_ENUM(NSUInteger,SearchType){
    
    SearchType_MaintenanceRecords = 0,//维修记录搜索
    SearchType_RevenueList,//营收列表搜索
    SearchType_Unpaid,//未回款搜索
    SearchType_Repaid//已回款搜索
};



@interface SearchViewController : BaseTableViewController

@property (nonatomic,assign) SearchType searchType;

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andSearchConfigurationModel:(SearchConfigurationModel *)configurationModel;

@end

NS_ASSUME_NONNULL_END
