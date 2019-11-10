//
//  MyPostViewController.m
//  Car
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MyReplyViewController.h"
#import "UserInforController.h"
#import "CommentModel.h"
#import "CommentDeleteCell.h"
#import "CommentNoReplyCell.h"
#import "CommentWithReplyCell.h"


static NSString * CommentDeleteCellId = @"CommentDeleteCell";
static NSString * CommentNoReplyCellId = @"CommentNoReplyCell";
static NSString * CommentWithReplyCellId = @"CommentWithReplyCell";

@interface MyReplyViewController ()

@property (nonatomic,assign) VCType type;

@end

@implementation MyReplyViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style VCType:(VCType)type{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentModel * model = self.dataArray[indexPath.row];
    return [CommentBaseCell cellHeightWithModel:model];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentModel * model = self.dataArray[indexPath.row];
    if (model.disabledswitch) {
        
        //删除cell
        CommentDeleteCell * cell = [tableView dequeueReusableCellWithIdentifier:CommentDeleteCellId];
        if (!cell) {
            
            cell = [[CommentDeleteCell alloc] initWithReuseIdentifier:CommentDeleteCellId];
        }
        
        [cell show:model];
        return cell;
    }
    else{
        
        if (model.to_user && [model.to_user isKindOfClass:[CommentToUserModel class]]) {
            
            //有回复
            CommentWithReplyCell * cell = [tableView dequeueReusableCellWithIdentifier:CommentWithReplyCellId];
            if (!cell) {
                
                cell = [[CommentWithReplyCell alloc] initWithReuseIdentifier:CommentWithReplyCellId];
            }
            
            [cell show:model];
            return cell;
        }
        else{
            
            //无回复的评论cell
            CommentNoReplyCell * cell = [tableView dequeueReusableCellWithIdentifier:CommentNoReplyCellId];
            if (!cell) {
                
                cell = [[CommentNoReplyCell alloc] initWithReuseIdentifier:CommentNoReplyCellId];
            }
            
            [cell show:model];
            return cell;
        }
    }
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)requestListData{
    
    //发起请求
    NSString * type = @"";
    if (self.type == VCType_MyReply) {
        
        type = @"0";
    }
    else if (self.type == VCType_ReplyToMe){
        
        type = @"1";
    }
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"type":type,@"commentable_type":@"article",};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetMyComments,@"bodyParameters":bodyParameters};
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
                
                [weakSelf.dataArray removeAllObjects];
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        for (NSDictionary * dic in dataDic[@"comments"]) {
                            
                            CommentModel * model = [CommentModel mj_objectWithKeyValues:dic];
                            [weakSelf.dataArray addObject:model];
                        }
                    }
                }
                else{
                    
                    //异常
                }
                [weakSelf.tableView reloadData];
                //如果内容少，则不滑动
                if (weakSelf.tableView.contentSize.height < weakSelf.tableView.bounds.size.height) {
                    
                    weakSelf.tableView.scrollEnabled = NO;
                }
                else{
                    
                    weakSelf.tableView.scrollEnabled = YES;
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
