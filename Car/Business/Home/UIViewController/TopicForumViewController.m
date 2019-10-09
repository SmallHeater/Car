//
//  TopicForumViewController.m
//  Car
//
//  Created by xianjun wang on 2019/10/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "TopicForumViewController.h"
#import "TopicForumCell.h"
#import "UserInforController.h"
#import "ForumTabModel.h"

static NSString * cellId = @"TopicForumCell";

@interface TopicForumViewController ()

@property (nonatomic,strong) NSString * tabID;

//选中的论坛名称
@property (nonatomic,strong) NSString * forumStr;
//论坛ID
@property (nonatomic,strong) NSString * forumId;

@end

@implementation TopicForumViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andTabID:(NSString *)tabID{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.tabID = [NSString repleaseNilOrNull:tabID];
    }
    return self;
}

- (void)viewDidLoad {
    
    //继承BaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumTabModel * model = self.dataArray[indexPath.row];
    self.forumStr = model.title;
    self.forumId = model.ForumID;
    [self backBtnClicked:nil];
}


#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicForumCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[TopicForumCell alloc] initWithReuseIdentifier:cellId];
    }
    
    ForumTabModel * model = self.dataArray[indexPath.row];
    [cell show:model.title];
    
    return cell;
}

#pragma mark  ----  自定义函数
-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"tab_id":self.tabID};
    NSDictionary * configurationDic = @{@"requestUrlStr":SectionList,@"bodyParameters":bodyParameters};
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
                        
                        NSArray * arr = dataDic[@"sections"];
                        [weakSelf.dataArray removeAllObjects];
                        for (NSUInteger i = 0; i < arr.count; i++) {
                            
                            NSDictionary * dic = arr[i];
                            ForumTabModel * model = [ForumTabModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                         }
                    }
                }
                else{
                    
                    //异常
                }
                [weakSelf.tableView reloadData];
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
