//
//  CommentBaseCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentBaseCell.h"
#import "SHImageAndTitleBtn.h"
#import "UserInforController.h"

@interface CommentBaseCell ()

@property (nonatomic,strong) UIImageView * avatarImageView;
@property (nonatomic,strong) UILabel * nickNameLabel;
//点赞，点赞数按钮
@property (nonatomic,strong) SHImageAndTitleBtn * praiseBtn;
//原文
@property (nonatomic,strong) UILabel * originalTitleLabel;
@property (nonatomic,strong) UILabel * timeLabel;
//回复按钮
@property (nonatomic,strong) UIButton * replyBtn;
//楼
@property (nonatomic,strong) UILabel * floorLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

@property (nonatomic,strong) CommentModel * model;


@end

@implementation CommentBaseCell

#pragma mark  ----  懒加载

-(UIImageView *)avatarImageView{
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 16;
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _avatarImageView;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = FONT15;
        _nickNameLabel.textColor = Color_333333;
    }
    return _nickNameLabel;
}

-(SHImageAndTitleBtn *)praiseBtn{
    
    if (!_praiseBtn) {
        
        _praiseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 19 - 19, 15, 19, 32) andImageFrame:CGRectMake(0, 0, 19, 19) andTitleFrame:CGRectMake(0, 22, 19, 10) andImageName:@"dianzan" andSelectedImageName:@"dianzanxuanzhong" andTitle:@"0"];
        [_praiseBtn refreshFont:FONT10];
        __weak typeof(self) weakSelf = self;
        [[_praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.selected = !x.selected;
            [weakSelf commentLike];
        }];
    }
    return _praiseBtn;
}

-(UILabel *)originalTitleLabel{
    
    if (!_originalTitleLabel) {
        
        _originalTitleLabel = [[UILabel alloc] init];
        _originalTitleLabel.font = FONT12;
        _originalTitleLabel.textColor = Color_495B73;
        _originalTitleLabel.backgroundColor = Color_F0F2F7;
    }
    return _originalTitleLabel;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT12;
        _timeLabel.textColor = Color_9B9B9B;
    }
    return _timeLabel;
}

-(UIButton *)replyBtn{
    
    if (!_replyBtn) {
        
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_replyBtn setTitleColor:Color_333333 forState:UIControlStateNormal];
        _replyBtn.titleLabel.font = FONT12;
        
        [[_replyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PINGLUNHUIFU" object:@{@"CommentModel":self.model}];
        }];
    }
    return _replyBtn;
}

-(UILabel *)floorLabel{
    
    if (!_floorLabel) {
        
        _floorLabel = [[UILabel alloc] init];
        _floorLabel.font = FONT10;
        _floorLabel.textColor = Color_9B9B9B;
        _floorLabel.textAlignment = NSTextAlignmentRight;
    }
    return _floorLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _bottomLineLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawBaseUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithModel:(CommentModel *)model{
    
    float cellHeight = 0;
    
    if (model.disabledswitch) {
        
        //删除评论样式
        cellHeight = 131;
    }
    else{
        
        if (model.to_user && [model.to_user isKindOfClass:[CommentToUserModel class]]) {
            
            //有回复
            float contentHeight = [[NSString repleaseNilOrNull:model.content] heightWithFont:FONT16 andWidth:MAINWIDTH - 59 - 16];
            float contentTwoHeight = [[NSString repleaseNilOrNull:model.to_user.comment] heightWithFont:FONT16 andWidth:MAINWIDTH - 59 - 16 - 5];
            float titleHeight = 0;
            if (![NSString strIsEmpty:model.commentable_title]) {
                
                titleHeight = 35 + 20;
            }
            cellHeight = 59 + 40 + contentHeight + 10 + 22 + 5 + contentTwoHeight + titleHeight;
        }
        else{
            
            float contentHeight = [[NSString repleaseNilOrNull:model.content] heightWithFont:FONT16 andWidth:MAINWIDTH - 59 - 16];
            float titleHeight = 0;
            if (![NSString strIsEmpty:model.commentable_title]) {
                
                titleHeight = 35 + 20;
            }
            cellHeight = 59 + 40 + contentHeight + titleHeight;
        }
    }
    return cellHeight;
}

-(void)drawBaseUI{
    
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(15);
        make.width.height.offset(32);
    }];
    
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        make.top.offset(21);
        make.right.offset(40);
        make.height.offset(21);
    }];
    
    [self addSubview:self.praiseBtn];
    
    [self addSubview:self.originalTitleLabel];
    [self.originalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(59);
        make.right.offset(-16);
        make.height.offset(0);
        make.bottom.offset(-42);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.bottom.offset(-11);
        make.height.offset(21);
        make.width.offset(75);
    }];
    
    [self addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.width.offset(26);
        make.height.equalTo(self.timeLabel.mas_height);
        make.bottom.equalTo(self.timeLabel.mas_bottom);
    }];
    
    [self addSubview:self.floorLabel];
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-19);
        make.width.offset(30);
        make.bottom.equalTo(self.timeLabel.mas_bottom);
        make.height.equalTo(self.timeLabel.mas_height);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.timeLabel.mas_left);
        make.bottom.offset(0);
        make.right.equalTo(self.floorLabel.mas_right);
        make.height.offset(1);
    }];
}

-(void)show:(CommentModel *)commentModel{
    
    if (commentModel && [commentModel isKindOfClass:[commentModel class]]) {
     
        self.model = commentModel;
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:commentModel.from_user.avatar]]];
        self.nickNameLabel.text = [NSString repleaseNilOrNull:commentModel.from_user.shop_name];
        [self.praiseBtn refreshTitle:[NSString stringWithFormat:@"%ld",(long)commentModel.thumbs]];
        self.timeLabel.text = [NSString repleaseNilOrNull:commentModel.createtime];
        self.floorLabel.text = [NSString repleaseNilOrNull:commentModel.floor];
        self.praiseBtn.selected = commentModel.thumbed;
        if (![NSString strIsEmpty:self.model.commentable_title]) {
            
            [self.originalTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(59);
                make.right.offset(-16);
                make.height.offset(35);
                make.bottom.offset(-42);
            }];
            self.originalTitleLabel.text = [NSString stringWithFormat:@"原文：%@",self.model.commentable_title];
        }
    }
}

//点赞
-(void)commentLike{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"id":[NSString stringWithFormat:@"%ld",(long)self.model.comId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":CommentThumb,@"bodyParameters":bodyParameters};
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
