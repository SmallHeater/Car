//
//  ForumDetailViewController.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailViewController.h"
#import "ForumDetailTitleCell.h"
#import "ForumDetailAuthorCell.h"
#import "ForumDetailWebViewCell.h"
#import "ForumDetailInfringementPromptCell.h"
#import "ForumDetaiADCell.h"
#import "ForumDetailCommentListCell.h"
#import "SHImageAndTitleBtn.h"
#import "SHTextView.h"
#import "UserInforController.h"

static NSString * ForumDetailTitleCellId = @"ForumDetailTitleCell";
static NSString * ForumDetailAuthorCellId = @"ForumDetailAuthorCell";
static NSString * ForumDetailWebViewCellId = @"ForumDetailWebViewCell";
static NSString * ForumDetailInfringementPromptCellId = @"ForumDetailInfringementPromptCell";
static NSString * ForumDetaiADCellId = @"ForumDetaiADCell";
static NSString * ForumDetailCommentListCellId = @"ForumDetailCommentListCell";

@interface ForumDetailViewController ()

@property (nonatomic,strong) ForumArticleModel * forumArticleModel;
@property (nonatomic,assign) float ForumDetailWebViewCellHeight;
@property (nonatomic,assign) float ForumDetailCommentListCellHeight;
//底部评论view
@property (nonatomic,strong) UIView * bottomCommentView;
//发表评论view
@property (nonatomic,strong) UIView * postCommentView;
@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) SHTextView * textView;
//点赞按钮
@property (nonatomic,strong) UIButton * praiseBtn;

@end

@implementation ForumDetailViewController

#pragma mark  ----  懒加载

-(UIView *)bottomCommentView{
    
    if (!_bottomCommentView) {
        
        _bottomCommentView = [[UIView alloc] init];
        _bottomCommentView.backgroundColor = [UIColor whiteColor];
        UILabel * topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = Color_EEEEEE;
        [_bottomCommentView addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.right.offset(0);
            make.height.offset(1);
        }];
        
        
        UITextField * commentTF = [[UITextField alloc] init];
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 36)];
        UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fabiaopinglun"]];
        leftImageView.frame = CGRectMake(10, 7, 21, 21);
        [leftView addSubview:leftImageView];
        commentTF.leftViewMode = UITextFieldViewModeAlways;
        commentTF.leftView = leftView;
        commentTF.text = @"发表回帖…";
        commentTF.backgroundColor = Color_F0F2F7;
        [_bottomCommentView addSubview:commentTF];
        [commentTF mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(16);
            make.top.offset(7);
            make.width.offset(172);
            make.height.offset(36);
        }];
        
        //评论数按钮
        SHImageAndTitleBtn * commentsBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(225, 16, 40, 20) andImageFrame:CGRectMake(0, 0, 20, 20) andTitleFrame:CGRectMake(25, 0, 15, 20) andImageName:@"pinglunshu" andSelectedImageName:@"pinglunshu" andTitle:@"9"];
        [_bottomCommentView addSubview:commentsBtn];
        //点赞按钮
        UIButton * praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.praiseBtn = praiseBtn;
        [praiseBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [praiseBtn setImage:[UIImage imageNamed:@"dianzanxuanzhong"] forState:UIControlStateSelected];
        __weak typeof(self) weakSelf = self;
        [[praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf addArticleThumb];
        }];
        [_bottomCommentView addSubview:praiseBtn];
        [praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(14);
            make.left.equalTo(commentsBtn.mas_right).offset((MAINWIDTH - 265 - 34 - 19) / 2);
            make.width.height.offset(19);
        }];
        //收藏按钮
        UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [collectBtn setImage:[UIImage imageNamed:@"shoucangxuanzhong"] forState:UIControlStateSelected];
        [_bottomCommentView addSubview:collectBtn];
        [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(14);
            make.right.offset(-15);
            make.width.height.offset(19);
        }];
    }
    return _bottomCommentView;
}

