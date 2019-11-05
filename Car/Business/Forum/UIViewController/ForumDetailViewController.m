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
#import "ForumDetailContentCell.h"
#import "ForumDetailInfringementPromptCell.h"
#import "ForumDetaiADCell.h"
#import "ForumDetailCommentListCell.h"
#import "SHImageAndTitleBtn.h"
#import "SHTextView.h"
#import "UserInforController.h"
#import "PostListViewController.h"
#import "CommentModel.h"
#import "ReportViewController.h"

static NSString * ForumDetailTitleCellId = @"ForumDetailTitleCell";
static NSString * ForumDetailAuthorCellId = @"ForumDetailAuthorCell";
static NSString * ForumDetailContentCellId = @"ForumDetailContentCell";
static NSString * ForumDetailInfringementPromptCellId = @"ForumDetailInfringementPromptCell";
static NSString * ForumDetaiADCellId = @"ForumDetaiADCell";
static NSString * ForumDetailCommentListCellId = @"ForumDetailCommentListCell";

@interface ForumDetailViewController ()

//标题
@property (nonatomic,strong) NSString * titleStr;
//标题宽度
@property (nonatomic,assign) float titleWidth;
//标题按钮
@property (nonatomic,strong) SHImageAndTitleBtn * titleBtn;
//举报按钮
@property (nonatomic,strong) SHImageAndTitleBtn * reportBtn;
@property (nonatomic,strong) ForumArticleModel * forumArticleModel;
@property (nonatomic,assign) float ForumDetailContentCellHeight;
@property (nonatomic,assign) float ForumDetailCommentListCellHeight;
//底部评论view
@property (nonatomic,strong) UIView * bottomCommentView;
@property (nonatomic,strong) UITextField * commentTF;
//发表评论view
@property (nonatomic,strong) UIView * postCommentView;
@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) SHTextView * textView;
//点赞按钮
@property (nonatomic,strong) UIButton * praiseBtn;
//回复的评论模型
@property (nonatomic,strong) CommentModel * commentModel;

@end

@implementation ForumDetailViewController

#pragma mark  ----  懒加载

-(float)titleWidth{
    
    return [self.titleStr widthWithFont:FONT18 andHeight:44];
}

