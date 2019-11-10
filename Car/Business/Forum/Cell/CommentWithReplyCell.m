//
//  CommentCell.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentWithReplyCell.h"

@interface CommentWithReplyCell ()

@property (nonatomic,strong) UILabel * contentLabel;
//灰色view
@property (nonatomic,strong) UIView * grayView;
//用户名
@property (nonatomic,strong) UILabel * grayNameLabel;
//内容
@property (nonatomic,strong) UILabel * grayContentLabel;

@end

@implementation CommentWithReplyCell

#pragma mark  ----  懒加载

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT16;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIView *)grayView{
    
    if (!_grayView) {
        
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = Color_F0F2F7;
        
        [_grayView addSubview:self.grayNameLabel];
        [self.grayNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.top.offset(0);
            make.left.offset(5);
            make.height.offset(22);
        }];
        
        [_grayView addSubview:self.grayContentLabel];
        [self.grayContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.grayNameLabel.mas_left);
            make.right.offset(0);
            make.top.equalTo(self.grayNameLabel.mas_bottom).offset(5);
            make.bottom.offset(0);
        }];
    }
    return _grayView;
}

-(UILabel *)grayNameLabel{
    
    if (!_grayNameLabel) {
        
        _grayNameLabel = [[UILabel alloc] init];
        _grayNameLabel.font = FONT10;
        _grayNameLabel.textColor = Color_9B9B9B;
    }
    return _grayNameLabel;
}

-(UILabel *)grayContentLabel{
    
    if (!_grayContentLabel) {
        
        _grayContentLabel = [[UILabel alloc] init];
        _grayContentLabel.font = FONT12;
        _grayContentLabel.textColor = Color_333333;
        _grayContentLabel.numberOfLines = 0;
    }
    return _grayContentLabel;
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

    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(59);
        make.top.offset(59);
        make.right.offset(-16);
        make.height.offset(0);
    }];
    
    [self addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentLabel.mas_left);
        make.right.equalTo(self.contentLabel.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.bottom.offset(-40);
    }];
}

-(void)show:(CommentModel *)commentModel{
    
    [super show:commentModel];
    
    NSString * content = [NSString repleaseNilOrNull:commentModel.content];
    float contentHeight = [[NSString repleaseNilOrNull:content] heightWithFont:FONT16 andWidth:MAINWIDTH - 59 - 16];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(59);
        make.top.offset(59);
        make.right.offset(-16);
        make.height.offset(contentHeight);
    }];
    
    
    if (![NSString strIsEmpty:commentModel.commentable_title]) {
        
        [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentLabel.mas_left);
            make.right.equalTo(self.contentLabel.mas_right);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.bottom.offset(-87);
        }];
    }
    
    self.contentLabel.text = content;
    self.grayNameLabel.text = [NSString stringWithFormat:@"%@ %@ 发表在 %@",commentModel.to_user.shop_name,commentModel.to_user.createtime,commentModel.to_user.floor];
    self.grayContentLabel.text = commentModel.to_user.comment;
}

@end
