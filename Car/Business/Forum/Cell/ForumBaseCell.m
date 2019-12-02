//
//  ForumBaseCell.m
//  Car
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumBaseCell.h"
#import "SHImageAndTitleBtn.h"


@interface ForumBaseCell ()

//头像
@property (nonatomic,strong) UIImageView * avatarImageView;
//昵称
@property (nonatomic,strong) UILabel * nickNameLabel;
//时间
@property (nonatomic,strong) UILabel * timeLabel;
//内容
@property (nonatomic,strong) UILabel * contentLabel;
//浏览量和来源
@property (nonatomic,strong) UILabel * viewsAndSourceLabel;
//赞
@property (nonatomic,strong) SHImageAndTitleBtn * thumbsUpBtn;
//评论
@property (nonatomic,strong) SHImageAndTitleBtn * commentBtn;
//分享
@property (nonatomic,strong) SHImageAndTitleBtn * sharepBtn;
//底部分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;

@end

@implementation ForumBaseCell

#pragma mark  ----  懒加载

-(UIImageView *)avatarImageView{
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 18;
    }
    return _avatarImageView;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = BOLDFONT15;
        _nickNameLabel.textColor = Color_333333;
    }
    return _nickNameLabel;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT12;
        _timeLabel.textColor = Color_999999;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT17;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

-(UILabel *)viewsAndSourceLabel{
    
    if (!_viewsAndSourceLabel) {
        
        _viewsAndSourceLabel = [[UILabel alloc] init];
        _viewsAndSourceLabel.font = FONT12;
        _viewsAndSourceLabel.textColor = Color_999999;
    }
    return _viewsAndSourceLabel;
}

-(SHImageAndTitleBtn *)thumbsUpBtn{

    if (!_thumbsUpBtn) {

        _thumbsUpBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 115, CGRectGetHeight(self.frame) - 42, 28, 24) andImageFrame:CGRectMake(0, 10, 13, 13) andTitleFrame:CGRectMake(13, 0, 15, 10) andImageName:@"luntanzan" andSelectedImageName:@"luntanzan" andTitle:@"0"];
        [_thumbsUpBtn refreshFont:FONT10];
        [_thumbsUpBtn refreshColor:Color_666666];
        _thumbsUpBtn.userInteractionEnabled = NO;
    }
    return _thumbsUpBtn;
}

-(SHImageAndTitleBtn *)commentBtn{
    
    if (!_commentBtn) {
        
        _commentBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 76, CGRectGetMinY(self.thumbsUpBtn.frame), 28, CGRectGetHeight(self.thumbsUpBtn.frame)) andImageFrame:CGRectMake(0, 10, 13, 13) andTitleFrame:CGRectMake(13, 0, 15, 10) andImageName:@"luntanpinglun" andSelectedImageName:@"luntanpinglun" andTitle:@"0"];
        [_commentBtn refreshFont:FONT10];
        [_commentBtn refreshColor:Color_666666];
        _commentBtn.userInteractionEnabled = NO;
    }
    return _commentBtn;
}

-(SHImageAndTitleBtn *)sharepBtn{
    
    if (!_sharepBtn) {
        
        _sharepBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(MAINWIDTH - 36, CGRectGetMinY(self.thumbsUpBtn.frame), 30, CGRectGetHeight(self.thumbsUpBtn.frame)) andImageFrame:CGRectMake(0, 10, 15, 15) andTitleFrame:CGRectMake(15, 0, 15, 10) andImageName:@"luntanfenxiang" andSelectedImageName:@"luntanfenxiang" andTitle:@""];
        _sharepBtn.userInteractionEnabled = NO;
    }
    return _sharepBtn;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_DEDEDE;
    }
    return _bottomLineLabel;
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

+(float)cellHeightWithTitle:(NSString *)title{
    
    float cellHeight = 0;
    cellHeight += 73;
    cellHeight += [title heightWithFont:FONT17 andWidth:MAINWIDTH - 15 * 2];
    cellHeight += 45;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(19);
        make.width.height.offset(36);
    }];
    
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatarImageView.mas_right).offset(9);
        make.top.equalTo(self.avatarImageView.mas_top).offset(2);
        make.right.offset(-15);
        make.height.offset(15);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(7);
        make.width.equalTo(self.nickNameLabel.mas_width);
        make.height.offset(12);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(18);
        make.right.offset(-15);
        make.height.offset(41);
    }];
    
    [self addSubview:self.viewsAndSourceLabel];
    [self.viewsAndSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatarImageView.mas_left);
        make.bottom.offset(-15);
        make.height.offset(12);
        make.right.offset(-120);
    }];
    
    [self addSubview:self.thumbsUpBtn];
    [self.thumbsUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-90);
        make.bottom.offset(-15);
        make.width.offset(30);
        make.height.offset(24);
    }];
    
    [self addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-49);
        make.bottom.offset(-15);
        make.width.offset(30);
        make.height.offset(24);
    }];
    
    [self addSubview:self.sharepBtn];
    [self.sharepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.bottom.offset(-15);
        make.width.offset(30);
        make.height.offset(24);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

//avatar,头像;nickName,昵称;time,时间;views,浏览量;source,来源;title,标题;
-(void)show:(ForumArticleModel *)model{
    
    NSString * avatar = [NSString repleaseNilOrNull:model.from_user.avatar];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar]];
    
    NSString * nickName = [NSString repleaseNilOrNull:model.from_user.shop_name];
    self.nickNameLabel.text = nickName;
    
    NSDate * date = model.createtime;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString * time = [formatter stringFromDate:date];
    self.timeLabel.text = time;
    
    NSString * title = [NSString repleaseNilOrNull:model.title];
    self.contentLabel.text = title;
    float contentHeight = [title heightWithFont:FONT17 andWidth:MAINWIDTH - 15 * 2];
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.offset(contentHeight);
    }];
    
    
    NSString * views = [[NSString alloc] initWithFormat:@"%ld",model.pv];
    NSString * source = [NSString repleaseNilOrNull:model.section_title];
    self.viewsAndSourceLabel.text = [[NSString alloc] initWithFormat:@"%@浏览量 / %@",views,source];
    
    [self.thumbsUpBtn refreshTitle:[[NSString alloc] initWithFormat:@"%ld",model.thumbs]];
    [self.commentBtn refreshTitle:[[NSString alloc] initWithFormat:@"%ld",model.comments]];
}

@end
