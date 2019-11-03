//
//  FormDetailImgCell.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FormDetailImgCell.h"

@interface FormDetailImgCell ()

@property (nonatomic,strong) UIImageView * contentImageView;

@end

@implementation FormDetailImgCell

#pragma mark  ----  懒加载

-(UIImageView *)contentImageView{
    
    if (!_contentImageView) {
        
        _contentImageView = [[UIImageView alloc] init];
    }
    return _contentImageView;
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
    
    [self addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

-(void)showImageUrl:(NSString *)str{
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:str]]];
}

@end
