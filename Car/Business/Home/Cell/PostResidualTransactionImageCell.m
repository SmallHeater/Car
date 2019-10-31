//
//  PostResidualTransactionImageCell.m
//  Car
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostResidualTransactionImageCell.h"
#import "SHImageViewWithDeleteBtn.h"
#import "SHBaiDuBosControl.h"
#import "SHImageCompressionController.h"


#define BTNBASETAG 1600

@interface PostResidualTransactionImageCell ()

//灰条
@property (nonatomic,strong) UILabel * topLineLabel;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//添加图片按钮
@property (nonatomic,strong) UIButton * addImageBtn;
//存放图片地址的数组
@property (nonatomic,strong) NSMutableArray * imageArray;
//存储图片按钮的数组
@property (nonatomic,strong) NSMutableArray<SHImageViewWithDeleteBtn *> * imageViewDeleteBtnArray;
//存放大图浏览数据的数组
@property (nonatomic,strong) NSMutableArray<UIImage *> * bigPictureDataArray;
//图片数
@property (nonatomic,assign) NSUInteger imageCount;

@end

@implementation PostResidualTransactionImageCell

#pragma mark  ----  懒加载

-(UILabel *)topLineLabel{
    
    if (!_topLineLabel) {
        
        _topLineLabel = [[UILabel alloc] init];
        _topLineLabel.backgroundColor = Color_EEEEEE;
    }
    return _topLineLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT16;
        _titleLabel.textColor = Color_666666;
        _titleLabel.text = @"照片上传（最多8张）";
    }
    return _titleLabel;
}

-(NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

-(NSMutableArray<SHImageViewWithDeleteBtn *> *)imageViewDeleteBtnArray{
    
    if (!_imageViewDeleteBtnArray) {
        
        _imageViewDeleteBtnArray = [[NSMutableArray alloc] init];
    }
    return _imageViewDeleteBtnArray;
}

-(NSMutableArray<UIImage *> *)bigPictureDataArray{
    
    if (!_bigPictureDataArray) {
        
        _bigPictureDataArray = [[NSMutableArray alloc] init];
    }
    return _bigPictureDataArray;
}

-(UIButton *)addImageBtn{
    
    if (!_addImageBtn) {
        
        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageBtn setImage:[UIImage imageNamed:@"tianjiatupian2"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_addImageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.userInteractionEnabled = NO;
            [SHRoutingComponent openURL:GETIMAGE withParameter:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:8 - weakSelf.imageArray.count],@"sourceType":[NSNumber numberWithInteger:0]} callBack:^(NSDictionary *resultDic) {
                
                if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
                    
                    NSArray * dataArray = resultDic[@"data"];
                    [weakSelf.imageArray addObjectsFromArray:dataArray];
                    [weakSelf createImageViews];
                }
            }];
            x.userInteractionEnabled = YES;
        }];
    }
    return _addImageBtn;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.topLineLabel];
    [self.topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(10);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(17);
        make.top.equalTo(self.topLineLabel.mas_bottom).offset(24);
        make.right.offset(-17);
        make.height.offset(16);
    }];
    
    [self addSubview:self.addImageBtn];
    [self.addImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(26);
        make.width.height.offset(108);
    }];
}


//创建图片
-(void)createImageViews{
    
    //移除所有imageView
    for (SHImageViewWithDeleteBtn * imageViewWithBtn in self.imageViewDeleteBtnArray) {
        
        [imageViewWithBtn removeFromSuperview];
    }
    
    [self.bigPictureDataArray removeAllObjects];
    
    //图片总数
    NSUInteger imageCount = self.imageArray.count;
    self.imageCount = imageCount;
    float imageViewLeft = 15;
    float imageViewTop = 76;
    float imageWidthHeight = 108;
    float interval = (MAINWIDTH - imageViewLeft * 2 - imageWidthHeight * 3) / 2.0;
    
    __weak typeof(self) weakSelf = self;
    for (NSUInteger i = 0; i < imageCount; i++) {
        
        NSDictionary * dic = self.imageArray[i];
        UIImage * thumbnailsImage = dic[@"thumbnails"];
        [self.bigPictureDataArray addObject:thumbnailsImage];
        SHImageViewWithDeleteBtn * imageViewWithBtn = [[SHImageViewWithDeleteBtn alloc] initWithImage:thumbnailsImage andButtonTag:BTNBASETAG + i];
        imageViewWithBtn.deleteCallBack = ^(NSUInteger btnTag) {
            
            [weakSelf.imageArray removeObjectAtIndex:btnTag - BTNBASETAG];
            [weakSelf createImageViews];
        };
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            [weakSelf imageTaped:x];
        }];
        [imageViewWithBtn addGestureRecognizer:tap];
        
        [self addSubview:imageViewWithBtn];
        [self.imageViewDeleteBtnArray addObject:imageViewWithBtn];
        [imageViewWithBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(imageViewLeft);
            make.top.offset(imageViewTop);
            make.width.height.offset(imageWidthHeight);
        }];
        imageViewLeft += imageWidthHeight + interval;
        if (i == 2 || i == 5) {
            
            imageViewTop += imageWidthHeight + 10;
            imageViewLeft = 15;
        }
    }
    
    [self.addImageBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(imageViewLeft);
        make.top.offset(imageViewTop);
        make.width.height.offset(imageWidthHeight);
    }];
}

-(void)imageTaped:(UITapGestureRecognizer *)gesture{
    
    UIView * view = gesture.view;
    NSUInteger index = view.tag - BTNBASETAG;
    [SHRoutingComponent openURL:BIGPICTUREBROWSING withParameter:@{@"dataArray":self.bigPictureDataArray,@"selectedIndex":[NSNumber numberWithInteger:index]}];
}

//主动上传图片
-(void)uploadImageCallBack:(CallBack)callBack{
    
    NSMutableString * imagesUrlStr = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < self.bigPictureDataArray.count; i++) {
        
        UIImage * image = self.bigPictureDataArray[i];
        NSData * imageData = UIImageJPEGRepresentation(image,1);
        if (!imageData) {
            
            imageData = UIImagePNGRepresentation(image);
        }
        //压缩
        float length = [imageData length] / 1000.0;
        float ratio = [SHImageCompressionController getCompressionFactorWithLength:length andExpextLength:600];
        NSData * usedImageData = UIImageJPEGRepresentation(image, ratio);
        UIImage * usedImage = [UIImage imageWithData:usedImageData];
        [[SHBaiDuBosControl sharedManager] uploadImage:usedImage callBack:^(NSString * _Nonnull imagePath) {
            
            if (i == 0) {
                
                [imagesUrlStr appendString:imagePath];
            }
            else{
                
                [imagesUrlStr appendFormat:@",%@",imagePath];
            }
        }];
    }
    
    callBack(imagesUrlStr);
}

@end
