//
//  SHTableView.m
//  Car
//
//  Created by xianjun wang on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaseTableView.h"

@implementation SHBaseTableView

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [self initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        //取消contentSize和contentOffset的改的，解决闪屏问题
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

@end
