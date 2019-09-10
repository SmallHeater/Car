//
//  SHCollectionViewCell.m
//  SHUIImagePickerController
//
//  Created by xianjunwang on 2017/10/24.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SHImageCollectionViewCell.h"

@implementation SHImageCollectionViewCell

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
     
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.selectBtn];
    }
    return self;
}

-(void)dealloc{
    
//    NSLog(@"SHImageCollectionViewCell销毁");
}

#pragma mark  ----  懒加载
-(UIImageView *)imageView{

    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imageView.image = [UIImage imageNamed:@"SHLiveCommonImages.bundle/addImage.tiff"];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(self.frame.size.width - 25, 0, 25, 25);
        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5)];
        [_selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}


@end
