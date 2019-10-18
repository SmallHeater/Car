//
//  MotorOilCommentCell.m
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilCommentCell.h"

@interface MotorOilCommentCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * dateLabel;
//评价
@property (nonatomic,strong) UILabel * commentLabel;
//内容
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation MotorOilCommentCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 18;
    }
    return _iconImageView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT12;
        _nameLabel.textColor = Color_333333;
    }
    return _nameLabel;
}

-(UILabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT10;
        _dateLabel.textColor = Color_999999;
    }
    return _dateLabel;
}

-(UILabel *)commentLabel{
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = FONT10;
        _commentLabel.textColor = Color_999999;
        _commentLabel.text = @"评价";
    }
    return _commentLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT12;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
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
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.top.offset(10);
        make.width.height.offset(36);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.offset(-70);
        make.height.offset(17);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(0);
        make.top.offset(13);
        make.width.offset(70);
        make.height.offset(14);
    }];
    [self addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.width.offset(22);
        make.height.offset(14);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.commentLabel.mas_left);
        make.top.equalTo(self.commentLabel.mas_bottom).offset(10);
        make.right.offset(-16);
        make.height.offset(17);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.bottom.right.offset(0);
        make.height.offset(1);
    }];
}

-(void)show:(MotorOilCommentModel *)model{
    
    if (model && [model isKindOfClass:[MotorOilCommentModel class]]) {
        
        NSString * avatarStr = @"";
        NSString * name = @"";
        if (model.from_user && [model.from_user isKindOfClass:[NSDictionary class]]) {
            
            if ([model.from_user.allKeys containsObject:@"avatar"]) {
                
                avatarStr = model.from_user[@"avatar"];
            }
            
            if ([model.from_user.allKeys containsObject:@"shop_name"]) {
                
                name = model.from_user[@"shop_name"];
            }
        }
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:avatarStr]];
        self.nameLabel.text = name;
        self.dateLabel.text = [NSString repleaseNilOrNull:model.createtime];
        
        //星
        NSUInteger score = model.score;
        float imageX = 91;
        for (NSUInteger i = 0; i < 5; i++) {
            
            NSString * imageName;
            if (i < score) {
                
                imageName = @"xinghongse";
            }
            else{
                
                imageName = @"xinghuise";
            }
            UIImageView * starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            [self addSubview:starImageView];
            [starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.offset(imageX);
                make.top.equalTo(self.commentLabel.mas_top).offset(2);
                make.width.height.offset(10);
            }];
            
            imageX += 13;
        }
        
        NSString * content = [NSString repleaseNilOrNull:model.content];
        float contentHeight = 17;
        float contentWidth = [content widthWithFont:FONT12 andHeight:contentHeight];
        if (contentWidth > MAINWIDTH - 66 - 16) {
            
            //两行
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.commentLabel.mas_left);
                make.top.equalTo(self.commentLabel.mas_bottom).offset(10);
                make.right.offset(-16);
                make.height.offset(34);
            }];
        }
        else{
            
            //一行
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.commentLabel.mas_left);
                make.top.equalTo(self.commentLabel.mas_bottom).offset(10);
                make.right.offset(-16);
                make.height.offset(17);
            }];
        }
        self.contentLabel.text = content;
    }
}

@end
