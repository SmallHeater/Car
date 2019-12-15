//
//  ForumDetaiADCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetaiADCell.h"

@interface ForumDetaiADCell ()

@property (nonatomic,strong) UIImageView * adImageView;
@property (nonatomic,strong) UILabel * adLabel;

@end

@implementation ForumDetaiADCell

#pragma mark  ----  懒加载

-(UIImageView *)adImageView{
    
    if (!_adImageView) {
        
        _adImageView = [[UIImageView alloc] init];
        _adImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _adImageView;
}

-(UILabel *)adLabel{
    
    if (!_adLabel) {
        
        _adLabel = [[UILabel alloc] init];
        _adLabel.font = FONT10;
        _adLabel.textColor = Color_999999;
        _adLabel.text = @"广告 ATHM";
    }
    return _adLabel;
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

+(float)cellHeightWithModel:(ForumArticleModel *)model{
    
    float cellHeight = 0;
    cellHeight += 192.0 / 343.0 * (MAINWIDTH - 32);
    cellHeight += 45;
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.adImageView];
    [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(0);
        make.height.offset(192.0 / 343.0 * (MAINWIDTH - 32));
    }];
    
    [self addSubview:self.adLabel];
    [self.adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.adImageView.mas_left);
        make.top.equalTo(self.adImageView.mas_bottom).offset(5);
        make.width.equalTo(self.adImageView.mas_width);
        make.height.offset(20);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    if (model.ad && [model.ad isKindOfClass:[ADModel class]]) {
    
        if (model.ad.imageHeight > 0) {
            
            [self.adImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(16);
                make.right.offset(-16);
                make.top.offset(0);
                make.height.offset(model.ad.imageHeight);
            }];
        }
        
        __weak typeof(self) weakSelf = self;
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.ad.image]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (image) {

                if (model.ad.imageHeight > 0) {

                }
                else{

                    model.ad.imageWidth = (MAINWIDTH - 32);
                    model.ad.imageHeight = (MAINWIDTH - 32) * image.size.height / image.size.width;
                    if (weakSelf.refresh) {

                        weakSelf.refresh();
                    }
                }
            }
        }];
    }
}

@end
