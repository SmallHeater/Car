//
//  PostJobViewController.h
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布招聘信息页

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostJobViewController : BaseTableViewController

//招聘参数字典
@property (nonatomic,strong) NSDictionary * jobOptionDic;

@end

NS_ASSUME_NONNULL_END
