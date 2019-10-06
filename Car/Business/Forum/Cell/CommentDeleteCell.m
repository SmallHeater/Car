//
//  CommentDeleteCell.m
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentDeleteCell.h"

@interface CommentDeleteCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * contentLabel;

@end

@implementation CommentDeleteCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qinquantishi"]];
    }
    return _iconImageView;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT14;
        _contentLabel.textColor = Color_495B73;
        _contentLabel.text = @"      该楼已被删除";
        _contentLabel.backgroundColor = Color_F0F2F7;
    }
    return _contentLabel;
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
        make.height.offset(31);
    }];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(64);
        make.top.offset(67);
        make.width.height.offset(16);
    }];
}

-(void)show:(CommentModel *)commentModel{
    
    [super show:commentModel];
}

@end
