//
//  PostManagementViewController.m
//  Car
//
//  Created by xianjun wang on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostManagementViewController.h"
#import "SHTabView.h"
#import "MyPostViewController.h"
#import "ItemListCollectionViewCell.h"
#import "SHBaseCollectionView.h"
#import "MyReplyViewController.h"
#import "SHTextView.h"
#import "UserInforController.h"
#import "CommentModel.h"

static NSString * cellID = @"UICollectionViewCell";
static NSUInteger tabBaseTag = 1650;

@interface PostManagementViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) SHBaseCollectionView * collectionView;

@property (nonatomic,strong) SHTabView * tabView;
//发表评论view
@property (nonatomic,strong) UIView * postCommentView;
@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) SHTextView * textView;
//回复的评论模型
@property (nonatomic,strong) CommentModel * commentModel;
@end

@implementation PostManagementViewController

#pragma mark  ----  懒加载

-(SHTabView *)tabView{
    
    if (!_tabView) {
        
        float tabWidth = MAINWIDTH / 3.0;
        
        NSMutableArray * tabModelsArray = [[NSMutableArray alloc] init];
        NSArray * tabTitleArray = @[@"我的帖子",@"我的回帖",@"回复我的"];
        for (NSUInteger i = 0; i < 3; i++) {
            
            SHTabModel * myPostModel = [[SHTabModel alloc] init];
            myPostModel.tabTitle = tabTitleArray[i];
            myPostModel.normalFont = FONT16;
            myPostModel.normalColor = Color_333333;
            myPostModel.selectedColor = Color_0272FF;
            myPostModel.btnWidth = tabWidth;
            myPostModel.tabTag = tabBaseTag + i;
            [tabModelsArray addObject:myPostModel];
        }
        
        SHTabSelectLineModel * lineModel = [[SHTabSelectLineModel alloc] init];
        lineModel.isShowSelectedLine = YES;
        lineModel.lineWidth = tabWidth;
        lineModel.lineHeight = 1;
        
        _tabView = [[SHTabView alloc] initWithItemsArray:tabModelsArray showRightBtn:NO andSHTabSelectLineModel:lineModel isShowBottomLine:NO];
        _tabView.layer.shadowColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:0.23].CGColor;
        _tabView.layer.shadowOffset = CGSizeMake(1,5);
        _tabView.layer.shadowOpacity = 1;
        _tabView.layer.shadowRadius = 9;
        _tabView.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
        //利用贝瑟尔曲线设置局部阴影
        CGRect shadowRect = CGRectZero;
        CGFloat originX,originY,sizeWith,sizeHeight,shadowPathWidth;
        originX = 0;
        originY = 0;
        sizeWith = MAINWIDTH;
        sizeHeight = 44;
        shadowPathWidth = 4;
        shadowRect = CGRectMake(0, sizeHeight, sizeWith, shadowPathWidth);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
        _tabView.layer.shadowPath = bezierPath.CGPath;//阴影路径
        
        __weak typeof(self) weakSelf = self;
        [[_tabView rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple * _Nullable x) {
            
            UIButton * btn = x.first;
            NSUInteger index = btn.tag - tabBaseTag;
            NSIndexPath * path = [NSIndexPath indexPathForRow:index inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }];
    }
    return _tabView;
}

-(SHBaseCollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[SHBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self registrationNotice];
}

#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        MyPostViewController * myPostVC = [[MyPostViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain];
        [self addChildViewController:myPostVC];
        UIView * view = myPostVC.view;
        view.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44);
        [cell addSubview:view];
    }
    else if (indexPath.row == 1){
        
        MyReplyViewController * vc = [[MyReplyViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain VCType:VCType_MyReply];
        [self addChildViewController:vc];
        UIView * view = vc.view;
        view.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44);
        [cell addSubview:view];
    }
    else if (indexPath.row == 2){
        
        MyReplyViewController * vc = [[MyReplyViewController alloc] initWithTitle:@"" andShowNavgationBar:NO andIsShowBackBtn:NO andTableViewStyle:UITableViewStylePlain VCType:VCType_ReplyToMe];
        [self addChildViewController:vc];
        UIView * view = vc.view;
        view.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - 44);
        [cell addSubview:view];
    }
    
    return cell;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MAINWIDTH, MAINHEIGHT - [SHUIScreenControl navigationBarHeight] - [SHUIScreenControl bottomSafeHeight] - 44);
}

//返回上左下右四边的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//返回cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//cell之间的最小列间距a
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark  ----  UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / MAINWIDTH;
    [self.tabView selectItemWithIndex:index];
}


#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.height.offset(44);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tabView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSDictionary *userInfo = [x userInfo];
        CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
        CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            
            [weakSelf.whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.offset(0);
                make.height.offset(155);
                make.bottom.offset(-rect.size.height);
            }];
        }];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       
        [self.postCommentView removeFromSuperview];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PINGLUNHUIFU" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSDictionary * dic = x.object;
        self.commentModel = dic[@"CommentModel"];
        [[UIApplication sharedApplication].keyWindow addSubview:self.postCommentView];
        [self.textView becomeFirstResponder];
    }];
}

//发表评论
-(void)postComment{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"commentable_type":@"article",@"commentable_id":[NSString stringWithFormat:@"%ld",self.commentModel.commentable_id],@"content":self.textView.text,@"pid":[NSString stringWithFormat:@"%ld",self.commentModel.comId]};
        self.commentModel = nil;
    
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

@end
