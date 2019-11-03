//
//  CommentCell.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CommentNoReplyCell.h"

@interface CommentNoReplyCell ()

@property (nonatomic,strong) UILabel * contentLabel;

@end

@implementation CommentNoReplyCell

#pragma mark  ----  懒加载

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT16;
        _contentLabel.textColor = Color_333333;
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
        make.bottom.offset(-40);
    }];
}

-(void)show:(CommentModel *)commentModel{
    
    [super show:commentModel];
    self.contentLabel.text = [NSString repleaseNilOrNull:commentModel.content];
}

@end