-(SHImageAndTitleBtn *)titleBtn{
    
    if (!_titleBtn) {
        
        //高44
        _titleBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake(self.titleWidth + 5, 14, 16, 16) andTitleFrame:CGRectMake(0, 0, self.titleWidth, 44) andImageName:@"gengduojiantou" andSelectedImageName:@"gengduojiantou" andTitle:self.titleStr];
        [_titleBtn refreshFont:FONT18];
        [_titleBtn refreshTitle:self.titleStr];
        __weak typeof(self) weakSelf = self;
        [[_titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            PostListViewController * vc = [[PostListViewController alloc] initWithTitle:weakSelf.titleStr andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:[NSString stringWithFormat:@"%ld",(long)weakSelf.forumArticleModel.section_id] vcType:VCType_tieziliebiao];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _titleBtn;
}

-(SHImageAndTitleBtn *)reportBtn{
    
    if (!_reportBtn) {
        
        _reportBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake(0, 0, 24, 24) andTitleFrame:CGRectMake(0, 24, 24, 16) andImageName:@"tousu" andSelectedImageName:@"tousu" andTitle:@"举报"];
        [_reportBtn refreshFont:FONT11];
        [_reportBtn refreshColor:Color_FF3B30];
        __weak typeof(self) weakSelf = self;
        [[_reportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            ReportViewController * vc = [[ReportViewController alloc] initWithTitle:@"举报" andIsShowBackBtn:YES andId:[NSString stringWithFormat:@"%ld",weakSelf.forumArticleModel.ArticleId]];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _reportBtn;
}


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
        self.commentTF = commentTF;
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
        SHImageAndTitleBtn * commentsBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(225, 16, 40, 20) andImageFrame:CGRectMake(0, 0, 20, 20) andTitleFrame:CGRectMake(25, 0, 15, 20) andImageName:@"pinglunshu" andSelectedImageName:@"pinglunshu" andTitle:[[NSString alloc] initWithFormat:@"%ld",self.forumArticleModel.comments]];
        [_bottomCommentView addSubview:commentsBtn];
        //点赞按钮
        UIButton * praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.praiseBtn = praiseBtn;
        praiseBtn.selected = self.forumArticleModel.thumbed;
        [praiseBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [praiseBtn setImage:[UIImage imageNamed:@"dianzanxuanzhong"] forState:UIControlStateSelected];
        __weak typeof(self) weakSelf = self;
        [[praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.selected = !x.selected;
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
        collectBtn.selected = self.forumArticleModel.markered;
        [[collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.selected = !x.selected;
            [weakSelf collectArticle];
        }];
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
        
        __weak typeof(self) weakSelf = self;
        _postCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT)];
        _postCommentView.backgroundColor = [UIColor colorFromHexRGB:@"000000" alpha:0.7];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
           
            [weakSelf.postCommentView removeFromSuperview];
        }];
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
        [[cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf.postCommentView removeFromSuperview];
        }];
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
        [sendBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        sendBtn.titleLabel.font = FONT16;
        [[sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            if ([NSString strIsEmpty:weakSelf.textView.text]) {
                
                [MBProgressHUD wj_showError:@"请输入回帖内容"];
            }
            else{
                
                [weakSelf postComment];
            }
        }];
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
    
    self = [super initWithTitle:@"" andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style];
    if (self) {
        
        self.titleStr = [NSString repleaseNilOrNull:title];
        self.forumArticleModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    //webview默认高度为0的话不会加载网页
    self.ForumDetailContentCellHeight = MAINHEIGHT;
    self.ForumDetailCommentListCellHeight = 100;
    [self drawUI];
    [self addArticlePV];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self registrationNotice];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self removeNotice];
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
        
        cellHeight = [ForumDetailContentCell cellHeightWithModel:self.forumArticleModel];
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
            __weak typeof(self) weakSelf = self;
            [[cell rac_signalForSelector:@selector(attentionBtnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
                
                //去作者的帖子列表页面
                PostListViewController * vc = [[PostListViewController alloc] initWithTitle:@"我的帖子" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andSectionId:@"" vcType:VCType_wodetieziliebiao];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
        }
        
        [cell show:self.forumArticleModel];
        return cell;
    }
    else if (indexPath.row == 2){
        
        ForumDetailContentCell * cell = [tableView dequeueReusableCellWithIdentifier:ForumDetailContentCellId];
        if (!cell) {
            
            cell = [[ForumDetailContentCell alloc] initWithReuseIdentifier:ForumDetailContentCellId];
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
                    //只刷新高度b，不刷新内容
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
    
    [self.navigationbar addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.offset(self.titleWidth + 5 + 16);
        make.height.offset(44);
        make.bottom.offset(0);
        make.centerX.equalTo(self.navigationbar.mas_centerX);
    }];
    [self.navigationbar addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.bottom.offset(-4);
        make.width.offset(24);
        make.height.offset(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.bottom.offset(-51 - [SHUIScreenControl bottomSafeHeight]);
    }];
    
    [self.view addSubview:self.bottomCommentView];
    [self.bottomCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset([SHUIScreenControl bottomSafeHeight]);
        make.height.offset(51);
    }];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pinglunhuifu:) name:@"PINGLUNHUIFU" object:nil];
}

-(void)keyBoardWillShow:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    [self.textView becomeFirstResponder];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{

        [[UIApplication sharedApplication].keyWindow addSubview:self.postCommentView];
        [weakSelf.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.right.offset(0);
            make.height.offset(155);
            make.bottom.offset(-rect.size.height);
        }];
    }];
}

-(void)keyBoardWillHide:(NSNotification *)notification{
    
    [self.postCommentView removeFromSuperview];
}

-(void)pinglunhuifu:(NSNotification *)notification{
    
    NSDictionary * dic = notification.object;
    self.commentModel = dic[@"CommentModel"];
    [self.commentTF becomeFirstResponder];
}

//取消监听
-(void)removeNotice{
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

//发表评论
-(void)postComment{
    
    NSDictionary * bodyParameters;
    if (self.commentModel) {
     
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"commentable_type":@"article",@"commentable_id":[NSString stringWithFormat:@"%ld",self.commentModel.commentable_id],@"content":self.textView.text,@"pid":[NSString stringWithFormat:@"%ld",self.commentModel.comId]};
        self.commentModel = nil;
    }
    else{
        
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"commentable_type":@"article",@"commentable_id":[NSString stringWithFormat:@"%ld",self.forumArticleModel.ArticleId],@"content":self.textView.text};
    }
    NSDictionary * configurationDic = @{@"requestUrlStr":PostComment,@"bodyParameters":bodyParameters};
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
                    [weakSelf.postCommentView removeFromSuperview];
                }
                else{
                    
                    [MBProgressHUD wj_showError:@"回帖失败"];
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

//收藏文章
-(void)collectArticle{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"id":[NSString stringWithFormat:@"%ld",self.forumArticleModel.ArticleId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":ArticleMarkered,@"bodyParameters":bodyParameters};
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
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
