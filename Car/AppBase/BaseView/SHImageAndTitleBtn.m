//
//  ImageAndTitleBtn.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//

#import "SHImageAndTitleBtn.h"

@interface SHImageAndTitleBtn ()

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * imageStrLabel;
@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,copy) NSString * selectedImageName;

@end

@implementation SHImageAndTitleBtn

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
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = Color_333333;
    }
    return _titleLabel;
}

-(UILabel *)imageStrLabel{
    
    if (_imageStrLabel == nil) {
        
        _imageStrLabel = [[UILabel alloc] init];
        _imageStrLabel.font = BOLDFONT21;
        _imageStrLabel.textColor = [UIColor whiteColor];
        _imageStrLabel.textAlignment = NSTextAlignmentCenter;
        _imageStrLabel.hidden = YES;
    }
    return _imageStrLabel;
}

#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        if (![NSString strIsEmpty:imageName]) {
        
            self.imageView.image = [UIImage imageNamed:imageName];
        }
        
        self.imageView.frame = imageFrame;
        self.titleLabel.frame = titleFrame;
        self.titleLabel.text = title;
        
        self.imageName = imageName;
        self.selectedImageName = selectedImageName;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self.imageView addSubview:self.imageStrLabel];
        [self.imageStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

#pragma mark  ----  自定义函数

//刷新文字
-(void)refreshTitle:(NSString *)title{
    
    if (title) {
        
        self.titleLabel.text = title;
    }
}
//刷新色值
-(void)refreshColor:(UIColor *)textColor{
    
    if (textColor) {
        
        self.titleLabel.textColor = textColor;
    }
}

//刷新字号
-(void)refreshFont:(UIFont *)labelFont{
    
    if (labelFont) {
        
        self.titleLabel.font = labelFont;
    }
}

#pragma mark  ---- SET
-(void)setSelected:(BOOL)selected{
    
    super.selected = selected;
    if (selected) {
        
        self.imageView.image = [UIImage imageNamed:self.selectedImageName];
    }
    else{
        
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
}

//刷新图片
-(void)refreshImage:(NSString *)imageName orImageUrlStr:(NSString *)imageUrlStr{
    
    if (![NSString strIsEmpty:imageName]) {
        
        self.imageView.image = [UIImage imageNamed:imageName];
    }
    else if (![NSString strIsEmpty:imageUrlStr]){
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    }
}

//设置图片圆角
-(void)setImageViewCornerRadius:(float)cornerRadius{
    
    self.imageView.layer.cornerRadius = cornerRadius;
    self.imageView.layer.masksToBounds = YES;
}

//设置图片地址
-(void)setImageUrl:(NSString *)imageUrl{
    
    if (![NSString strIsEmpty:imageUrl]) {
     
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
}

//图片上显示内容
-(void)showImageStr:(NSString *)imageStr{
    
    self.imageStrLabel.hidden = NO;
    self.imageStrLabel.text = [NSString repleaseNilOrNull:imageStr];
}

@end
