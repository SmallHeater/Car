//
//  CommentBaseCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentBaseCell.h"
#import "SHImageAndTitleBtn.h"

@interface CommentBaseCell ()

@property (nonatomic,strong) UIImageView * avatarImageView;
@property (nonatomic,strong) UILabel * nickNameLabel;
//点赞，点赞数按钮
@property (nonatomic,strong) SHImageAndTitleBtn * praiseBtn;
@property (nonatomic,strong) UILabel * timeLabel;
//回复按钮
@property (nonatomic,strong) UIButton * replyBtn;
//楼
@property (nonatomic,strong) UILabel * floorLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;

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
        [_praiseBtn refreshTitle:@"0" color:Color_333333];
    }
    return _praiseBtn;
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
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.bottom.offset(-11);
        make.height.offset(21);
        make.width.offset(70);
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
        make.width.offset(20);
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
     
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:commentModel.from_user[@"avatar"]]]];
        self.nickNameLabel.text = [NSString repleaseNilOrNull:commentModel.from_user[@"shop_name"]];
        self.timeLabel.text = [NSString repleaseNilOrNull:commentModel.createtime];
    }
}

@end
