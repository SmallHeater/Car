//
//  PostListCell.m
//  Car
//
//  Created by mac on 2019/10/26.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostListCell.h"

@interface PostListCell ()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * titleLabel;
//浏览量，来源
@property (nonatomic,strong) UILabel * pageviewsLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation PostListCell

#pragma mark  ----  懒加载

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _iconImageView.layer.masksToBounds = YES;
//        _iconImageView.layer.cornerRadius = 5;
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT17;
        _titleLabel.textColor = Color_333333;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)pageviewsLabel{
    
    if (!_pageviewsLabel) {
        
        _pageviewsLabel = [[UILabel alloc] init];
        _pageviewsLabel.font = FONT12;
        _pageviewsLabel.textColor = Color_999999;
    }
    return _pageviewsLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_DEDEDE;
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
       
        make.left.offset(15);
        make.top.offset(20);
        make.width.offset(113);
        make.height.offset(85);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(18);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.offset(-17);
        make.height.offset(17);
    }];
    
    [self addSubview:self.pageviewsLabel];
    [self.pageviewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.offset(-27);
        make.height.offset(12);
        make.right.offset(-17);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
}

//imageUrl,图片地址;title,标题;pv,NSNumber,浏览量;section_title,来源;
-(void)show:(NSDictionary *)dic{
    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        
        NSString * imageStr = @"";
        if ([dic.allKeys containsObject:@"imageUrl"]) {
            
            imageStr = dic[@"imageUrl"];
        }
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        
        NSString * title = @"";
        if ([dic.allKeys containsObject:@"title"]) {
            
            title = dic[@"title"];
        }
        self.titleLabel.text = title;
        float labelHeight = [title heightWithFont:FONT17 andWidth:MAINWIDTH - 46];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.offset(labelHeight);
        }];
        
        NSUInteger pv = 0;
        if ([dic.allKeys containsObject:@"pv"]) {
            
            NSNumber * pvNumber = dic[@"pv"];
            pv = pvNumber.integerValue;
        }
        
        NSString * section_title = @"";
        if ([dic.allKeys containsObject:@"section_title"]) {
            
            section_title = dic[@"section_title"];
        }
        
        NSString * pageviewsAndSourceStr = [[NSString alloc] initWithFormat:@"%ld浏览量 / %@",pv,section_title];
        self.pageviewsLabel.text = pageviewsAndSourceStr;
    }
}


@end