-(UIView *)postCommentView{
    
    if (!_postCommentView) {
        
        _postCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT)];
        _postCommentView.backgroundColor = [UIColor colorFromHexRGB:@"000000" alpha:0.7];
        UIView * whiteView = [[UIView alloc] init];
        self.whiteView = whiteView;
        whiteView.backgroundColor = [UIColor whiteColor];
        [_postCommentView addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.height.offset(155);
            make.bottom.offset(-200);
        }];
        //取消按钮
        UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:Color_0272FF forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = FONT16;
        [whiteView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.offset(0);
            make.width.offset(64);
            make.height.offset(45);
        }];
        //回帖标题
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT16;
        titleLabel.textColor = Color_495B73;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"回帖";
        [whiteView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(0);
            make.height.offset(44);
            make.width.offset(50);
            make.centerX.equalTo(whiteView.mas_centerX);
        }];
        //发送按钮
        UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:Color_CCCCCC forState:UIControlStateNormal];
        [sendBtn setTitleColor:Color_333333 forState:UIControlStateSelected];
        sendBtn.titleLabel.font = FONT16;
        [whiteView addSubview:sendBtn];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.top.offset(0);
            make.width.offset(64);
            make.height.offset(45);
        }];
        
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = Color_EEEEEE;
        [whiteView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.offset(44);
            make.height.offset(1);
        }];
        
        SHTextView * textView = [[SHTextView alloc] init];
        self.textView = textView;
        textView.block = ^(NSString *str) {
          
            NSLog(@"%@",str);
        };
        textView.placeholder = @"请输入回帖内容";
        textView.placeholderColor = Color_CCCCCC;
        textView.textFont = FONT16;
        [whiteView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.offset(0);
            make.top.offset(45);
            make.height.offset(110);
        }];
    }
    return _postCommentView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andModel:(ForumArticleModel *)model{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.forumArticleModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    //webview默认高度为0的话不会加载网页
    self.ForumDetailWebViewCellHeight = MAINHEIGHT;
    self.ForumDetailCommentListCellHeight = 0;
    [self drawUI];
    [self registrationNotice];
    [self addArticlePV];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = [ForumDetailTitleCell cellHeightWithModel:self.forumArticleModel];
    }
    else if (indexPath.row == 1){
        
        cellHeight = 40;
    }
    else if (indexPath.row == 2){
        
        cellHeight = self.ForumDetailWebViewCellHeight;
    }
    else if (indexPath.row == 3){
        
        cellHeight = 60;
    }
    else if (indexPath.row == 4){
        
        cellHeight = [ForumDetaiADCell cellHeightWithModel:self.forumArticleModel];
    }
    else if (indexPath.row == 5){
        
        cellHeight = self.ForumDetailCommentListCellHeight;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ForumDetailTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailTitleCellId];
        if (!cell) {
            
            cell = [[ForumDetailTitleCell alloc] initWithReuseIdentifier:ForumDetailTitleCellId];
        }
        
        [cell show:self.forumArticleModel];
        return cell;
    }
    else if (indexPath.row == 1){
        
        ForumDetailAuthorCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailAuthorCellId];
        if (!cell) {
            
            cell = [[ForumDetailAuthorCell alloc] initWithReuseIdentifier:ForumDetailAuthorCellId];
        }
        
        [cell show:self.forumArticleModel];
        return cell;
    }
    else if (indexPath.row == 2){
        
        ForumDetailWebViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailWebViewCellId];
        if (!cell) {
            
            cell = [[ForumDetailWebViewCell alloc] initWithReuseIdentifier:ForumDetailWebViewCellId];
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"webViewHeight" observer:self] subscribeNext:^(id  _Nullable x) {
               
                float height = [x floatValue];
                if (height > 0) {
                    
                    weakSelf.ForumDetailWebViewCellHeight = height;
                    //只更新高度，不刷新内容
                    [weakSelf.tableView beginUpdates];
                    [weakSelf.tableView endUpdates];
                }
            }];
        }
        
        [cell show:self.forumArticleModel];
        return cell;
    }
    else if (indexPath.row == 3){
        
        ForumDetailInfringementPromptCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailInfringementPromptCellId];
        if (!cell) {
            
            cell = [[ForumDetailInfringementPromptCell alloc] initWithReuseIdentifier:ForumDetailInfringementPromptCellId];
        }
        
        return cell;
    }
    else if (indexPath.row == 4){
        
        ForumDetaiADCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetaiADCellId];
        if (!cell) {
            
            cell = [[ForumDetaiADCell alloc] initWithReuseIdentifier:ForumDetaiADCellId];
        }
        
        [cell show:self.forumArticleModel];
        return cell;
    }
    else if (indexPath.row == 5){
        
        ForumDetailCommentListCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailCommentListCellId];
        if (!cell) {
            
            cell = [[ForumDetailCommentListCell alloc] initWithReuseIdentifier:ForumDetailCommentListCellId];
            
            __weak typeof(self) weakSelf = self;
            [[cell rac_valuesForKeyPath:@"cellHeight" observer:self] subscribeNext:^(id  _Nullable x) {
                
                float height = [x floatValue];
                if (height > 0) {
                    
                    weakSelf.ForumDetailCommentListCellHeight = height;
                    //只更新高度，不刷新内容
                    [weakSelf.tableView beginUpdates];
                    [weakSelf.tableView endUpdates];
                }
            }];
        }
        
        [cell show:self.forumArticleModel];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.bottom.offset(51 + [UIScreenControl bottomSafeHeight]);
    }];
    
    [self.view addSubview:self.bottomCommentView];
    [self.bottomCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset([UIScreenControl bottomSafeHeight]);
        make.height.offset(51);
    }];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    __weak typeof(self) weakSelf = self;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSDictionary *userInfo = [x userInfo];
        CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
        CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
        [weakSelf.textView becomeFirstResponder];
        [UIView animateWithDuration:duration animations:^{
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.postCommentView];
            [weakSelf.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.right.offset(0);
                make.height.offset(155);
                make.bottom.offset(-rect.size.height);
            }];
        }];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        [weakSelf.postCommentView removeFromSuperview];
    }];
}

//增加浏览量
-(void)addArticlePV{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"article_id":[[NSString alloc] initWithFormat:@"%ld",self.forumArticleModel.ArticleId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":ArticlePV,@"bodyParameters":bodyParameters};
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

//文章点赞
-(void)addArticleThumb{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"id":[[NSString alloc] initWithFormat:@"%ld",self.forumArticleModel.ArticleId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":ArticleThumb,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                
                if (code.integerValue == 1) {
                    
                    //成功
                    [MBProgressHUD wj_showSuccess:@"点赞成功"];
                    weakSelf.praiseBtn.selected = !weakSelf.praiseBtn.selected;
                }
                else{
                    
                    //异常
                    [MBProgressHUD wj_showError:dic[@"msg"]];
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
