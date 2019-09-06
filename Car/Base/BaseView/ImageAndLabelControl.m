//
//  ImageAndLabelControl.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ImageAndLabelControl.h"

typedef NS_ENUM(NSUInteger,ImageType){
    
    ImageType_LocalImage = 0,//本地图片
    ImageType_WebImage//网络图片
};

@interface ImageAndLabelControl ()

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,assign) CGSize imageSize;
@property (nonatomic,assign) ImageType imageType;
@property (nonatomic,strong) NSString * imageName;
@property (nonatomic,strong) NSString * imageUrlStr;
@property (nonatomic,strong) NSString * title;

@end

@implementation ImageAndLabelControl

#pragma mark  ----  懒加载

-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT12;
        _titleLabel.textColor = Color_333333;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithImageName:(NSString *)imageName andImageSize:(CGSize)imageSize andTitle:(NSString *)title{
    
    self = [super init];
    if (self) {
        
        self.imageType = ImageType_LocalImage;
        self.imageName = imageName;
        self.imageSize = imageSize;
        self.title = title;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //需要获取view的frame之后再绘制内部UI
            [self drawUI];
            [self showData];
        });
    }
    return self;
}

-(instancetype)initWithImageUrl:(NSString *)imageUrl andImageSize:(CGSize)imageSize andTitle:(NSString *)title{
    
    self = [super init];
    if (self) {
        
        self.imageType = ImageType_WebImage;
        self.imageUrlStr = imageUrl;
        self.imageSize = imageSize;
        self.title = title;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //需要获取view的frame之后再绘制内部UI
            [self drawUI];
            [self showData];
        });
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(0);
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(self.imageSize.width);
        make.height.offset(self.imageSize.height);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.offset(12);
    }];
}

-(void)showData{
    
    if (self.imageType == ImageType_LocalImage) {
        
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
    else if (self.imageType == ImageType_WebImage){
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlStr]];
    }
    
    self.titleLabel.text = [NSString repleaseNilOrNull:self.title];
}

@end
