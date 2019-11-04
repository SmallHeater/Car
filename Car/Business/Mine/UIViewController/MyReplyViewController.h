//
//  MyPostViewController.h
//  Car
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  我的回帖和回复我的页面

#import "SHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,VCType){
    
    VCType_MyReply = 0,//我的回帖
    VCType_ReplyToMe //回复我的
};

@interface MyReplyViewController : SHBaseTableViewController

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style VCType:(VCType)type;

@end

NS_ASSUME_NONNULL_END
