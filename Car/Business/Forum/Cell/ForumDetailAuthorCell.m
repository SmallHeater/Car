//
//  ForumDetailAuthorCell.m
//  Car
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailAuthorCell.h"

@interface ForumDetailAuthorCell ()

//头像
@property (nonatomic,strong) UIImageView * avatarImageView;
//昵称
@property (nonatomic,strong) UILabel * nickNameLabel;
//浏览量和日期
@property (nonatomic,strong) UILabel * pageviewsAndDateLabel;
//看TA
@property (nonatomic,strong) UIButton * attentionBtn;

@end

@implementation ForumDetailAuthorCell

#pragma mark  ----  懒加载

-(UIImageView *)avatarImageView{
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20;
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _avatarImageView;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = FONT14;
        _nickNameLabel.textColor = Color_108EE9;
    }
    return _nickNameLabel;
}

-(UILabel *)pageviewsAndDateLabel{
    
    if (!_pageviewsAndDateLabel) {
        
        _pageviewsAndDateLabel = [[UILabel alloc] init];
        _pageviewsAndDateLabel.font = FONT12;
        _pageviewsAndDateLabel.textColor = Color_9B9B9B;
    }
    return _pageviewsAndDateLabel;
}

-(UIButton *)attentionBtn{
    
    if (!_attentionBtn) {
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionBtn setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(attentionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.bottom.offset(0);
        make.width.offset(40);
    }];
    
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatarImageView.mas_right).offset(16);
        make.top.offset(0);
        make.right.offset(-82);
        make.height.offset(21);
    }];
    
    [self addSubview:self.pageviewsAndDateLabel];
    [self.pageviewsAndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.bottom.offset(0);
        make.width.equalTo(self.nickNameLabel.mas_width);
        make.height.offset(18);
    }];
    
    [self addSubview:self.attentionBtn];
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.top.offset(4);
        make.width.offset(66);
        make.height.offset(32);
    }];
}

-(void)attentionBtnClicked:(UIButton *)btn{
    
}

-(void)show:(ForumArticleModel *)model{
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.from_user.avatar]]];
    self.nickNameLabel.text = [NSString repleaseNilOrNull:model.from_user.nick_name];
 
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    NSString * dateStr = [formatter stringFromDate:model.createtime];
    self.pageviewsAndDateLabel.text = [[NSString alloc] initWithFormat:@"%ld 浏览量/%@",model.pv,dateStr];
}


@end
