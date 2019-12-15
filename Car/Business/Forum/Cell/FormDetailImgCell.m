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
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
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

+(float)cellHeightWithModel:(ContentListItemModel *)model{
    
    float cellHeight = 0;
    if (model.imageHeight > 0) {
        
        cellHeight = model.imageHeight + 20;
    }
    else{
     
        cellHeight = 192 + 10 *2;
    }
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

-(void)showModel:(ContentListItemModel *)model{
    
    if (model.imageHeight > 0) {
        
        [self.contentImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(16);
            make.right.offset(-16);
            make.top.offset(10);
            make.height.offset(model.imageHeight + 10);
        }];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.content]]];
    }
    else{
        
        __weak typeof(self) weakSelf = self;
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:model.content]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (image) {

                if (model.imageHeight > 0) {

                }
                else{

                    model.imageWidth = (MAINWIDTH - 32);
                    model.imageHeight = (MAINWIDTH - 32) * image.size.height / image.size.width;
                    if (weakSelf.refresh) {

                        weakSelf.refresh();
                    }
                }
            }
        }];
    }
}

@end
