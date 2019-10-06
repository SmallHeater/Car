//
//  ForumDetailCommentListCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailCommentListCell.h"
#import "UserInforController.h"
#import "CommentModel.h"
#import "CommentDeleteCell.h"

static NSString * CommentDeleteCellId = @"CommentDeleteCell";

@interface ForumDetailCommentListCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) float cellHeight;

@property (nonatomic,strong) ForumArticleModel * model;
@property (nonatomic,strong) UIView * headerView;
//全部回复按钮
@property (nonatomic,strong) UIButton * replyAllBtn;
//只看楼主按钮
@property (nonatomic,strong) UIButton * onlyLandlordBtn;
//页码
@property (nonatomic,strong) UILabel * pagesLabel;
//三角图标
@property (nonatomic,strong) UIImageView * triangleImageView;
@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<CommentModel *> * dataArray;


@end

@implementation ForumDetailCommentListCell

#pragma mark  ----  懒加载

-(UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] init];
        
        [_headerView addSubview:self.replyAllBtn];
        [self.replyAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.top.offset(0);
            make.width.offset(95);
            make.height.offset(33);
        }];
        
        [_headerView addSubview:self.onlyLandlordBtn];
        [self.onlyLandlordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.replyAllBtn.mas_right).offset(25);
            make.top.offset(9);
            make.width.offset(65);
            make.height.offset(21);
        }];
        
        [_headerView addSubview:self.pagesLabel];
        [self.pagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.offset(32);
            make.height.offset(21);
            make.right.offset(-34);
            make.top.offset(9);
        }];
        
        [_headerView addSubview:self.triangleImageView];
        [self.triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.offset(8);
            make.right.offset(-16);
            make.top.offset(15);
        }];
    }
    return _headerView;
}

-(UIButton *)replyAllBtn{
    
    if (!_replyAllBtn) {
        
        _replyAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyAllBtn setTitle:@"全部回复" forState:UIControlStateNormal];
        [_replyAllBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        _replyAllBtn.titleLabel.font = BOLDFONT23;
        _replyAllBtn.selected = YES;
        [[_replyAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _replyAllBtn;
}

-(UIButton *)onlyLandlordBtn{
    
    if (!_onlyLandlordBtn) {
        
        _onlyLandlordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_onlyLandlordBtn setTitle:@"只看楼主" forState:UIControlStateNormal];
        [_onlyLandlordBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        _onlyLandlordBtn.titleLabel.font = FONT15;
        [[_onlyLandlordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _onlyLandlordBtn;
}

-(UILabel *)pagesLabel{
    
    if (!_pagesLabel) {
        
        _pagesLabel = [[UILabel alloc] init];
        _pagesLabel.font = FONT15;
        _pagesLabel.textColor = Color_333333;
    }
    return _pagesLabel;
}

-(UIImageView *)triangleImageView{
    
    if (!_triangleImageView) {
        
        _triangleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiasanjiao"]];
    }
    return _triangleImageView;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray<CommentModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentModel * model = self.dataArray[indexPath.row];
    return [CommentBaseCell cellHeightWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight = 33;
    return headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headerView;
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
    return nil;
}

#pragma mark  ----  自定义函数

-(void)show:(ForumArticleModel *)model{
    
    if (model && [model isKindOfClass:[ForumArticleModel class]]) {
        
        self.model = model;
        [self requestData];
    }
}

-(void)drawUI{
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)requestData{
    
    self.pagesLabel.text = @"1 / 3";
    self.cellHeight = MAINHEIGHT - [UIScreenControl navigationBarHeight];
    //commentable_type,评论类型：article（文章）、video(视频)
    NSDictionary * bodyParameters = @{@"user_id":@"1",@"commentable_type":@"article",@"commentable_id":[[NSString alloc] initWithFormat:@"%ld",2]};
    NSDictionary * configurationDic = @{@"requestUrlStr":Comments,@"bodyParameters":bodyParameters};
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
